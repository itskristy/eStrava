package sk.uniza.kmikt.meals;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdatePricesServlet", value = "/update-prices")
public class UpdatePricesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        try {
            int id = Integer.parseInt(request.getParameter("mealId"));
            double priceCE = Double.parseDouble(request.getParameter("price_ce"));
            double pricePoliceman = Double.parseDouble(request.getParameter("price_policeman"));
            double pricePensioner = Double.parseDouble(request.getParameter("price_pensioner"));

            Meal meal = new Meal("", priceCE, pricePoliceman, pricePensioner);
            MealController mlc = new MealController();

            if(mlc.updateMealPrices(id, meal) != 0) {
                response.sendRedirect("meals.jsp");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
