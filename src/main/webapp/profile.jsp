<%@include file="index.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("logged") == null ) {
    response.sendRedirect("menu.jsp");
    return;
    }
%>

<div class="container">
    <jsp:include page="sidebar.jsp" />
    <div class="profile_container col-sm-9">
        <div class="profile_title">Môj profil</div>
        <div class="profile_card">
            <div class="users_name">
                <% if (!session.getAttribute("logged").equals("admin") && !session.getAttribute("logged").equals("pensioner")) {%>
                <%=firstName%> <%=lastName%> <%}
                else { %>
                <%=username%>
                <%}%>
            </div>

            <div class="card_items">
                <form method="post" id="update" action="updateUser?id=<%=id%>&identific=<%=identific%>" name="login" class="form" role="form">
                    <div class="form-group row">
                        <label for="email" class="col-sm-3 col-form-label">E-mail:</label>
                        <div class="col-sm-9"><input type="text" class="form-control" id="email" name="email" required value="<%=email%>"></div>
                    </div>
                    <% if (!session.getAttribute("logged").equals("admin") && !session.getAttribute("logged").equals("pensioner")) {%>
                    <div class="form-group row">
                        <label for="phone_number" class="col-sm-3 col-form-label">Telefónne číslo:</label>
                        <div class="col-sm-9"><input type="text" class="form-control" id="phone_number" name="phone_number" required value="<%=number%>"></div>
                    </div>
                    <% } %>
                    <div class="form-group row">
                        <label for="old_password" class="col-sm-3 col-form-label">Heslo:</label>
                        <div class="col-sm-9"><input type="password" class="form-control" id="old_password" name="old_password" value=""></div>
                    </div>
                    <div class="form-group row">
                        <label for="new_password" class="col-sm-3 col-form-label">Nové heslo:</label>
                        <div class="col-sm-9"><input type="password" class="form-control" id="new_password" name="new_password" value=""></div>
                    </div>
                    <div id="update_err"><i class="bi bi-exclamation-circle"></i></div>
                    <button type="submit" class="btn btn-primary" id="save_brn">Uložiť</button>
                </form>
                <br>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - Môj profil';

        $('#update_err').hide();

        $("#update").validate({
            rules: {
                email: {
                    required: true,
                    email: true,
                },
                phone_number: {
                    required: true,
                }
            }
        });
    });

    let update_form = $('#update');
    update_form.submit(function () {
        let email = $("#email").val();
        let number = $("#phone_number").val();

        if (email && number || email) {
            $.ajax({
                type: update_form.attr('method'),
                url: update_form.attr('action'),
                data: update_form.serialize(),
                success: function (data) {
                    if (data === "Update failed - 1") {
                        $('#update_err').show();
                        $('#update_err').text("Zadali ste zlé heslo.");
                    } else if (data === "Update failed - 2") {
                        $('#update_err').show();
                        $('#update_err').text("Heslo sa nepodarilo zmeniť.");
                    } else if (data === "Update failed") {
                        $('#update_err').show();
                        $('#update_err').text("Údaje sa nepodarilo aktualizovať.");
                    } else {
                        window.location = 'profile.jsp';
                    }
                }
            });
        }
        return false;
    });
</script>

