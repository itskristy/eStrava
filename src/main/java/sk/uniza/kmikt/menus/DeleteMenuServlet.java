package sk.uniza.kmikt.menus;

import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.meals.MealController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteMenuServlet", value = "/delete-menu")
public class DeleteMenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            int id = Integer.parseInt(request.getParameter("id"));

           MenuController mc = new MenuController();
           mc.deleteMenuItems(id);
            if(mc.deleteMenu(id) != 0) {
                response.sendRedirect("menus.jsp");

            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
