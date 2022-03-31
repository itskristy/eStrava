package sk.uniza.kmikt.menus;

import com.google.gson.Gson;
import sk.uniza.kmikt.meals.MealController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "LoadMenuItemsServlet", value = "/load-items")
public class LoadMenuItemsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        Gson gson = new Gson();

        int menuId = Integer.parseInt(request.getParameter("id"));

        ArrayList<Integer> items = new ArrayList<>();
        MenuController mc = new MenuController();
        if (mc.selectAllMenuItems(menuId).size() != 0) {
            items.addAll(mc.selectAllMenuItems(menuId));
        }

        response.getWriter().write(gson.toJson(items));
    }
}
