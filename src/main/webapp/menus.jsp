<%@ page import="sk.uniza.kmikt.menus.MenuController" %>
<%@ page import="sk.uniza.kmikt.menus.DailyMenu" %>
<%@ page import="sk.uniza.kmikt.meals.MealController" %>
<%@ page import="sk.uniza.kmikt.meals.Meal" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.uniza.kmikt.orders.OrderController" %>
<%@include file="index.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    MenuController mc = new MenuController();
    MealController mlc = new MealController();
    List<DailyMenu> menus = mc.selectAllMenus();
    List<Meal> meals = mlc.selectAllMeals();

    int menuId = 0;
    String sqlDate = null;
    String date = null;

    if (session.getAttribute("logged") == null && session.getAttribute("logged").equals("admin")) {
        response.sendRedirect("menu.jsp");
        return;
    }
%>

<div class="container">
    <jsp:include page="sidebar.jsp" />
        <div class="manage_menus_container col-sm-9">
            <div class="menus_title">Správa jedálnych lístkov</div>
            <div class="menus_card">
                <table class="table table-striped" id="menus">
                    <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col" style="width: 130px" class="col_name">Raňajky</th>
                        <th scope="col" style="width: 130px" class="col_name">Polievky</th>
                        <th scope="col" style="width: 130px" class="col_name">Hlavné jedlá</th>
                        <th scope="col" style="width: 130px" class="col_name">Večere</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                            OrderController oc = new OrderController();
                            int numOrders = 0;
                                for (DailyMenu menu : menus) {
                                menuId = menu.getMenuId();
                                date = menu.getDate();
                                sqlDate = menu.getSqlDate();
                                numOrders = oc.selectOrdersByMenu(menuId).size();
                                    %>
                    <tr>
                        <td class="menus_date"><input type="text" name="name" class="form-control" required value="<%=date%>"/></td>
                        <td><a class="btn btn-primary" data-toggle="modal" data-date="<%=sqlDate%>" data-menu="<%=menuId%>" data-category="1" data-target="#breakfastModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                        <td><a class="btn btn-primary" data-toggle="modal" data-date="<%=sqlDate%>" data-menu="<%=menuId%>" data-category="2" data-target="#soupModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                        <td><a class="btn btn-primary" data-toggle="modal" data-date="<%=sqlDate%>" data-menu="<%=menuId%>" data-category="3" data-target="#lunchModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                        <td><a class="btn btn-primary" data-toggle="modal" data-date="<%=sqlDate%>" data-menu="<%=menuId%>" data-category="4" data-target="#dinnerModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                        <% if (numOrders == 0) {%>
                        <td><a class="btn btn-danger" href="delete-menu?id=<%=menuId%>" role="button"><i class="bi bi-trash-fill"></i></a></td>
                        <% } else { %>
                            <td></td>
                        <% }%>
                    </tr>
                    <% }
                                %>

                        <tr class="new-entry">
                            <form method="post" action="insert-menu" name="insert-menu" class="form" role="form">
                                <td class="name"><input type="date" class="form-control" id="menu_date" name="menu_date" required></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><button class="btn btn-primary" type="submit"><i class="bi bi-save-fill"></i></button></td>
                                <td></td>
                            </form>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>

    <div class="modal fade mealModal" id="breakfastModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Raňajky</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="post" action="update-items" name="breakfast_update" id="breakfast_update" class="form_update" role="form">
                    <div class="modal-body edit-content">
                        <% for (Meal meal : meals) {
                            if (meal.getCategory() == 1) {
                                String name = meal.getMeal();
                                int meal_id = meal.getId();
                        %>
                        <div><input type="checkbox" value="<%=meal_id%>" name="meal" class="breakfast"><%=name%></div>
                        <% }
                        }
                        %>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary saveBtn" type="submit">Uložiť</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade mealModal" id="soupModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Polievky</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="post" action="update-allergens" name="soup_update" id="soup_update" class="form_update" role="form">
                    <div class="modal-body edit-content">
                        <% for (Meal meal : meals) {
                            if (meal.getCategory() == 2) {
                                String name = meal.getMeal();
                                int meal_id = meal.getId();
                        %>
                        <div><input type="checkbox" value="<%=meal_id%>" name="meal" class="soup"><%=name%></div>
                        <% }
                        }
                        %>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary saveBtn" type="submit">Uložiť</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade mealModal" id="lunchModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Hlavné jedlá</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="post" action="update-allergens" name="lunch_update" id="lunch_update" class="form_update" role="form">
                    <div class="modal-body edit-content">
                        <% for (Meal meal : meals) {
                            if (meal.getCategory() == 3) {
                                String name = meal.getMeal();
                                int meal_id = meal.getId();
                        %>
                        <div><input type="checkbox" value="<%=meal_id%>" name="meal" class="lunch"><%=name%></div>
                        <% }
                        }
                        %>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary saveBtn" type="submit">Uložiť</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade mealModal" id="dinnerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Večere</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="post" action="update-allergens" name="dinner_update" id="dinner_update" class="form_update" role="form">
                    <div class="modal-body edit-content">
                        <% for (Meal meal : meals) {
                            if (meal.getCategory() == 4) {
                                String name = meal.getMeal();
                                int meal_id = meal.getId();
                        %>
                        <div><input type="checkbox" value="<%=meal_id%>" name="meal" class="dinner"><%=name%></div>
                        <% }
                        }
                        %>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary saveBtn" type="submit">Uložiť</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - Správa jedálnych lístkov';
    });

    $('#menus').DataTable({
        ordering:  false,
        searching: false,
        info: false,
        lengthChange: false,
        pagingType: "simple",
        pageLength: 8,
        retrieve: true,

        language: {
            paginate: {
                "next": '<i class="bi bi-chevron-right"></i>',
                "previous": '<i class="bi bi-chevron-left"></i>'
            },
            zeroRecords: "Nenašli sa žiadne zodpovedajúce záznamy."
        }
    });

    $('.mealModal').on('show.bs.modal', function(e) {
        let modal = $(this);
        let menuDate = $(e.relatedTarget).data('date');
        let tDate = new Date().toISOString().slice(0,10);

        // reset button
        $(".saveBtn").attr('disabled', false);

        if(menuDate <= tDate) {
            $(".saveBtn").attr('disabled', true);
        }
    });

    let menuId;
    let category;
    $('#breakfastModal').on('show.bs.modal', function(e) {
        menuId = $(e.relatedTarget).data('menu');
        category = $(e.relatedTarget).data('category');

        // reset of checkboxes
        $(".breakfast").each(function(index) {
            $( this ).attr('checked', false);
        });

        $.ajax({
            type: 'POST',
            url: 'load-items',
            data: 'id=' + menuId,
            success: function(data) {
                data = JSON.parse(data);
                $(".breakfast").each(function(index) {
                    let breakfast = $( this ).val();
                    data.forEach(id => {
                        if(breakfast == id) {
                            $( this ).attr('checked', true);
                        }
                    });

                    if ($('.breakfast:checked').length >= 1) {
                        $(".breakfast").not(":checked").attr("disabled",true);
                    }
                });
            }
        });

        $('.breakfast').click(function(){
            if ($('.breakfast:checked').length >= 1) {
                $(".breakfast").not(":checked").attr("disabled",true);
            }
            else
                $(".breakfast").not(":checked").removeAttr('disabled');
        });
    });

    $('#breakfastModal').on("hidden.bs.modal", function(){
        $(this).find('#breakfast_update').trigger('reset');
        $(".breakfast").each(function(index) {
            $( this ).attr('disabled', false);
        });
    });

    $('#soupModal').on('show.bs.modal', function(e) {
        menuId = $(e.relatedTarget).data('menu');
        category = $(e.relatedTarget).data('category');

        // reset of checkboxes
        $(".soup").each(function(index) {
            $( this ).attr('checked', false);
        });

        $.ajax({
            type: 'POST',
            url: 'load-items',
            data: 'id=' + menuId,
            success: function(data) {
                data = JSON.parse(data);
                $(".soup").each(function(index) {
                    let soup = $( this ).val();
                    data.forEach(id => {
                        if(soup == id) {
                            $( this ).attr('checked', true);
                        }
                    });

                    if ($('.soup:checked').length >= 1) {
                        $(".soup").not(":checked").attr("disabled",true);
                    }
                });
            }
        });

        $('.soup').click(function(){
            if ($('.soup:checked').length >= 1) {
                $(".soup").not(":checked").attr("disabled",true);
            }
            else
                $(".soup").not(":checked").removeAttr('disabled');
        });
    });

    $('#soupModal').on("hidden.bs.modal", function(){
        $(this).find('#soup_update').trigger('reset');
        $(".soup").each(function(index) {
            $( this ).attr('disabled', false);
        });
    });

    $('#lunchModal').on('show.bs.modal', function(e) {
        menuId = $(e.relatedTarget).data('menu');
        category = $(e.relatedTarget).data('category');

        // reset of checkboxes
        $(".lunch").each(function(index) {
            $( this ).attr('checked', false);
        });

        $.ajax({
            type: 'POST',
            url: 'load-items',
            data: 'id=' + menuId,
            success: function(data) {
                data = JSON.parse(data);
                $(".lunch").each(function(index) {
                    let lunch = $( this ).val();
                    data.forEach(id => {
                        if(lunch == id) {
                            $( this ).attr('checked', true);
                        }
                    });

                    if ($('.lunch:checked').length >= 3) {
                        $(".lunch").not(":checked").attr("disabled",true);
                    }
                });
            }
        });

        $('.lunch').click(function(){
            if ($('.lunch:checked').length >= 3) {
                $(".lunch").not(":checked").attr("disabled",true);
            }
            else
                $(".lunch").not(":checked").removeAttr('disabled');
        });
    });

    $('#lunchModal').on("hidden.bs.modal", function(){
        $(this).find('#lunch_update').trigger('reset');
        $(".lunch").each(function(index) {
            $( this ).attr('disabled', false);
        });
    });

    $('#dinnerModal').on('show.bs.modal', function(e) {
        menuId = $(e.relatedTarget).data('menu');
        category = $(e.relatedTarget).data('category');

        // reset of checkboxes
        $(".dinner").each(function(index) {
            $( this ).attr('checked', false);
        });

        $.ajax({
            type: 'POST',
            url: 'load-items',
            data: 'id=' + menuId,
            success: function(data) {
                data = JSON.parse(data);
                $(".dinner").each(function(index) {
                    let dinner = $( this ).val();
                    data.forEach(id => {
                        if(dinner == id) {
                            $( this ).attr('checked', true);
                        }
                    });

                    if ($('.dinner:checked').length >= 1) {
                        $(".dinner").not(":checked").attr("disabled",true);
                    }
                });
            }
        });

        $('.dinner').click(function(){
            if ($('.dinner:checked').length >= 1) {
                $(".dinner").not(":checked").attr("disabled",true);
            }
            else
                $(".dinner").not(":checked").removeAttr('disabled');
        });
    });

    $('#dinnerModal').on("hidden.bs.modal", function(){
        $(this).find('#dinner_update').trigger('reset');
        $(".dinner").each(function(index) {
            $( this ).attr('disabled', false);
        });
    });

    let form_update = $('.form_update');
    form_update.submit(function () {
        let items = JSON.stringify($(form_update).serializeArray());

        if (menuId) {
            $.ajax({
                cache: false,
                type: form_update.attr('method'),
                url: form_update.attr('action'),
                data: '&items=' + items +'&category='+ category + '&menuId='+ menuId,
                success: function (data) {
                    window.location = 'menus.jsp';
                }
            });
        }
        return false;
    });
</script>
