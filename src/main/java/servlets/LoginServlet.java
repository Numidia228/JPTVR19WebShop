package servlets;

import entity.*;
import jakarta.ejb.EJB;
import jakarta.ejb.EJBException;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import session.*;
import tools.EncryptPassword;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

@WebServlet(name = "LoginServlet", urlPatterns = {
        "/index",
        "/loginForm",
        "/login",
        "/logout",
        "/registrationForm",
        "/registration",
})

public class LoginServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;
    @EJB
    private BuyerFacade buyerFacade;
    @EJB
    private ProductFacade productFacade;
    @EJB
    private RoleFacade roleFacade;
    @EJB
    private UserRolesFacade userRolesFacade;
    @EJB
    private AvatarFacade avatarFacade;
    @Inject
    private EncryptPassword encryptPassword;

    public static final ResourceBundle pathToFile = ResourceBundle.getBundle("property/pathToFile");

    @Override
    public void init() {
        if (userFacade.findAll().size() > 0) return;
        String salt = encryptPassword.createSalt();
        String adminEncryptedPassword = encryptPassword.createHash("admin", salt);

        Buyer buyer = new Buyer("PUPIL", "PUPIL", 100000.0, "PUPIL@ivkhk.ee", "PUPIL", "1234 5678", "NET :(", "14.12.2000", "Soft Developer", "IVKHK", "NET :(", "kutsehariduskeskus.ee", "PUPIL", "PUPIL", "PUPIL", "PUPIL", "PUPIL", "PUPIL", null);
        buyerFacade.create(buyer);

        User user = new User("admin", adminEncryptedPassword, salt, "confirmed", buyer);
        userFacade.create(user);

        Role role = new Role("ADMIN");
        roleFacade.create(role);

        UserRoles userRoles = new UserRoles(user, role);
        userRolesFacade.create(userRoles);

        role = new Role("MANAGER");
        roleFacade.create(role);

        userRoles = new UserRoles(user, role);
        userRolesFacade.create(userRoles);

        role = new Role("BUYER");
        roleFacade.create(role);

        userRoles = new UserRoles(user, role);
        userRolesFacade.create(userRoles);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<Product> listProducts = productFacade.findAll();
        request.setAttribute("listProducts", listProducts);

        HttpSession httpSession = request.getSession(false);

        User user = null;
        if (httpSession != null) {
            user = (User) httpSession.getAttribute("user");
        }

        String path = request.getServletPath();
        switch (path) {
            case "/loginForm":
                request.setAttribute("activeEnter", "true");
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("login")).forward(request, response);
                break;

            case "/login":
                String login = request.getParameter("login");
                String password = request.getParameter("password");

                user = userFacade.findByLogin(login);
                if (user == null) {
                    request.setAttribute("info", "Нет такого пользователя");
                    request.getRequestDispatcher("/loginForm").forward(request, response);
                    break;
                }

                String salt = user.getSalt();
                String userEncryptedPassword = encryptPassword.createHash(password, salt);

                if (!userEncryptedPassword.equals(user.getPassword())) {
                    request.setAttribute("info", "Неверный логин или пароль!");
                    request.getRequestDispatcher("/loginForm").forward(request, response);
                }

                List<Product> cartList = new ArrayList<>();

                Buyer buyer = buyerFacade.find(user.getBuyer().getId());

                httpSession = request.getSession(true);
                httpSession.setAttribute("user", user);
                httpSession.setAttribute("cartList", cartList);
                httpSession.setAttribute("buyer", buyer);
                httpSession.setAttribute("promoCodeUsed", false);
                httpSession.setAttribute("promoCodeInput", "");
                httpSession.setAttribute("totalPrice", 0.0);
                httpSession.setAttribute("endPrice", 0.0);
                request.setAttribute("info", "Добро пожаловать " + " \"" + user.getLogin() + "\"" + ".");
                request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/logout":
                httpSession = request.getSession(false);

                if (httpSession != null) {
                    httpSession.setAttribute("cartList", 0);
                    httpSession.invalidate();
                }

                request.setAttribute("info", "Вы вышли из системы.");
                request.setAttribute("role", userRolesFacade.getTopRoleForUser(null));
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/registrationForm":
                request.setAttribute("activeRegistration", "true");
                List<Avatar> listAvatars = avatarFacade.findAll();
                request.setAttribute("listAvatars", listAvatars);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("registration")).forward(request, response);
                break;

            case "/registration":
                String name = request.getParameter("name");
                String lastname = request.getParameter("lastname");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                login = request.getParameter("login");
                password = request.getParameter("password");
                String repeatPassword = request.getParameter("repeatPassword");

                try {
                    if (repeatPassword.equals(password)) {
                        buyer = new Buyer(name, lastname, 0.0, email, null, phoneNumber, null, null, null, null, null, null, null, null, null, null, null, null, null);
                        buyerFacade.create(buyer);
                        salt = encryptPassword.createSalt();
                        userEncryptedPassword = encryptPassword.createHash(password, salt);
                        user = new User(login, userEncryptedPassword, salt, "unconfirmed", buyer);
                        userFacade.create(user);
                    } else {
                        request.setAttribute("info", "Неверный пароль.");
                        request.getRequestDispatcher("/registrationForm").forward(request, response);
                    }
                } catch (EJBException e) {
                    request.setAttribute("info", "Пользователь с такими данными уже существует. Поменяйте данные!");
                    request.getRequestDispatcher("/registrationForm").forward(request, response);
                }

                httpSession = request.getSession(true);
                user = userFacade.findByLogin(login);

                // Добавление полей
                Role roleBuyer = roleFacade.findByName("BUYER");
                UserRoles userRoles = new UserRoles(user, roleBuyer);
                userRolesFacade.create(userRoles);

                buyer = buyerFacade.find(user.getBuyer().getId());

                httpSession.setAttribute("user", user);
                httpSession.setAttribute("buyer", buyer);
                request.setAttribute("checkRole", "3");
                request.setAttribute("info", "Пользователь " + '"' + buyer.getName() + " " + buyer.getLastname() + '"' + " зарегистрирован!");
                request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/index":
                buyer = (Buyer) httpSession.getAttribute("buyer");

                httpSession.setAttribute("buyer", buyer);
                request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);

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
