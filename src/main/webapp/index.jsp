<%@ page import="sk.uniza.kmikt.employees.EmployeeController" %>
<%@ page import="sk.uniza.kmikt.employees.Employee" %>
<%@ page import="sk.uniza.kmikt.users.UserController" %>
<%@ page import="sk.uniza.kmikt.users.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>eStrava</title>
    <link rel="icon" href="https://www.svgrepo.com/show/11379/plate-with-fork-and-knife-cross.svg">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <! -- fonts -->
    <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;display=swap" rel="stylesheet">

    <! -- scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js" integrity="sha512-UdIMMlVx0HEynClOIFSyOrPggomfhBKJE28LKl8yR3ghkgugPnG6iLfRfHwushZl1MOPSY6TsuBDGPK2X4zYKg==" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/localization/messages_sk.js"> </script>

    <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"> </script>

    <! -- css -->
    <link rel="stylesheet" href="./css/style.css" type="text/css">
    <link rel="stylesheet" href="./css/sidebar.css" type="text/css">
    <link rel="stylesheet" href="./css/menu.css" type="text/css">
    <link rel="stylesheet" href="css/meals.css" type="text/css">
    <link rel="stylesheet" href="css/menus.css" type="text/css">
    <link rel="stylesheet" href="./css/profile.css" type="text/css">
    <link rel="stylesheet" href="css/my-orders.css" type="text/css">
    <link rel="stylesheet" href="css/boarders.css" type="text/css">
    <link rel="stylesheet" href="css/order-list.css" type="text/css">
    <link rel="stylesheet" href="css/market.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.0/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

</head>
<%  String firstName = "";
    String lastName = "";
    String email = "";
    int number = 0;
    int id = 0;
    String password = "";
    String identific = "";
    String username = "";

    EmployeeController esc = new EmployeeController();
    UserController usc = new UserController();

    if (session.getAttribute("logged") != null && !session.getAttribute("logged").equals("pensioner") && !session.getAttribute("logged").equals("admin")) {
        User loggedUser = usc.selectUser(session.getAttribute("logged_user").toString());
        Employee loggedEmployee = esc.selectEmployee(session.getAttribute("logged_identific").toString());
        firstName = loggedEmployee.getFirstName();
        lastName = loggedEmployee.getLastName();
        number = loggedEmployee.getPhoneNumber();
        email = loggedUser.getEmail();
        id = Integer.parseInt(session.getAttribute("logged_id").toString());
        identific = session.getAttribute("logged_identific").toString();
}

    if (session.getAttribute("logged") != null && session.getAttribute("logged").equals("admin")) {
        User loggedUser = usc.selectUser(session.getAttribute("logged_user").toString());
        email = loggedUser.getEmail();
        id = Integer.parseInt(session.getAttribute("logged_id").toString());
        identific = null;
    }

    if (session.getAttribute("logged") != null && (session.getAttribute("logged").equals("pensioner") || session.getAttribute("logged").equals("admin"))) {
        User loggedUser = usc.selectUser(session.getAttribute("logged_user").toString());
        email = loggedUser.getEmail();
        username = session.getAttribute("logged_user").toString();
    }
