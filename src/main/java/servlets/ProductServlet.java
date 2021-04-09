package servlets;

import entity.Buyer;
import entity.History;
import entity.Product;
import entity.User;
import jakarta.ejb.EJB;
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
        "/buyProductForm",
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

        @SuppressWarnings("unchecked")
        List<Product> cartList = (List<Product>) httpSession.getAttribute("cartList");

        request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
        String path = request.getServletPath();
        switch (path) {
            case "/buyProductForm":
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
                        request.setAttribute("info", "Товар " + '"' + product.getBrand() + " " + product.getSeries() + " " + product.getModel() + '"' + " куплен пользователем: " + '"' + buyer.getName() + " " + buyer.getLastname() + '"' + ".");
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
                String promoCode = request.getParameter("promoCode");
                double totalPrice = 0;
                double endPrice = 0;

                DateFormatSymbols sym = DateFormatSymbols.getInstance(new Locale("ru", "ru"));
                sym.setMonths(new String[]{"Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"});
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
                sdf.setDateFormatSymbols(sym);
                Calendar c = Calendar.getInstance();
                c.setTime(new Date());
                c.add(Calendar.DATE, 3);
                String before = sdf.format(c.getTime());
                c.add(Calendar.DATE, 7);
                String after = sdf.format(c.getTime());

                for (int i = 0; i < cartList.size(); i++) {
                    cartList.get(i);
                    product = cartList.get(i);
                    totalPrice += product.getPrice();
                }

                endPrice = (totalPrice * 0.2) + totalPrice + 5;

                httpSession.setAttribute("cartList", cartList);
                request.setAttribute("endPrice", endPrice);
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("isPromoCodeUsed", false);
                request.setAttribute("promoCode", promoCode);
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
                promoCode = request.getParameter("promoCode");

                if (promoCode.equals("JPTVR19")) {
                    // сделать скидку
                    httpSession.setAttribute("promoCodeUsed", true);
                    request.setAttribute("info", "Вы успешно применили промо-код!");
                    request.setAttribute("promoCode", promoCode);
                }

                if (!promoCode.equals("JPTVR19")) {
                    request.setAttribute("info", "Такого промо-кода не существует!");
                }

                request.getRequestDispatcher("/shoppingCartForm").forward(request, response);
                break;

            case "/paymentForm":
                buyer = buyerFacade.find(user.getBuyer().getId());
                totalPrice = 0;
                endPrice = 0;

                for (int i = 0; i < cartList.size(); i++) {
                    cartList.get(i);
                    product = cartList.get(i);
                    totalPrice += product.getPrice();
                }
                endPrice = (totalPrice * 0.2) + totalPrice + 5;

                httpSession.setAttribute("cartList", cartList);
                request.setAttribute("buyer", buyer);
                request.setAttribute("endPrice", endPrice);
                request.setAttribute("totalPrice", totalPrice);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("paymentForm")).forward(request, response);
                break;

            case "/payment":
                user = userFacade.find(user.getId());

                double userMoney = user.getBuyer().getMoney();
                List<Product> productList = new ArrayList<>();
                endPrice = 0;
                totalPrice = 0;

                for (Product value : cartList) {
                    product = value;
                    totalPrice += product.getPrice();
                    productList.add(product);
                }
                endPrice = (totalPrice * 0.2) + totalPrice + 5;
                if (userMoney < endPrice) {
                    request.setAttribute("info", "Недостаточно денег для покупки");
                    request.getRequestDispatcher("/listProducts").forward(request, response);
                    break;
                }

                for (Product buyProduct : productList) {
                    historyFacade.create(new History("success", buyProduct, user.getBuyer(), new GregorianCalendar().getTime()));
                    cartList.clear();
                }

                buyer = buyerFacade.find(user.getBuyer().getId());
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


