package sk.uniza.kmikt.users;

import com.google.gson.Gson;
import sk.uniza.kmikt.orders.Order;
import sk.uniza.kmikt.orders.OrderController;
import sk.uniza.kmikt.orders.OrderItem;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "LoadUsersWithCreditServlet", value = "/load-users")
public class LoadUsersWithCreditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();

        String fromDate = request.getParameter("credit_from");
        String toDate = request.getParameter("credit_to");

        UserController us = new UserController();
        List<User> users = us.selectAllActiveUsers();

        List<Order> orders = new ArrayList<>();
        OrderController oc = new OrderController();

        if (oc.selectOrdersByMonth(fromDate, toDate).size() != 0) {
            orders.addAll(oc.selectOrdersByMonth(fromDate, toDate));
        }

        List<OrderItem> items = new ArrayList<>();
        for (Order value : orders) {
            int orderId = value.getId();
            items.addAll(oc.selectOrderItems(orderId));
        }

        List<Double> usersCredit = new ArrayList<>();
        for (User user: users) {
            double credit = 0;
            for (Order order: orders) {
                if (user.getId() == order.getUserId()) {
                    for (OrderItem item: items) {
                        if (item.getOrderId() == order.getId()) {
                            credit += item.getPrice();
                            if (item.isPacked()) {
                                credit += 0.40;
                            }
                        }
                    }
                }
            }
            usersCredit.add(credit);
        }

        ArrayList<Object> data = new ArrayList<>();
        data.add(users);
        data.add(usersCredit);
        data.add(orders);

        response.getWriter().write(gson.toJson(data));
    }
}