%>
<div class="top_line"></div>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">eStrava</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="menu.jsp">Jed??lny l??stok<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="market.jsp">Burza</a>
            </li>
        </ul>
    </div>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fa fa-user-o" aria-hidden="true"></i> M??j ????et
            </a>
            <% if (session.getAttribute("logged") == null ){ %>
            <div aria-labelledby="navbarDropdown" class="dropdown-menu">
                <ul class="px-3 py-2">
                    <form method="post" action="login" id="login" name="login" class="form" role="form">
                        <div class="form-group">
                            <input id="username" name="username" placeholder="Prihlasovacie meno" class="form-control form-control-sm" type="text" required>
                        </div>
                        <div class="form-group">
                            <input id="psswd" name="password" placeholder="Heslo" class="form-control form-control-sm" type="password" required>
                        </div>
                        <div id="login_err"><i class="bi bi-exclamation-circle"></i> Nespr??vne prihlasovacie ??daje.</div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Prihl??si??</button>
                        </div>
                        <div class="form-group text-center">
                            Nem??te ????et? <a href="" id="btn_register">Zaregistrujte sa</a><br>
                            Zabudli ste heslo? <a href="" id="btn_change_password">Obnovi??</a><br>
                        </div>
                    </form>
                    <form method="post" action="register" id="register" name="register" class="form" role="form">
                        <div class="form-group">
                            <input id="r_username" name="username" placeholder="Prihlasovacie meno" class="form-control form-control-sm" type="text" required>
                        </div>
                        <div class="form-group">
                            <input id="email" name="email" placeholder="E-mail" class="form-control form-control-sm" type="email" required>
                        </div>
                        <div class="form-group">
                            <input id="r_password" name="password" placeholder="Heslo" class="form-control form-control-sm" type="password" required>
                        </div>
                        <div class="form-group">
                            <select class="form-control" id="role" name="role" required>
                                <option value="" disabled="disabled" selected="selected">Vyberte zaradenie</option>
                                <option value="employee">Civiln?? zamestnanec</option>
                                <option value="employee">Pr??slu??n??k PZ</option>
                                <option value="pensioner">D??chodca</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input id="identification" name="identification" placeholder="Osobn?? ????slo" class="form-control form-control-sm" type="text" required minlength="6" maxlength="6">
                        </div>
                        <div id="reg_err"><i class="bi bi-exclamation-circle"></i> <div id="reg_err_mss"></div></div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Zaregistrova??</button>
                        </div>
                        <div class="form-group text-center">
                            U?? m??te ????et? <a href="" id="btn_login">Prihl??ste sa</a>
                        </div>
                    </form>
                    <form method="post" action="change-password" id="forgotten_password" name="forgotten_password" class="form" role="form">
                        <div class="form-group">
                            <input id="email_forgotten" name="email" placeholder="E-mail" class="form-control form-control-sm" type="email" required>
                        </div>
                        <div class="form-group">
                            <input id="new_password" name="new_password" placeholder="Nov?? heslo" class="form-control form-control-sm" type="password" required>
                        </div>
                        <div id="change_err"><i class="bi bi-exclamation-circle"></i> <div id="change_err_mss"></div></div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Obnovi?? heslo</button>
                        </div>
                        <div class="form-group text-center">
                            U?? m??te ????et? <a href="" id="btn_login_two">Prihl??ste sa</a>
                        </div>
                    </form>
                </ul>
            </div>
            <% } else if (!session.getAttribute("logged").equals("admin") && !session.getAttribute("logged").equals("pensioner")) { %>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                <a class="dropdown-item unclickable_item"><%=firstName%> <%=lastName%></a>
                <a class="dropdown-item" href="profile.jsp">Profilov?? ??daje</a>
                <a class="dropdown-item" href="my-orders.jsp">Hist??ria objedn??vok</a>
                <a class="dropdown-item logout" href="logout">Odhl??si??</a>
            </div>
            <% } else if (session.getAttribute("logged").equals("pensioner")) {
                %>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                <a class="dropdown-item unclickable_item"><%=username%></a>
                <a class="dropdown-item" href="profile.jsp">Profilov?? ??daje</a>
                <a class="dropdown-item" href="my-orders.jsp">Hist??ria objedn??vok</a>
                <a class="dropdown-item logout" href="logout">Odhl??si??</a>
            </div>
            <% } else {
                %>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                <a class="dropdown-item unclickable_item"><%=username%></a>
                <a class="dropdown-item" href="profile.jsp">Profilov?? ??daje</a>
                <a class="dropdown-item" href="menus.jsp">Spr??va jed??lnych l??skov</a>
                <a class="dropdown-item" href="meals.jsp">Spr??va jed??l</a>
                <a class="dropdown-item" href="boarders.jsp">Zoznam stravn??kov</a>
                <a class="dropdown-item" href="order-list.jsp">Zoznam objedn??vok</a>
                <a class="dropdown-item logout" href="logout">Odhl??si??</a>
            </div>
            <% } %>
        </li>
    </ul>
</nav>
</body>

