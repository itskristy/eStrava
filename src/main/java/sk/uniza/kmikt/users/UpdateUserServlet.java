package sk.uniza.kmikt.users;

import org.springframework.security.crypto.bcrypt.BCrypt;
import sk.uniza.kmikt.employees.Employee;
import sk.uniza.kmikt.employees.EmployeeController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateUserServlet", value = "/updateUser")
public class UpdateUserServlet extends HttpServlet {

    private boolean checkData(HttpServletRequest request) {
        String identific_num = request.getParameter("identific");
        if (!identific_num.equals("null")) {
            String email = request.getParameter("email");
            int number = Integer.parseInt(request.getParameter("phone_number"));

            if (email == null || email.equals("")) {
                System.out.println("Error !");
                return false;
            }
            if (number == 0) {
                System.out.println("Error !");
                return false;
            }
        } else {
            String email = request.getParameter("email");

            if (email == null || email.equals("")) {
                System.out.println("Error !");
                return false;
            }
        }


        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (!checkData(request)) {
            out.print("Update failed");
            out.flush();
            return;
        }

        try {
            int number = 0;
            String identific_num = request.getParameter("identific");
            String email = request.getParameter("email");
            if (!identific_num.equals("null")) {
                number = Integer.parseInt(request.getParameter("phone_number"));
            }
            int id = Integer.parseInt(request.getParameter("id"));
            String old_password = request.getParameter("old_password");
            String new_password = request.getParameter("new_password");

            String hashed = BCrypt.hashpw(new_password, BCrypt.gensalt());
            User user = new User(id, email, hashed);
            Employee employee = new Employee(identific_num, number);
            EmployeeController esc = new EmployeeController();
            UserController usc = new UserController();

            if (!old_password.equals("")) {
                if (BCrypt.checkpw(old_password, usc.selectUserById(id).getPassword())) {
                    if((usc.updateUserPassword(user) == 0)) {
                        out.print("Update failed - 2");
                        out.flush();
                        return;
                    }
                } else {
                    out.print("Update failed - 1");
                    out.flush();
                    return;
                }
            }

            if (((usc.updateUser(user) != 0 && esc.updateEmployee(employee) != 0)) || ((usc.updateUser(user) != 0 || esc.updateEmployee(employee) != 0))) {
                response.sendRedirect("profile.jsp");

            } else {
                out.print("Update failed");
                out.flush();
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.print("Update failed");
            out.flush();
        }
    }
}
