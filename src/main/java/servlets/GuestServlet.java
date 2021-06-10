package servlets;

import entity.Category;
import entity.Product;
import entity.User;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import session.CategoryFacade;
import session.ProductFacade;
import session.UserRolesFacade;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GuestServlet", urlPatterns = {
        "/listProducts",
})

public class GuestServlet extends HttpServlet {

    @EJB
    private ProductFacade productFacade;
    @EJB
    private UserRolesFacade userRolesFacade;
    @EJB
    private CategoryFacade categoryFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession httpSession = request.getSession(false);

        User user = (User) httpSession.getAttribute("user");
        request.setAttribute("role", userRolesFacade.getTopRoleForUser(user));
        String path = request.getServletPath();
        switch (path) {
            case "/listProducts":
                request.setAttribute("activeListProducts", "true");

                List<Product> listProducts = productFacade.findAll();
                List<Category> categoryList = categoryFacade.findAll();

//                for (int i = 0; i < listProducts.size(); i++) {
//                    List<Product> cpuList =
//                }


                request.setAttribute("categoryList", categoryList);
                request.setAttribute("listProducts", listProducts);
                request.getRequestDispatcher(LoginServlet.pathToFile.getString("listProducts")).forward(request, response);
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