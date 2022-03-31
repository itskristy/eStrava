package sk.uniza.kmikt.menus;

import com.google.gson.Gson;
import sk.uniza.kmikt.employees.Employee;
import sk.uniza.kmikt.employees.EmployeeController;
import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.meals.MealController;
import sk.uniza.kmikt.users.User;
import sk.uniza.kmikt.users.UserController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "LoadDailyMenuServlet", value = "/load-menu")
public class LoadDailyMenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();

        try {
            String fromDate = request.getParameter("date_from");

            MenuController mc = new MenuController();
            MealController mlc = new MealController();

            int menuId = mc.selectMenuByDate(fromDate);

            ArrayList<Integer> menuItems = new ArrayList<>(mc.selectAllMenuItems(menuId));

            ArrayList<Meal> meals = new ArrayList<>();
            for(int i = 0; i < menuItems.size(); i++) {
                int mealId = menuItems.get(i);
                meals.add(mlc.selectMealById(mealId));
                meals.get(i).setAllergens(mlc.selectAllAllergens(mealId));
            }


            response.getWriter().write(gson.toJson(meals));
        }
        catch (NumberFormatException | NullPointerException  e) {
            e.printStackTrace();
        }
    }
}
