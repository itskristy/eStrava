package sk.uniza.kmikt.orders;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import sk.uniza.kmikt.market.MarketController;
import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.meals.MealController;
import sk.uniza.kmikt.menus.MenuController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "InsertMarketedOrderServlet", value = "/insert-marketed-order")
public class InsertMarketedOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            HttpSession session = request.getSession();
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

            String[] ordered = request.getParameterValues("meal");
            boolean isPacked = Boolean.parseBoolean(request.getParameter("pack"));
            String date = request.getParameter("date_from");

            int userId = (Integer) session.getAttribute("logged_id");
            String role = (String) request.getSession().getAttribute("logged");
            String employee = (String) request.getSession().getAttribute("logged_employee");
            Date orderDate = new Date();

            MenuController mc = new MenuController();
            int menuId = mc.selectMenuByDate(date);

            MarketController market = new MarketController();
            MealController mealc = new MealController();
            OrderController oc = new OrderController();
            Order order = new Order(userId, df.format(orderDate), menuId);

            int orderId;
            if (oc.insertOrder(order) != 0) {
                orderId = oc.selectLastAddedOrder();
                int count = 0;
                for(int i = 0; i < ordered.length; i++) {

                    double price = 0;
                    OrderItem item = oc.selectOrderItemById(Integer.parseInt(ordered[i]));
                    int mealId = item.getMealId();
                    Meal selectedMeal = mealc.selectMealById(mealId);

                    int countBreakfast = 0;
                    int countLunch = 0;
                    int countDinner = 0;
                    if(oc.selectOrdersByMenuIdForUser(menuId, userId).size() != 0) {
                        List<Order> orders = oc.selectOrdersByMenuIdForUser(menuId, userId);

                        for (int o = 0; o < orders.size(); o++) {
                            List<OrderItem> items = oc.selectOrderItems(orders.get(o).getId());
                            for(int it = 0; it < items.size(); it++) {
                                Meal meal = mealc.selectMealById(items.get(it).getMealId());

                                if(meal.getCategory() == 1) {
                                    countBreakfast += 1;
                                } else if(meal.getCategory() == 3) {
                                    countLunch += 1;
                                } else if(meal.getCategory() == 4) {
                                    countDinner += 1;
                                }
                            }
                        }

                        if (selectedMeal.getCategory() == 1 && countBreakfast != 0) {
                            price = selectedMeal.getPrice();
                        } else if (selectedMeal.getCategory() == 3 && countLunch != 0) {
                            price = selectedMeal.getPrice();
                        } else if (selectedMeal.getCategory() == 4 && countDinner !=0) {
                            price = selectedMeal.getPrice();
                        } else {

                            if (role.equals("pensioner")) {
                                price = selectedMeal.getSubsidizedPricePensioner();
                            } else if (employee.equals("príslušník policajného zboru")) {
                                price = selectedMeal.getSubsidizedPricePoliceman();
                            } else if (employee.equals("civilný zamestnanec")) {
                                price = selectedMeal.getSubsidizedPriceCE();
                            }
                        }

                        if(i == 2 || i == 3 || i == 4) {
                            count += 1;
                            if(count > 1) {
                                price = selectedMeal.getPrice();
                            }
                        }
                    }

                    oc.insertOrderItems(orderId, mealId, price, isPacked, false);
                    market.deleteMarketedItem(item.getItemId());
                    if(oc.deleteOrderItem(item.getItemId()) != 0) {
                        if(oc.selectOrderItems(item.getOrderId()).size() == 0) {
                            oc.deleteOrder(item.getOrderId());
                        }
                    }

                }
                response.sendRedirect("menu.jsp");
            }
        }
        catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
