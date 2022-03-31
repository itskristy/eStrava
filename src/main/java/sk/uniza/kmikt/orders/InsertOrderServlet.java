package sk.uniza.kmikt.orders;

import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.meals.MealController;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import sk.uniza.kmikt.menus.DailyMenu;
import sk.uniza.kmikt.menus.MenuController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "InsertOrderServlet", value = "/insert-order")
public class InsertOrderServlet extends HttpServlet {

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

            String[] amount = request.getParameterValues("portions");
            JsonElement data = JsonParser.parseString(request.getParameter("data"));
            boolean isPacked = Boolean.parseBoolean(request.getParameter("pack"));
            String date = request.getParameter("date_from");

            int userId = (Integer) session.getAttribute("logged_id");
            String role = (String) request.getSession().getAttribute("logged");
            String employee = (String) request.getSession().getAttribute("logged_employee");
            Date orderDate = new Date();

            JsonElement menu = (data.getAsJsonObject()).get("data");

            MenuController mc = new MenuController();
            int menuId = mc.selectMenuByDate(date);

            MealController mealc = new MealController();
            OrderController oc = new OrderController();
            Order order = new Order(userId, df.format(orderDate), menuId);

            int orderId;
            if (oc.insertOrder(order) != 0) {
                orderId = oc.selectLastAddedOrder();
                int count = 0;
                for(int i = 0; i < amount.length; i++) {

                    double price = 0;
                    for(int j = 0; j < Integer.parseInt(amount[i]); j++ ) {
                        int mealId = menu.getAsJsonArray().get(i).getAsJsonObject().get("id").getAsInt();

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

                            if (menu.getAsJsonArray().get(i).getAsJsonObject().get("category").getAsInt() == 1 && countBreakfast != 0) {
                                price = menu.getAsJsonArray().get(i).getAsJsonObject().get("price").getAsDouble();
                            } else if (menu.getAsJsonArray().get(i).getAsJsonObject().get("category").getAsInt() == 3 && countLunch != 0) {
                                price = menu.getAsJsonArray().get(i).getAsJsonObject().get("price").getAsDouble();
                            } else if (menu.getAsJsonArray().get(i).getAsJsonObject().get("category").getAsInt() == 4 && countDinner !=0) {
                                price = menu.getAsJsonArray().get(i).getAsJsonObject().get("price").getAsDouble();
                            } else {

                                if (role.equals("pensioner")) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("subsidizedPricePensioner").getAsDouble();
                                } else if (employee.equals("príslušník policajného zboru")) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("subsidizedPricePoliceman").getAsDouble();
                                } else if (employee.equals("civilný zamestnanec")) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("subsidizedPriceCE").getAsDouble();
                                }
                            }

                            if(i == 2 || i == 3 || i == 4) {
                                count += 1;
                                if(count > 1) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("price").getAsDouble();
                                }
                            }

                        } else {
                            if(j == 0) {
                                if (role.equals("pensioner")) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("subsidizedPricePensioner").getAsDouble();
                                } else if (employee.equals("príslušník policajného zboru")) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("subsidizedPricePoliceman").getAsDouble();
                                } else if (employee.equals("civilný zamestnanec")) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("subsidizedPriceCE").getAsDouble();
                                }

                            } else {
                                price = menu.getAsJsonArray().get(i).getAsJsonObject().get("price").getAsDouble();
                            }

                            if(i == 2 || i == 3 || i == 4) {
                                count += 1;
                                if(count > 1) {
                                    price = menu.getAsJsonArray().get(i).getAsJsonObject().get("price").getAsDouble();
                                }
                            }
                        }

                        oc.insertOrderItems(orderId, mealId, price, isPacked, false);
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
