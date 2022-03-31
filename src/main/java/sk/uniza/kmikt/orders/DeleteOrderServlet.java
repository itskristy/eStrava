package sk.uniza.kmikt.orders;

import sk.uniza.kmikt.menus.MenuController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteOrderServlet", value = "/delete-order")
public class DeleteOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            OrderController oc = new OrderController();
            if(oc.deleteOrderItem(itemId) != 0) {
                if(oc.selectOrderItems(orderId).size() == 0) {
                    oc.deleteOrder(orderId);
                }
                response.sendRedirect("my-orders.jsp");

            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
