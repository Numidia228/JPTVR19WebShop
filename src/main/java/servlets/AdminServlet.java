package servlets;

import entity.*;
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

@WebServlet(name = "AdminServlet", urlPatterns = {
        "/listBuyers",
        "/adminForm",
        "/setRole",
        "/checkUserProfile",
        "/editUserProfileSettingsForm",
        "/editUserProfileSettings",
        "/confirmUserFromListUsers",
        "/changeRoleFromListUsers",
        "/addPromoCode",
        "/createPromoCode",
        "/addPromoCode",
        "/createPromoCode",
        "/deletePromoCode",
        "/removePromoCode",
})

public class AdminServlet extends HttpServlet {

    @EJB
    private ProductFacade productFacade;
    @EJB
    private UserFacade userFacade;
    @EJB
    private UserRolesFacade userRolesFacade;
    @EJB
    private RoleFacade roleFacade;
    @EJB
    private BuyerFacade buyerFacade;
    @EJB
    private PromoCodeFacade promoCodeFacade;

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
        boolean isRole = userRolesFacade.isRole("ADMIN", user);
        if (!isRole) {
            request.setAttribute("info", "У вас нет права использовать этот ресурс. Войдите с соответствующими правами!");
            request.getRequestDispatcher("/loginForm").forward(request, response);
            return;
        }

        request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
        String path = request.getServletPath();
        switch (path) {
            case "/listBuyers":
                request.setAttribute("activeListBuyers", "true");

                List<User> listUsers = userFacade.findAll();
                Map<User, List<String>> usersMapWithArrayRoles = new HashMap<>();
                for (User u : listUsers) {
                    List<String> arrStrRoles = userRolesFacade.findRoles(u);
                    usersMapWithArrayRoles.put(u, arrStrRoles);
                }

                request.setAttribute("usersMapWithArrayRoles", usersMapWithArrayRoles);
                request.setAttribute("usersCount", listUsers.size());
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("listBuyers")).forward(request, response);
                break;

            case "/adminForm":
                request.setAttribute("activeAdminPanel", "true");

                Map<User, String> usersMap = new HashMap<>();
                listUsers = userFacade.findAll();
                for (User u : listUsers) {
                    usersMap.put(u, userRolesFacade.getTopRoleForUser(u));
                }
                request.setAttribute("usersMap", usersMap);
                request.setAttribute("listRoles", roleFacade.findAll());
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("adminPanel")).forward(request, response);
                break;

            case "/setRole":
                String userId = request.getParameter("userId");
                String roleId = request.getParameter("roleId");

                user = userFacade.find(Long.parseLong(userId));
                Role role = roleFacade.find(Long.parseLong(roleId));
                UserRoles userRoles = new UserRoles(user, role);
                if (!"admin".equals(user.getLogin())) {
                    userRolesFacade.setNewRole(userRoles);
                    request.setAttribute("info", "Роль изменена!");
                } else {
                    request.setAttribute("userId", userId);
                    request.setAttribute("roleId", roleId);
                    request.setAttribute("info", "Изменить роль невозможно!");
                }
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/checkUserProfile":
                String buyerId = request.getParameter("buyerId");

                Buyer buyer = buyerFacade.find(Long.parseLong(buyerId));
                user = userFacade.find(buyer.getId());

                String roleForBuyer = userRolesFacade.getTopRoleForUser(user);

                request.setAttribute("buyer", buyer);
                request.setAttribute("user", user);
                request.setAttribute("roleForBuyer", roleForBuyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("userProfile")).forward(request, response);
                break;

            case "/editUserProfileSettingsForm":
                buyerId = request.getParameter("buyerId");

                buyer = buyerFacade.find(Long.parseLong(buyerId));
                user = userFacade.find(buyer.getId());

                request.setAttribute("user", user);
                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("userProfileSettings")).forward(request, response);
                break;

            case "/editUserProfileSettings":
                buyerId = request.getParameter("buyerId");
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

                buyer = buyerFacade.find(Long.parseLong(buyerId));

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

                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher("/checkUserProfile").forward(request, response);
                break;

            case "/confirmUserFromListUsers":
                userId = request.getParameter("userId");
                user = userFacade.find(Long.parseLong(userId));

                user.setUserStatus("confirmed");
                userFacade.edit(user);
                request.getRequestDispatcher("/listBuyers").forward(request, response);
                break;

            case "/changeRoleFromListUsers":
                userId = request.getParameter("userId");
                user = userFacade.find(Long.parseLong(userId));
                String strRoleId = "3";

                if (user.getUserStatus().equals("confirmed")){
                    if (userRolesFacade.isRole("BUYER", user)) {
                        strRoleId = "2";
                    }

                    if (userRolesFacade.isRole("MANAGER", user)) {
                        strRoleId = "1";
                    }

                    if (userRolesFacade.isRole("ADMIN", user)) {
                        strRoleId = "3";
                    }
                } else {
                    request.setAttribute("info", "Изменить роль невозможно! Подтвердите профиль!");
                    request.getRequestDispatcher("/listBuyers").forward(request, response);
                    break;
                }

                roleId = strRoleId;
                role = roleFacade.find(Long.parseLong(roleId));
                userRoles = new UserRoles(user, role);
                userRolesFacade.setNewRole(userRoles);

                request.setAttribute("info", "Роль пользователя " + '"' + user.getLogin() + '"' + " изменена на " + '"' + role.getRoleName() + '"' + ".");
                request.getRequestDispatcher("/listBuyers").forward(request, response);
                break;

            case "/addPromoCode":
                request.setAttribute("activeAddPromoCode", true);
                List<PromoCode> promoCodeList = promoCodeFacade.findAll();

                request.setAttribute("promoCodeList", promoCodeList);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("addPromoCode")).forward(request, response);
                break;

            case "/createPromoCode":
                String promoCodeName = request.getParameter("promoCodeName");
                String percent = request.getParameter("percent");

                PromoCode promoCode = new PromoCode(promoCodeName, Integer.parseInt(percent));
                promoCodeFacade.create(promoCode);

                request.setAttribute("info", "Промо-код " + '"' + promoCode.getPromoCodeName() + '"' + " добавлен.");
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/deletePromoCode":
                promoCodeList = promoCodeFacade.findAll();

                request.setAttribute("promoCodeList", promoCodeList);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("removePromoCode")).forward(request, response);
                break;

            case "/removePromoCode":
                String promoCodeId = request.getParameter("promoCodeId");

                promoCode = promoCodeFacade.find(Long.parseLong(promoCodeId));
                promoCodeFacade.remove(promoCode);

                request.setAttribute("info", "Промо-код " + '"' + promoCode.getPromoCodeName() + '"' + " удалён.");
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
