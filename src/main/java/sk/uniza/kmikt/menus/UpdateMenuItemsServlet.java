package sk.uniza.kmikt.menus;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import sk.uniza.kmikt.meals.MealController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateMenuItemsServlet", value = "/update-items")
public class UpdateMenuItemsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            JsonElement items = JsonParser.parseString(request.getParameter("items"));
            int category = Integer.parseInt(request.getParameter("category"));
            int menuId = Integer.parseInt(request.getParameter("menuId"));

            MenuController mc = new MenuController();
            mc.deleteMenuItemsByMenuIdAndCategory(menuId, category);
            for (int i = 0; i < (items.getAsJsonArray()).size(); i++) {
                int item = items.getAsJsonArray().get(i).getAsJsonObject().get("value").getAsInt();
                mc.insertMenuItem(item, menuId, category);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
