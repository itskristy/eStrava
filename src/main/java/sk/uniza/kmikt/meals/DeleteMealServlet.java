package sk.uniza.kmikt.meals;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteMealServlet", value = "/delete-meal")
public class DeleteMealServlet extends HttpServlet {
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

            Meal meal = new Meal(id, 0, "", 0);
            MealController mlc = new MealController();

            if(mlc.deleteMeal(meal) != 0) {
                response.sendRedirect("meals.jsp");

            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
