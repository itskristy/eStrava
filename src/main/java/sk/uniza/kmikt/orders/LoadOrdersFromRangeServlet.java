package sk.uniza.kmikt.orders;

import com.google.gson.Gson;
import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.meals.MealController;
import sk.uniza.kmikt.menus.DailyMenu;
import sk.uniza.kmikt.menus.MenuController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "LoadOrdersFromRangeServlet", value = "/load-orders")
public class LoadOrdersFromRangeServlet extends HttpServlet {
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
            String fromDate = request.getParameter("orders_from");
            String toDate = request.getParameter("orders_to");

            HttpSession session = request.getSession();
            int userId = (Integer) session.getAttribute("logged_id");

            List<Order> orders = new ArrayList<>();
            OrderController oc = new OrderController();

            if (oc.selectOrdersByMonthForUser(fromDate, toDate, userId).size() != 0) {
                orders.addAll(oc.selectOrdersByMonthForUser(fromDate, toDate, userId));
            }

            List<OrderItem> items = new ArrayList<>();
            for (Order value : orders) {
                int orderId = value.getId();
                items.addAll(oc.selectOrderItems(orderId));
            }

            MealController mc = new MealController();
            List<Meal> meals = new ArrayList<>();
            for (OrderItem item : items) {
                int mealId = item.getMealId();
                meals.add(mc.selectMealById(mealId));
            }

            MenuController dmc = new MenuController();
            List<DailyMenu> menus = new ArrayList<>();
            for (Order order : orders) {
                int menuId = order.getMenuId();
                menus.addAll(dmc.selectMenuById(menuId));
            }

            ArrayList<Object> data = new ArrayList<>();
            data.add(orders);
            data.add(items);
            data.add(meals);
            data.add(menus);

            response.getWriter().write(gson.toJson(data));
        }
        catch (NumberFormatException | NullPointerException  e) {
            e.printStackTrace();
        }
    }
}
