package servlets;

import entity.*;
import jakarta.ejb.EJB;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import session.*;

import java.io.IOException;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "ProductServlet", urlPatterns = {
        "/buyProduct",
        "/addToBag",
        "/shoppingCartForm",
        "/shoppingCart",
        "/deleteFromCart",
        "/usePromoCode",
        "/paymentForm",
        "/payment",
})

public class ProductServlet extends HttpServlet {

    @EJB
    private ProductFacade productFacade;
    @EJB
    private BuyerFacade buyerFacade;
    @EJB
    private HistoryFacade historyFacade;
    @EJB
    private UserRolesFacade userRolesFacade;
    @EJB
    private UserFacade userFacade;
    @EJB
    private PromoCodeFacade promoCodeFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession httpSession = request.getSession(false);
        if (httpSession == null) {
            request.setAttribute("info", "У вас нет права использовать этот ресурс. Войдите!");
            request.getRequestDispatcher("/loginForm").forward(request, response);
            return;
        }
        User user = (User) httpSession.getAttribute("user");
        if (user == null) {
            request.setAttribute("info", "У вас нет права использовать этот ресурс. Войдите!");
            request.getRequestDispatcher("/loginForm").forward(request, response);
            return;
        }
        boolean isRole = userRolesFacade.isRole("BUYER", user);
        if (!isRole) {
            request.setAttribute("info", "У вас нет права использовать этот ресурс. Войдите с соответствующими правами!");
            request.getRequestDispatcher("/loginForm").forward(request, response);
            return;
        }

        httpSession = request.getSession(true);
        httpSession.setAttribute("user", user);

        double totalPrice = (double) httpSession.getAttribute("totalPrice");
        double endPrice = (double) httpSession.getAttribute("endPrice");
        httpSession.setAttribute("totalPrice", totalPrice);
        httpSession.setAttribute("endPrice", endPrice);

        String promoCodeInput = (String) httpSession.getAttribute("promoCodeInput");
        PromoCode promoCode = promoCodeFacade.findPromoCodeName(promoCodeInput);

        boolean isPromoCodeUsed = (boolean) httpSession.getAttribute("promoCodeUsed");

        @SuppressWarnings("unchecked")
        List<Product> cartList = (List<Product>) httpSession.getAttribute("cartList");

        request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
        String path = request.getServletPath();
        switch (path) {
            case "/buyProduct":
                String productId = request.getParameter("productId");
                Product product = productFacade.find(Long.parseLong(productId));
                Buyer buyer = buyerFacade.find(user.getBuyer().getId());

                if (product.getCount() > 0) {
                    if (buyer.getMoney() - product.getPrice() >= 0) {
                        product.setCount(product.getCount() - 1);
                        productFacade.edit(product);
                        buyer.setMoney(buyer.getMoney() - product.getPrice());
                        buyerFacade.edit(buyer);
                        History history = new History("success", product, buyer, new GregorianCalendar().getTime());
                        historyFacade.create(history);

                        String message = "Hello, " + buyer.getName() + " " + buyer.getLastname() + "\n"
                                + "Спасибо, что преобрели товар " + product.getBrand() + " " + product.getSeries() + " " + product.getModel();


                        final String username = "danger.228684@gmail.com";
                        final String password = "Nittispermus123";
                        String fromEmail = "danger.228684@gmail.com";
                        String toEmail = "kirya.goritskij@gmail.com";

                        Properties properties = new Properties();
                        properties.put("mail.smtp.auth", "true");
                        properties.put("mail.smtp.starttls.enable", "true");
                        properties.put("mail.smtp.host", "smtp.gmail.com");
                        properties.put("mail.smtp.port", "587");

                        Session session = Session.getInstance(properties, new Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(username, password);
                            }
                        });
                        //Start our mail message
                        MimeMessage msg = new MimeMessage(session);
                        try {
                            msg.setFrom(new InternetAddress(fromEmail));
                            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
                            msg.setSubject("Subject Line");

                            Multipart emailContent = new MimeMultipart();

                            //Text body part
                            MimeBodyPart textBodyPart = new MimeBodyPart();
                            textBodyPart.setText("My multipart text");

                            //Attach body parts
                            emailContent.addBodyPart(textBodyPart);

                            //Attach multipart to message
                            msg.setContent(emailContent);

                            Transport.send(msg);
                            System.out.println("Sent message");
                        } catch (MessagingException e) {
                            e.printStackTrace();
                        }


                        request.setAttribute("info", "Товар " + '"' + product.getBrand() + " " + product.getSeries() + " " + product.getModel() + '"' + " куплен пользователем " + '"' + buyer.getName() + " " + buyer.getLastname() + '"' + ".");
                    } else {
                        request.setAttribute("info", "Недостаточно средств на балансе.");
                        History history = new History("reserved", product, buyer, new GregorianCalendar().getTime());
                        historyFacade.create(history);
                        request.getRequestDispatcher("/balanceReplenishmentForm").forward(request, response);
                        break;
                    }
                }
                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/addToBag":
                List<Product> listProducts = productFacade.findAll();

                productId = request.getParameter("productId");
                product = productFacade.find(Long.parseLong(productId));

                cartList.add(0, product);

                httpSession.setAttribute("cartList", cartList);
                request.setAttribute("product", product);
                request.setAttribute("listProducts", listProducts);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("listProducts")).forward(request, response);
                break;

            case "/shoppingCartForm":
                totalPrice = 0;
                endPrice = 0;

                promoCodeInput = (String) httpSession.getAttribute("promoCodeInput");

                promoCode = promoCodeFacade.findPromoCodeName(promoCodeInput);

                DateFormatSymbols sym = DateFormatSymbols.getInstance(new Locale("ru", "ru"));
                sym.setMonths(new String[]{"Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"});
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
                sdf.setDateFormatSymbols(sym);
                Calendar c = Calendar.getInstance();
                c.setTime(new Date());
                c.add(Calendar.DATE, 3);
                String before = sdf.format(c.getTime());
                c.add(Calendar.DATE, 7);
