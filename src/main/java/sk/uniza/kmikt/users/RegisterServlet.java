package sk.uniza.kmikt.users;

import org.springframework.security.crypto.bcrypt.BCrypt;
import sk.uniza.kmikt.employees.EmployeeController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    private boolean checkData(HttpServletRequest request) {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || username.equals("")) {
            System.out.println("Error !");
            return false;
        }
        if (password == null || password.equals("")) {
            System.out.println("Error !");
            return false;
        }
        if (email == null || email.equals("")) {
            System.out.println("Error !");
            return false;
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
            out.print("Registration failed");
            out.flush();
            return;
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String identificationNumber = request.getParameter("identification");

        if (identificationNumber.equals("")) {
            identificationNumber = null;
        }

        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());

        User user = new User(username, email, hashed, role, identificationNumber);
        UserController usc = new UserController();
        EmployeeController esc = new EmployeeController();

        if (esc.selectEmployeeId(identificationNumber) == 1 || identificationNumber == null) {
            if (usc.selectUser(username) == null) {
                if (usc.countByEmail(email) == 0) {
                    if (usc.countById(identificationNumber) == 0) {
                        if (usc.insertUser(user) != 0) {
                            HttpSession session = request.getSession();
                            session.setAttribute("logged", role);
                            session.setAttribute("logged_user", username);
                            session.setAttribute("logged_id", user.getId());
                            session.setAttribute("logged_identific", user.getIdentificationNumber());

                        } else {
                            out.print("Registration failed");
                            out.flush();
                        }
                    } else {
                        out.print("Registration failed - 4");
                        out.flush();
                    }
                } else {
                    out.print("Registration failed - 3");
                    out.flush();
                }
            } else {
                out.print("Registration failed - 2");
                out.flush();
            }
        } else {
            out.print("Registration failed - 1");
            out.flush();
        }
    }
}
