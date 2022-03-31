package sk.uniza.kmikt.market;

import com.google.gson.Gson;
import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.meals.MealController;
import sk.uniza.kmikt.menus.MenuController;
import sk.uniza.kmikt.orders.Order;
import sk.uniza.kmikt.orders.OrderController;
import sk.uniza.kmikt.orders.OrderItem;
import sk.uniza.kmikt.users.User;
import sk.uniza.kmikt.users.UserController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "LoadMarketedIemsForDateServlet", value = "/load-market")
public class LoadMarketedIemsForDateServlet extends HttpServlet {
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
            String dateOf = request.getParameter("date_from");

            MarketController mc = new MarketController();
            List<MarketedItem> market = new ArrayList<>();
            market.addAll(mc.selectAllMarketedItem());

            OrderController oc = new OrderController();
            List<OrderItem> items = new ArrayList<>();
            for (MarketedItem item: market) {
                items.add(oc.selectOrderItemById(item.getOrderItemId()));
            }

            MenuController mec = new MenuController();
            int menuId = mec.selectMenuByDate(dateOf);
            List<Order> orders = oc.selectOrdersByMenu(menuId);
            List<OrderItem> marketed = new ArrayList<>();
            for (OrderItem item: items) {
                for (Order order: orders) {
                    if (item.getOrderId() == order.getId()) {
                        marketed.add(item);
                    }
                }
            }

            MealController mealc = new MealController();
            List<Meal> meals = new ArrayList<>();

            for(int i = 0; i < marketed.size(); i++) {
                int mealId = marketed.get(i).getMealId();
                meals.add(mealc.selectMealById(mealId));
                meals.get(i).setAllergens(mealc.selectAllAllergens(mealId));
            }

            ArrayList<Object> data = new ArrayList<>();
            data.add(marketed);
            data.add(meals);

            response.getWriter().write(gson.toJson(data));
        }
        catch (NumberFormatException | NullPointerException  e) {
            e.printStackTrace();
        }
    }
}
