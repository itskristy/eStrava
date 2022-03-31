package sk.uniza.kmikt.meals;

import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "LoadMealPricesServlet", value = "/load-prices")
public class LoadMealPricesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        Gson gson = new Gson();

        int mealId = Integer.parseInt(request.getParameter("id"));

        ArrayList<Meal> meals = new ArrayList<>();
        MealController mc = new MealController();
        if (mc.selectAllPrices(mealId).size() != 0) {
            meals.addAll(mc.selectAllPrices(mealId));
        }

        response.getWriter().write(gson.toJson(meals));
    }
}
