package sk.uniza.kmikt.users;

import org.springframework.security.crypto.bcrypt.BCrypt;
import sk.uniza.kmikt.employees.Employee;
import sk.uniza.kmikt.employees.EmployeeController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ChangeForgottenPasswordServlet", value = "/change-password")
public class ChangeForgottenPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {

            String password = request.getParameter("new_password");
            String email = request.getParameter("email");

            UserController usc = new UserController();

            if (usc.countByEmail(email) == 1) {
                String hashed = BCrypt.hashpw(password, BCrypt.gensalt());

                if((usc.updateUserPasswordByEmail(hashed, email) == 0)) {
                    out.print("Change failed - 1");
                    out.flush();
                    return;
                } else {
                    response.sendRedirect("menu.jsp");
                }

            } else {
                out.print("Change failed");
                out.flush();
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.print("Change failed");
            out.flush();
        }
    }
}
