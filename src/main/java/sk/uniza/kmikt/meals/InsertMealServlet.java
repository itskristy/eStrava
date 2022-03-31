package sk.uniza.kmikt.meals;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "InsertMealServlet", value = "/insert-meal")
public class InsertMealServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            int categery = Integer.parseInt(request.getParameter("category"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));

            Meal meal = new Meal(categery, name, price);
            MealController mlc = new MealController();

            if (mlc.insertMeal(meal) != 0) {
                response.sendRedirect("meals.jsp");

            }
        }
        catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
