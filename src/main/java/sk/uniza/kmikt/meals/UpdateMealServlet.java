package sk.uniza.kmikt.meals;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateMealServlet", value = "/update-meal")
public class UpdateMealServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int id = Integer.parseInt(request.getParameter("id"));

            Meal meal = new Meal(id, 0, name, price);
            MealController mlc = new MealController();

            if(mlc.updateMeal(meal) != 0) {
                response.sendRedirect("meals.jsp");

            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
