package sk.uniza.kmikt.orders;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "TransferItemToMarketServlet", value = "/transfer-item")
public class TransferItemToMarketServlet extends HttpServlet {
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

            OrderController oc = new OrderController();

            if (oc.copyOrderItemToMarket(itemId) != 0 &&  oc.updateOrderItem(itemId, true) != 0) {
                response.sendRedirect("my-orders.jsp");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
