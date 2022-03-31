package sk.uniza.kmikt.allergens;

import com.google.gson.Gson;
import sk.uniza.kmikt.meals.MealController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "LoadMealAllergensServlet", value = "/load-allergens")
public class LoadMealAllergensServlet extends HttpServlet {
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

        ArrayList<Integer> allergens = new ArrayList<>();
        MealController mc = new MealController();
        if (mc.selectAllAllergens(mealId).size() != 0) {
            allergens.addAll(mc.selectAllAllergens(mealId));
        }

        response.getWriter().write(gson.toJson(allergens));
    }
}
