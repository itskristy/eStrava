package sk.uniza.kmikt.menus;

import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.meals.MealController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "InsertMenuServlet", value = "/insert-menu")
public class InsertMenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            String date = request.getParameter("menu_date");

            DailyMenu menu = new DailyMenu(date);
            MenuController mc = new MenuController();

            if (mc.insertMenu(menu) != 0) {
                response.sendRedirect("menus.jsp");
            }
        }
        catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