<script>
        //toggle between login / register form
        $("#register").hide();
        $("#forgotten_password").hide()
        $("#btn_register").click(function(event){
            event.preventDefault();
            $("#login").toggle();
            $("#register").toggle(1000);

        });
        $("#btn_login").click(function(event){
            event.preventDefault();
            $("#register").toggle();
            $("#login").toggle(1000);
        });

        $("#btn_login_two").click(function(event){
            event.preventDefault();
            $("#forgotten_password").toggle();
            $("#login").toggle(1000);
        });

        $("#btn_change_password").click(function(event){
            event.preventDefault();
            $("#login").toggle();
            $("#forgotten_password").toggle(1000);
        });

        // show, hide identification field
        $("#role").on('change',function () {
            if ($("#role").val() === "employee") {
                $("#identification").show();
            } else {
                $("#identification").hide().val(null);
            }
        }).trigger("change");

        $(document).ready(function () {
            // validation
            $("#register").validate({
                rules: {
                    r_username: {
                        required: true,
                    },
                    email: {
                        required: true,
                        email: true,
                    },
                    r_password: {
                        required: true,
                        password: true,
                    },
                    role: {
                      required: true,
                    },
                    identification: {
                        required: true,
                        length: 6,
                    }
                }
            });
            $("#login").validate({
                rules: {
                    username: {
                        required: true,
                    },
                    psswd: {
                        required: true,
                        password: true,
                    }
                }
            });
            $("#forgotten_password").validate({
                rules: {
                    email_forgotten: {
                        required: true,
                        email: true,
                    },
                    new_password: {
                        required: true,
                        password: true,
                    }
                }
            });

            $('#identification').hide();
            $('#login_err').hide();
            $('#reg_err').hide();
            $('#change_err').hide();

            // display today's date
            $('#date_from').val(new Date().toISOString().slice(0, 10));
            let date = $('#date_from').val().replaceAll('-', '.').split(".");
            $('.menu_date').text( " " + date[2] + ". " + date[1] + ". " + date[0]);

            let dt = new Date();
            let month = dt.getMonth() + 1;     // getMonth() starts at 0
            let day = dt.getDate();
            let year = dt.getFullYear();
            if(month < 10)
                month = '0' + month.toString();
            if(day < 10)
                day = '0' + day.toString();

            let maxDate = year + '-' + month + '-' + day;
            $('#date_from').attr('min', maxDate);

            $('#date_from').change(function () {
                let date = $('#date_from').val().replaceAll('-', '.').split(".");
                $('.menu_date').text(date[2] + ". " + date[1] + ". " + date[0]);
            });
        });

        // login
        let log_form = $('#login');
        log_form.submit(function () {
            let username = $("#username").val();
            let password = $("#psswd").val();

            if (username && password) {
                $.ajax({
                    type: log_form.attr('method'),
                    url: log_form.attr('action'),
                    data: log_form.serialize(),
                    success: function (data) {
                        if (data === "Login failed") {
                            $('#login_err').show();
                        } else {
                            window.location = 'menu.jsp';
                        }
                    }
                });
            }
            return false;
        });

        // change password
        let passw_form = $('#forgotten_password');
        passw_form.submit(function () {
            let email = $("#email_forgotten").val();
            let password = $("#new_password").val();

            if (email && password) {
                $.ajax({
                    type: passw_form.attr('method'),
                    url: passw_form.attr('action'),
                    data: passw_form.serialize(),
                    success: function (data) {
                        if (data === "Change failed") {
                            $('#change_err').show();
                            $('#change_err_mss').text("E-mail neexistuje.");

                        } else if (data === "Change failed - 1") {
                            $('#change_err').show();
                            $('#change_err_mss').text("Heslo sa nepodarilo obnovi??.");

                        } else {
                            window.location = 'menu.jsp';
                        }
                    }
                });
            }
            return false;
        });

        // register
        let reg_form = $('#register');
        reg_form.submit(function () {
            let username = $("#r_username").val();
            let password = $("#r_password").val();
            let email = $("#email").val();

            if (username && password && email) {
                $.ajax({
                    type: reg_form.attr('method'),
                    url: reg_form.attr('action'),
                    data: reg_form.serialize(),
                    success: function (data) {
                        if (data === "Registration failed - 1") {
                            $('#reg_err').show();
                            $('#reg_err_mss').text("Osobn?? ????slo neexistuje.");

                        } else if (data === "Registration failed - 2") {
                            $('#reg_err').show();
                            $('#reg_err_mss').text("Prihlasovacie meno u?? existuje.");

                        } else if (data === "Registration failed - 3") {
                            $('#reg_err').show();
                            $('#reg_err_mss').text("E-mailov?? adresa je u?? pou??it??.");

                        } else if (data === "Registration failed - 4") {
                            $('#reg_err').show();
                            $('#reg_err_mss').text("Osobn?? ????slo je u?? pou??it??.");

                        } else if (data === "Registration failed") {
                            $('#reg_err').show();
                            $('#reg_err_mss').text("Registr??cia sa nepodarila.");

                        } else {
                            window.location = 'menu.jsp';
                        }
                    }
                });
            }
            return false;
        });
</script>
</html>