//                String after = sdf.format(c.getTime());
                String after = sdf.format(c.getTime());

                for (int i = 0; i < cartList.size(); i++) {
                    cartList.get(i);
                    product = cartList.get(i);
                    totalPrice += product.getPrice();
                }

                if (isPromoCodeUsed) {
                    endPrice = ((totalPrice * promoCode.getPercent() / 100) + totalPrice * 0.2 + 5);
                } else {
                    endPrice = (totalPrice * 0.2) + totalPrice + 5;
                }

                endPrice = (double) Math.round(endPrice * 100) / 100;

                httpSession.setAttribute("cartList", cartList);
                httpSession.setAttribute("endPrice", endPrice);
                httpSession.setAttribute("totalPrice", totalPrice);
                request.setAttribute("productCount", cartList.size());
                request.setAttribute("approxShippingDate", before);
                request.setAttribute("finalApproxShippingDate", after);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("shoppingCart")).forward(request, response);
                break;

            case "/shoppingCart":
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("paymentForm")).forward(request, response);
                break;

            case "/deleteFromCart":
                productId = request.getParameter("productId");
                product = productFacade.find(Long.parseLong(productId));

                cartList.remove(product);

                httpSession.setAttribute("cartList", cartList);
                request.setAttribute("productCount", cartList.size());
                request.getRequestDispatcher("/shoppingCartForm").forward(request, response);
                break;

            case "/usePromoCode":
                promoCodeInput = request.getParameter("promoCodeName");

                promoCode = promoCodeFacade.findPromoCodeName(promoCodeInput);

                try {
                    if (promoCodeInput.equals(promoCode.getPromoCodeName())) {
                        httpSession.setAttribute("promoCode", promoCode);
                        httpSession.setAttribute("promoCodeInput", promoCodeInput);
                        httpSession.setAttribute("promoCodeUsed", true);
                        request.setAttribute("info", "Вы успешно применили промо-код!");
                    }
                } catch (NullPointerException e) {
                    request.setAttribute("info", "Такого промо-кода не существует!");
                }

                request.getRequestDispatcher("/shoppingCartForm").forward(request, response);
                break;

            case "/paymentForm":
                endPrice = (double) httpSession.getAttribute("endPrice");
                totalPrice = (double) httpSession.getAttribute("totalPrice");

                buyer = buyerFacade.find(user.getBuyer().getId());

                for (int i = 0; i < cartList.size(); i++) {
                    cartList.get(i);
                }

                if (isPromoCodeUsed) {
                    endPrice = ((totalPrice * promoCode.getPercent() / 100) + totalPrice * 0.2 + 5);
                } else {
                    endPrice = (totalPrice * 0.2) + totalPrice + 5;
                }

                endPrice = (double) Math.round(endPrice * 100) / 100;

                httpSession.setAttribute("cartList", cartList);
                httpSession.setAttribute("endPrice", endPrice);
                httpSession.setAttribute("totalPrice", totalPrice);
                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("paymentForm")).forward(request, response);
                break;

            case "/payment":
                endPrice = (double) httpSession.getAttribute("endPrice");
                totalPrice = (double) httpSession.getAttribute("totalPrice");

                buyer = buyerFacade.find(user.getBuyer().getId());
                user = userFacade.find(user.getId());

                double userMoney = user.getBuyer().getMoney();
                List<Product> productList = new ArrayList<>();
                for (Product value : cartList) {
                    product = value;
                    productList.add(product);
                }

                if (userMoney < endPrice) {
                    request.setAttribute("info", "Недостаточно денег для покупки");
                    request.getRequestDispatcher("/listProducts").forward(request, response);
                    break;
                }

                for (Product buyProduct : productList) {
                    historyFacade.create(new History("success", buyProduct, user.getBuyer(), new GregorianCalendar().getTime()));
                    cartList.clear();
                }

                buyer.setMoney(buyer.getMoney() - endPrice);
                buyerFacade.edit(buyer);

                user = userFacade.find(user.getId());
                userFacade.edit(user);

                httpSession.setAttribute("user", user);
                request.setAttribute("buyer", buyer);
                request.setAttribute("info", "Пользователь " + '"' + buyer.getName() + " " + buyer.getLastname() + '"' + " купил " + productList.size() + " товара(ов) на сумму " + endPrice + " евро.");
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}


