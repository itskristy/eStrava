<%@ page import="sk.uniza.kmikt.meals.MealController" %>
<%@ page import="sk.uniza.kmikt.meals.Meal" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.uniza.kmikt.allergens.AllergenController" %>
<%@ page import="sk.uniza.kmikt.allergens.Allergen" %>
<%@ page import="sk.uniza.kmikt.orders.OrderController" %>
<%@ page import="sk.uniza.kmikt.menus.MenuController" %>
<%@include file="index.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    MealController mlc = new MealController();
    List<Meal> meals = mlc.selectAllMeals();

    String name = "";
    double price = 0;
    int meal_id = 0;

    if (session.getAttribute("logged") == null && session.getAttribute("logged").equals("admin")) {
        response.sendRedirect("menu.jsp");
        return;
    }
%>

<div class="container">
    <jsp:include page="sidebar.jsp" />
    <div class="manage_meals_container col-sm-9">
        <div class="meals_title">Správa jedál</div>
        <div class="meals_card">
            <div id="accordion">
            <div class="card">
                <div class="card-header" id="breakfast">
                    <h5 class="mb-0">
                        <button class="btn btn-link" data-toggle="collapse" data-target="#col_breakfast" aria-expanded="false" aria-controls="col_breakfast">
                            <i class="bi bi-chevron-right"></i> Raňajky
                        </button>
                    </h5>
                </div>

                <div id="col_breakfast" class="collapse collapsed" aria-labelledby="breakfast" data-parent="#accordion">
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col" style="width: 150px" class="col_name">Bežná cena €</th>
                                <th scope="col" style="width: 100px" class="col_name">Dotácie €</th>
                                <th scope="col" style="width: 100px" class="col_name">Alergény</th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <%

                                MenuController mc = new MenuController();
                                int numOrders = 0;
                                for (Meal meal : meals) {
                                if (meal.getCategory() == 1) {
                                    name = meal.getMeal();
                                    price = meal.getPrice();
                                    meal_id = meal.getId();
                                    numOrders = mc.selectMenuItemByMealId(meal_id);
                                    %>
                            <tr>
                                <form method="post" action="update-meal?id=<%=meal_id%>" name="update" class="form" role="form">
                                    <td class="name"><input type="text" name="name" class="form-control" required value="<%=name%>"/></td>
                                    <td><input type="text" name="price" class="form-control price" value="<%=price%>" required/></td>
                                    <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#subsidizedPriceModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                    <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#allergenModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                    <td><button class="btn btn-primary" type="submit"><i class="bi bi-pencil-fill"></i></button></td>
                                    <% if (numOrders == 0) {%>
                                    <td><a class="btn btn-danger" href="delete-meal?id=<%=meal_id%>" role="button"><i class="bi bi-trash-fill"></i></a></td>
                                    <% } else { %>
                                    <td></td>
                                    <% }%>
                                </form>
                            </tr>
                            <%
                                }
                            }
                            %>
                            <tr class="new-entry">
                                <form method="post" action="insert-meal?category=1" name="insert" class="form" role="form">
                                    <td class="name"><input type="text" name="name" class="form-control" required value=""/></td>
                                    <td><input type="text" name="price"class="form-control price" required value=""/></td>
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
            </div>
                <div class="card">
                    <div class="card-header" id="soup">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#col_soup" aria-expanded="false" aria-controls="col_soup">
                                <i class="bi bi-chevron-right"></i> Polievky
                            </button>
                        </h5>
                    </div>
                    <div id="col_soup" class="collapse" aria-labelledby="soup" data-parent="#accordion">
                        <div class="card-body">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col" style="width: 150px" class="col_name">Bežná cena €</th>
                                        <th scope="col" style="width: 100px" class="col_name">Dotácie €</th>
                                        <th scope="col" style="width: 100px" class="col_name">Alergény</th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for (Meal meal : meals) {
                                            if (meal.getCategory() == 2) {
                                                name = meal.getMeal();
                                                price = meal.getPrice();
                                                meal_id = meal.getId();
                                                numOrders = mc.selectMenuItemByMealId(meal_id);
                                    %>
                                    <tr>
                                        <form method="post" action="update-meal?id=<%=meal_id%>" name="update" class="form" role="form">
                                            <td class="name"><input type="text" name="name" class="form-control" required value="<%=name%>"/></td>
                                            <td><input type="text" name="price" class="form-control price" value="<%=price%>" required/></td>
                                            <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#subsidizedPriceModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                            <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#allergenModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                            <td><button class="btn btn-primary" type="submit"><i class="bi bi-pencil-fill"></i></button></td>
                                            <% if (numOrders == 0) {%>
                                            <td><a class="btn btn-danger" href="delete-meal?id=<%=meal_id%>" role="button"><i class="bi bi-trash-fill"></i></a></td>
                                            <% } else { %>
                                            <td></td>
                                            <% }%>
                                        </form>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                    <tr class="new-entry">
                                        <form method="post" action="insert-meal?category=2" name="insert" class="form" role="form">
                                            <td class="name"><input type="text" name="name" class="form-control" required value=""/></td>
                                            <td><input type="text" name="price"class="form-control price" required value=""/></td>
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
                </div>
                <div class="card">
                    <div class="card-header" id="headingThree">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                <i class="bi bi-chevron-right"></i> Hlavné jedlá
                            </button>
                        </h5>
                    </div>
                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                        <div class="card-body">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col" style="width: 150px" class="col_name">Bežná cena €</th>
                                        <th scope="col" style="width: 100px" class="col_name">Dotácie €</th>
                                        <th scope="col" style="width: 100px" class="col_name">Alergény</th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%

                                        for (Meal meal : meals) {
                                            if (meal.getCategory() == 3) {
                                                name = meal.getMeal();
                                                price = meal.getPrice();
                                                meal_id = meal.getId();
                                                numOrders = mc.selectMenuItemByMealId(meal_id);
                                    %>
                                    <tr>
                                        <form method="post" action="update-meal?id=<%=meal_id%>" name="update" class="form" role="form">
                                            <td class="name"><input type="text" name="name" class="form-control" required value="<%=name%>"/></td>
                                            <td><input type="text" name="price" class="form-control price" value="<%=price%>" required/></td>
                                            <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#subsidizedPriceModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                            <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#allergenModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                            <td><button class="btn btn-primary" type="submit"><i class="bi bi-pencil-fill"></i></button></td>
                                            <% if (numOrders == 0) {%>
                                            <td><a class="btn btn-danger" href="delete-meal?id=<%=meal_id%>" role="button"><i class="bi bi-trash-fill"></i></a></td>
                                            <% } else { %>
                                            <td></td>
                                            <% }%>
                                        </form>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                    <tr class="new-entry">
                                        <form method="post" action="insert-meal?category=3" name="insert" class="form" role="form">
                                            <td class="name"><input type="text" name="name" class="form-control" required value=""/></td>
                                            <td><input type="text" name="price"class="form-control price" required value=""/></td>
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
                </div>
                <div class="card">
                    <div class="card-header" id="headingFour">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                <i class="bi bi-chevron-right"></i> Večere
                            </button>
                        </h5>
                    </div>
                    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordion">
                        <div class="card-body">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col" style="width: 150px" class="col_name">Bežná cena €</th>
                                        <th scope="col" style="width: 100px" class="col_name">Dotácie €</th>
                                        <th scope="col" style="width: 100px" class="col_name">Alergény</th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%

                                        for (Meal meal : meals) {
                                            if (meal.getCategory() == 4) {
                                                name = meal.getMeal();
                                                price = meal.getPrice();
                                                meal_id = meal.getId();
                                                numOrders = mc.selectMenuItemByMealId(meal_id);
                                    %>
                                    <tr>
                                        <form method="post" action="update-meal?id=<%=meal_id%>" name="update" class="form" role="form">
                                            <td class="name"><input type="text" name="name" class="form-control" required value="<%=name%>"/></td>
                                            <td><input type="text" name="price" class="form-control price" value="<%=price%>" required/></td>
                                            <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#subsidizedPriceModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                            <td><a class="btn btn-primary" data-toggle="modal" data-meal-id="<%=meal_id%>" data-target="#allergenModal" role="button"><i class="bi bi-plus-lg"></i></a></td>
                                            <td><button class="btn btn-primary" type="submit"><i class="bi bi-pencil-fill"></i></button></td>
                                            <% if (numOrders == 0) {%>
                                            <td><a class="btn btn-danger" href="delete-meal?id=<%=meal_id%>" role="button"><i class="bi bi-trash-fill"></i></a></td>
                                            <% } else { %>
                                            <td></td>
                                            <% }%>
                                        </form>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                    <tr class="new-entry">
                                        <form method="post" action="insert-meal?category=4" name="insert" class="form" role="form">
                                            <td class="name"><input type="text" name="name" class="form-control" required value=""/></td>
                                            <td><input type="text" name="price"class="form-control price" required value=""/></td>
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
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="allergenModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <%  AllergenController alc = new AllergenController();
            List<Allergen> allergens = alc.selectAllAllergens();
        %>
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Alergénne zložky</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="post" action="update-allergens" name="allergen_update" id="allergen_update" class="form" role="form">
                <div class="modal-body edit-content">
                    <% for (Allergen allergen : allergens) {
                    int allergen_id = allergen.getId();
                    String allergen_name = allergen.getName();
                    %>
                        <div><input type="checkbox" value="<%=allergen_id%>" name="allergen" class="allergen"><%=allergen_name%></div>
                <% } %>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit">Uložiť</button>
                </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="subsidizedPriceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Dotácie €</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="POST" action="update-prices" name="prices_update" id="prices_update" class="form" role="form">
                    <div class="modal-body edit-content">
                        <div class="form-group row">
                            <label class="col-sm-6 col-form-label" for="price_ce">Civilný zamestnanec</label>
                            <div class="col-sm-4"><input type="text" class="form-control" name="price_ce" id="price_ce" required value=""></div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-6 col-form-label" for="price_policeman">Príslušník policajného zboru</label>
                            <div class="col-sm-4"><input type="text" class="form-control" name="price_policeman" id="price_policeman" required value=""></div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-6 col-form-label" for="price_pensioner">Dôchodca</label>
                            <div class="col-sm-4"><input type="text" class="form-control" name="price_pensioner" id="price_pensioner" required value="">
                        </div>
                    </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" type="submit">Uložiť</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - Správa jedál';

        $(".update").validate({
            rules: {
                name: {
                    required: true,
                },
                subsidized_price: {
                    required: true,
                },
                price: {
                    required: true,
                }
            }
        });

        $(".insert").validate({
            rules: {
                name: {
                    required: true,
                },
                subsidized_price: {
                    required: true,
                },
                price: {
                    required: true,
                }
            }
        });
    });


    let mealId;
    $('#allergenModal').on('show.bs.modal', function(e) {
        let modal = $(this);
        mealId = $(e.relatedTarget).data('meal-id');

        // reset of checkboxes
        $(".allergen").each(function(index) {
            $( this ).attr('checked', false);
        });

        $.ajax({
            type: 'POST',
            url: 'load-allergens',
            data: 'id=' + mealId,
            success: function(data) {
                data = JSON.parse(data);
                $(".allergen").each(function(index) {
                    let allergen = $( this ).val();
                    data.forEach(id => {
                        if(allergen == id) {
                            $( this ).attr('checked', true);
                        }
                    });
                });
            }
        });
    });

    $('#allergenModal').on("hidden.bs.modal", function(){
        $(this).find('#allergen_update').trigger('reset');
        $(".allergen").each(function(index) {
            $( this ).attr('disabled', false);
        });
    });

    let allergen_form = $('#allergen_update');
    allergen_form.submit(function () {
        let allergens = JSON.stringify($(allergen_form).serializeArray());

        if (mealId) {
            $.ajax({
                cache: false,
                type: allergen_form.attr('method'),
                url: allergen_form.attr('action'),
                data: '&allergens=' + allergens +'&mealId='+ mealId,
                success: function (data) {
                    window.location = 'meals.jsp';
                }
            });
        }
        return false;
    });

    $('#subsidizedPriceModal').on('show.bs.modal', function(e) {
        let modal = $(this);
        mealId = $(e.relatedTarget).data('meal-id');

        $.ajax({
            type: 'POST',
            url: 'load-prices',
            data: 'id=' + mealId,
            success: function(data) {
                data = JSON.parse(data);
                let meal = data[0];

                console.log(meal);
                $('#price_ce').val(meal.subsidizedPriceCE);
                $('#price_policeman').val(meal.subsidizedPricePoliceman);
                $('#price_pensioner').val(meal.subsidizedPricePensioner);
            }
        });
    });

    let prices_form = $('#prices_update');
    prices_form.submit(function () {
        let data = JSON.stringify($(prices_form).serializeArray());
        console.log(data);
        if (mealId) {
            $.ajax({
                cache: false,
                type: prices_form.attr('method'),
                url: prices_form.attr('action'),
                data: prices_form.serialize() +'&mealId='+ mealId,
                success: function (data) {
                    window.location = 'meals.jsp';
                }
            });
        }
        return false;
    });
</script>