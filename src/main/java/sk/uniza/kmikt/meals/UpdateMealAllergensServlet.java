package sk.uniza.kmikt.meals;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;

@WebServlet(name = "UpdateMealAllergensServlet", value = "/update-allergens")
public class UpdateMealAllergensServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            JsonElement allergens = JsonParser.parseString(request.getParameter("allergens"));
            int meal_id = Integer.parseInt(request.getParameter("mealId"));

            MealController mlc = new MealController();
            mlc.deleteMealAllergens(meal_id);
            for (int i = 0; i < (allergens.getAsJsonArray()).size(); i++) {
                int allergen = allergens.getAsJsonArray().get(i).getAsJsonObject().get("value").getAsInt();
                mlc.insertMealAllergen(meal_id, allergen);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
