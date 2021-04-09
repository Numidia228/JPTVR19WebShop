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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProfileServlet", urlPatterns = {
        "/checkProfile",
        "/editProfileForm",
        "/editProfile",
        "/avatarUploadForm",
        "/checkBagListForm",
        "/checkBagList",
        "/checkQuestions",
        "/balanceReplenishmentForm",
        "/balanceReplenishment",
        "/buyerPurchases",
})

public class ProfileServlet extends HttpServlet {

    @EJB
    private ProductFacade productFacade;
    @EJB
    private BuyerFacade buyerFacade;
    @EJB
    private UserRolesFacade userRolesFacade;
    @EJB
    private UserFacade userFacade;
    @EJB
    private HistoryFacade historyFacade;
    @EJB
    private AvatarFacade avatarFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> listProducts = productFacade.findAll();
        request.setAttribute("listProducts", listProducts);

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

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

        request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
        String path = request.getServletPath();
        switch (path) {
            case "/checkProfile":
                Buyer buyer = buyerFacade.find(user.getBuyer().getId());

                httpSession.setAttribute("user", user);
                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("buyerProfile")).forward(request, response);
                break;

            case "/editProfileForm":
                buyer = buyerFacade.find(user.getBuyer().getId());

                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("buyerProfileSettings")).forward(request, response);
                break;

            case "/editProfile":
                String name = request.getParameter("name");
                String lastname = request.getParameter("lastname");
                String town = request.getParameter("town");
                String buyerDescription = request.getParameter("buyerDescription");
                String birthDate = request.getParameter("birthDate");
                String employee = request.getParameter("employee");
                String employeeCompany = request.getParameter("employeeCompany");
                String address = request.getParameter("address");
                String userWebsite = request.getParameter("userWebsite");
                String userGithub = request.getParameter("userGithub");
                String userTwitter = request.getParameter("userTwitter");
                String userInstagram = request.getParameter("userInstagram");
                String userFacebook = request.getParameter("userFacebook");
                String userVk = request.getParameter("userVk");
                String userTelegram = request.getParameter("userTelegram");

                String password = request.getParameter("password");
                String newPassword = request.getParameter("newPassword");
                String newPasswordRepeat = request.getParameter("newPasswordRepeat");

                if ("".equals(name) || name == null) {
                    name = null;
                }

                if ("".equals(lastname) || lastname == null) {
                    lastname = null;
                }

                if ("".equals(employee) || employee == null) {
                    employee = null;
                }

                if ("".equals(employeeCompany) || employeeCompany == null) {
                    employeeCompany = null;
                }

                if ("".equals(town) || town == null) {
                    town = null;
                }

                if ("".equals(buyerDescription) || buyerDescription == null) {
                    buyerDescription = null;
                }

                if ("".equals(birthDate) || birthDate == null) {
                    birthDate = null;
                }

                if ("".equals(address) || address == null) {
                    address = null;
                }

                if ("".equals(userWebsite) || userWebsite == null) {
                    userWebsite = null;
                }

                if ("".equals(userGithub) || userGithub == null) {
                    userGithub = null;
                }

                if ("".equals(userTwitter) || userTwitter == null) {
                    userTwitter = null;
                }

                if ("".equals(userInstagram) || userInstagram == null) {
                    userInstagram = null;
                }

                if ("".equals(userFacebook) || userFacebook == null) {
                    userFacebook = null;
                }

                if ("".equals(userVk) || userVk == null) {
                    userVk = null;
                }

                if ("".equals(userTelegram) || userTelegram == null) {
                    userTelegram = null;
                }

                if (!"".equals(password) && !"".equals(newPassword) && !"".equals(newPasswordRepeat)) {
                    if (password.equals(user.getPassword())) {
                        if (newPasswordRepeat.equals(newPassword)) {
                            password = newPassword;
                        } else {
                            request.setAttribute("info", "Неверно указан пароль!");
                            password = user.getPassword();
                        }
                    }
                } else {
                    password = user.getPassword();
                }

                buyer = buyerFacade.find(user.getBuyer().getId());

                buyer.setName(name);
                buyer.setLastname(lastname);
                buyer.setEmployee(employee);
                buyer.setEmployeeCompany(employeeCompany);
                buyer.setTown(town);
                buyer.setBuyerDescription(buyerDescription);
                buyer.setBirthDate(birthDate);
                buyer.setAddress(address);
                buyer.setUserWebsite(userWebsite);
                buyer.setUserGithub(userGithub);
                buyer.setUserTwitter(userTwitter);
                buyer.setUserInstagram(userInstagram);
                buyer.setUserFacebook(userFacebook);
                buyer.setUserVk(userVk);
                buyer.setUserTelegram(userTelegram);
                buyerFacade.edit(buyer);

                user.setPassword(password);
                userFacade.edit(user);

                request.setAttribute("info", "Данные пользователя " + '"' + user.getLogin() + '"' + " были изменены.");
                request.getRequestDispatcher("/checkProfile").forward(request, response);
                break;

            case "/avatarUploadForm":
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("avatarUpload")).forward(request, response);
                break;

            case "/checkQuestions":
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("questions")).forward(request, response);
                break;

            case "/balanceReplenishmentForm":
                buyer = buyerFacade.find(user.getBuyer().getId());

                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("balanceReplenishment")).forward(request, response);
                break;

            case "/balanceReplenishment":
                String visaCartNumber = request.getParameter("visa-cartNumber");
                String visaExpDate = request.getParameter("visa-ExpDate");
                String visaCvv = request.getParameter("visa-CVV");
                String visaBalance = request.getParameter("visa-Balance");
                String mastercardCartNumber = request.getParameter("mastercard-CartNumber");
                String mastercardExpDate = request.getParameter("mastercard-ExpDate");
                String mastercardCvv = request.getParameter("mastercard-CVV");
                String mastercartBalance = request.getParameter("mastercart-Balance");
                String paypalBalance = request.getParameter("paypal-Balance");
                double money = 0;

                if (visaCartNumber.length() == 19 && visaExpDate.length() == 7 && visaCvv.length() == 3) {
                    money = Double.parseDouble(visaBalance);
                }

                if (mastercardCartNumber.length() == 19 && mastercardExpDate.length() == 7 && mastercardCvv.length() == 3) {
                    money = Double.parseDouble(mastercartBalance);
                }

                if (!"".equals(paypalBalance) && visaCartNumber.length() != 19 && visaExpDate.length() != 7 && visaCvv.length() != 3 && mastercardCartNumber.length() != 19 && mastercardExpDate.length() != 7 && mastercardCvv.length() != 3) {
                    money = Double.parseDouble(paypalBalance);
                }

                buyer = buyerFacade.find(user.getBuyer().getId());

                buyer.setMoney(buyer.getMoney() + money);
                buyerFacade.edit(buyer);

                httpSession.setAttribute("buyer", buyer);
                request.setAttribute("info", "Баланс " + '"' + buyer.getName() + " " + buyer.getLastname() + '"' + " пополнен на " + money + " евро.");
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/buyerPurchases":
                buyer = buyerFacade.find(user.getBuyer().getId());

                List<History> listHistory = historyFacade.findAll();
                Map<History, List<History>> historyListMap = new HashMap<>();
                for (History history : listHistory) {
                    List<History> historyArray = historyFacade.findBoughtProducts(history);
                    historyListMap.put(history, historyArray);
                }

                request.setAttribute("historyListMap", historyListMap);
                request.setAttribute("historyCount", listHistory.size());
                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("buyerPurchases")).forward(request, response);
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