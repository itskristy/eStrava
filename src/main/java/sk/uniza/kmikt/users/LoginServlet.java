package sk.uniza.kmikt.users;

import org.springframework.security.crypto.bcrypt.BCrypt;
import sk.uniza.kmikt.employees.Employee;
import sk.uniza.kmikt.employees.EmployeeController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    private boolean checkData(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.equals("")) {
            System.out.println("Error !");
            return false;
        }
        if (password == null || password.equals("")) {
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
            out.print("Login failed");
            out.flush();
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserController usc = new UserController();
        EmployeeController ec = new EmployeeController();
        User user =  usc.selectUser(username);
        Employee loggedEmployee = ec.selectEmployee(user.getIdentificationNumber());

        try {
            if (BCrypt.checkpw(password, user.getPassword()) && user.getUsername() != null) {
                HttpSession session = request.getSession();
                session.setAttribute("logged", user.getRole());
                session.setAttribute("logged_user", user.getUsername());
                session.setAttribute("logged_id", user.getId());
                session.setAttribute("logged_identific", user.getIdentificationNumber());
                if(user.getRole().equals("employee")) {
                    session.setAttribute("logged_employee", loggedEmployee.getRole());
                }

            } else {
                out.print("Login failed");
                out.flush();
            }

        } catch (NullPointerException e){
            e.printStackTrace();
            out.print("Login failed");
            out.flush();
        }
    }
}
