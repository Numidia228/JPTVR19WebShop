package servlets;

import entity.*;
import session.*;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ManagerServlet", urlPatterns = {
        "/addProduct",
        "/createProduct",
        "/addCategory",
        "/createCategory",
        "/editBuyerForm",
        "/editBuyer",
        "/showBoughtProduct",
        "/uploadForm",
        "/checkUserProfile",
})

public class ManagerServlet extends HttpServlet {

    @EJB
    private ProductFacade productFacade;
    @EJB
    private BuyerFacade buyerFacade;
    @EJB
    private HistoryFacade historyFacade;
    @EJB
    private UserRolesFacade userRolesFacade;
    @EJB
    private CoverFacade coverFacade;
    @EJB
    private CategoryFacade categoryFacade;

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
        boolean isRole = userRolesFacade.isRole("MANAGER", user);
        if (!isRole) {
            request.setAttribute("info", "У вас нет права использовать этот ресурс. Войдите с соответствующими правами!");
            request.getRequestDispatcher("/loginForm").forward(request, response);
            return;
        }

        request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
        String path = request.getServletPath();
        switch (path) {
            case "/addProduct":
                List<Category> categoryList = categoryFacade.findAll();
                List<Cover> listCovers = coverFacade.findAll();
                request.setAttribute("listCovers", listCovers);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("activeAddProduct", "true");
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("newProduct")).forward(request, response);
                break;

            case "/createProduct":
                String brand = request.getParameter("brand");
                String series = request.getParameter("series");
                String model = request.getParameter("model");
                String color = request.getParameter("color");
                String weight = request.getParameter("weight");
                String length = request.getParameter("length");
                String width = request.getParameter("width");
                String height = request.getParameter("height");
                String screenDiagonal = request.getParameter("screenDiagonal");
                String resolution = request.getParameter("resolution");
                String touchScreen = request.getParameter("touchScreen");
                String operationSystem = request.getParameter("operationSystem");
                String cpuClass = request.getParameter("cpuClass");
                String cpuType = request.getParameter("cpuType");
                String cpuModel = request.getParameter("cpuModel");
                String cpuFrequency = request.getParameter("cpuFrequency");
                String ramType = request.getParameter("ramType");
                String ramSize = request.getParameter("ramSize");
                String ramClockSpeed = request.getParameter("ramClockSpeed");
                String ssd = request.getParameter("ssd");
                String ssdCapacity = request.getParameter("ssdCapacity");
                String hdd = request.getParameter("hdd");
                String hddCapacity = request.getParameter("hddCapacity");
                String totalPcMemory = request.getParameter("totalPcMemory");
                String gpuType = request.getParameter("gpuType");
                String gpuModel = request.getParameter("gpuModel");
                String diskDrive = request.getParameter("diskDrive");
                String camera = request.getParameter("camera");
                String microphone = request.getParameter("microphone");
                String bodyMaterial = request.getParameter("bodyMaterial");
                String russianKeyboardLayout = request.getParameter("russianKeyboardLayout");
                String estonianKeyboardLayout = request.getParameter("estonianKeyboardLayout");
                String backlitKeyboard = request.getParameter("backlitKeyboard");
                String waterproofKeyboard = request.getParameter("waterproofKeyboard");
                String batteryTechnology = request.getParameter("batteryTechnology");
                String batteryLife = request.getParameter("batteryLife");
                String guarantee = request.getParameter("guarantee");
                String price = request.getParameter("price");
                String count = request.getParameter("count");
                String categoryId = request.getParameter("categoryId");
                String coverId = request.getParameter("coverId");

                Category category = categoryFacade.find(Long.parseLong(categoryId));
                Cover cover = coverFacade.find(Long.parseLong(coverId));
                Product product = new Product(brand, series, model, color, weight, length, width, height, screenDiagonal, resolution, touchScreen, operationSystem, cpuClass, cpuType, cpuModel, cpuFrequency, ramType, ramSize, ramClockSpeed, ssd, ssdCapacity, hdd, hddCapacity, totalPcMemory, gpuType, gpuModel, diskDrive, camera, microphone, bodyMaterial, russianKeyboardLayout, estonianKeyboardLayout, backlitKeyboard, waterproofKeyboard, batteryTechnology, batteryLife, guarantee, Double.parseDouble(price), Integer.parseInt(count), category, cover);
                productFacade.create(product);

                request.setAttribute("info", "Товар " + '"' + product.getBrand() + " " + product.getSeries() + " " + product.getModel() + '"' + " добавлен.");
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/addCategory":
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("addCategory")).forward(request, response);
                break;

            case "/createCategory":
                String categoryName = request.getParameter("categoryName");

                category = new Category(categoryName);
                categoryFacade.create(category);

                request.setAttribute("info", "Категория " + '"' + category.getCategoryName() + '"' + " успешно добавлена.");
                request.getRequestDispatcher("/addProduct").forward(request, response);
                break;

            case "/editBuyerForm":
                request.setAttribute("listBuyers", "true");
                List<Buyer> listBuyers = buyerFacade.findAll();
                request.setAttribute("listBuyers", listBuyers);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("editBuyer")).forward(request, response);
                break;

            case "/editBuyer":
                String buyerId = request.getParameter("buyerId");
                String name = request.getParameter("name");
                String lastname = request.getParameter("lastname");
                String money = request.getParameter("money");
                String email = request.getParameter("email");

                Buyer buyer = buyerFacade.find(Long.parseLong(buyerId));
                buyer.setName(name);
                buyer.setLastname(lastname);
                buyer.setMoney(Double.parseDouble(money));
                buyer.setEmail(email);
                buyerFacade.edit(buyer);
                request.setAttribute("buyerId", buyerId);
                request.setAttribute("buyer", buyer);
                request.setAttribute("info", "Пользователь " + buyer.getName() + " " + buyer.getLastname() + " был успешно изменён.");
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("index")).forward(request, response);
                break;

            case "/showBoughtProduct":
                request.setAttribute("activeListHistory", "true");

                List<History> listHistory = historyFacade.findAll();
                Map<History, List<History>> historyListMap = new HashMap<>();
                for (History history : listHistory) {
                    List<History> historyArray = historyFacade.findBoughtProducts(history);
                    historyListMap.put(history, historyArray);
                }

                request.setAttribute("historyListMap", historyListMap);
                request.setAttribute("historyCount", listHistory.size());
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("showBoughtProduct")).forward(request, response);
                break;

            case "/uploadForm":
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("uploadForm")).forward(request, response);
                break;

            case "/checkUserProfile":
                buyerId = request.getParameter("buyerId");
                buyer = buyerFacade.find(Long.parseLong(buyerId));

                request.setAttribute("buyer", buyer);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("userProfile")).forward(request, response);
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