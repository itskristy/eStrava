<%@include file="index.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container">
    <jsp:include page="sidebar.jsp" />
    <div class="menu_container col-sm-9">
        <div class="menu_title">Jedálny lístok</div>
        <div class="menu_date"></div>
        <form method="post" action="insert-order" name="order" id="order" role="form">
        <div class="meals_container" id="breakfast">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th scope="col" id="breakfast_subtitle" class="col-md-1">Raňajky</th>
                        <th scope="col" style="width: 650px;"></th>
                        <% if(session.getAttribute("logged") != null) {%>
                        <th scope="col" class="column_name" style="width: 100px;">Porcia</th>
                        <% if(!session.getAttribute("logged").equals("admin")) {%>
                        <th scope="col" class="column_name">Dotácia €</th>
                        <% } %>
                        <th scope="col" class="column_name">Bežná cena €</th>
                        <% } %>
                    </tr>
                    </thead>
                    <tbody class="breakfast_body">
                    <tr>
                        <th class="breakfast_col_nr"></th>
                        <td class="breakfast_col_meal"></td>
                        <% if(session.getAttribute("logged") != null) {%>
                        <td><input type="number" name="portions" class="form-control portions" value="0" min="0" autocomplete="off"/></td>
                        <% if(!session.getAttribute("logged").equals("admin")) {%>
                        <td class="breakfast_col_subsidized"></td>
                        <% } %>
                        <td class="breakfast_col_price"></td>
                        <% } %>
                    </tr>
                    </tbody>
                </table>
        </div>
        <div class="meals_container" id="lunch">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th scope="col" id="lunch_subtitle" class="col-md-1">Obed</th>
                    <th scope="col" style="width: 650px;"></th>
                    <% if(session.getAttribute("logged") != null) {%>
                    <th scope="col" class="column_name" style="width: 100px;">Porcia</th>
                    <% if(!session.getAttribute("logged").equals("admin")) {%>
                    <th scope="col" class="column_name">Dotácia €</th>
                    <% } %>
                    <th scope="col" class="column_name">Bežná cena €</th>
                    <% } %>
                </tr>
                </thead>
                <tbody class="lunch_body">
                <tr class="soup">
                    <th class="soup_col_nr"></th>
                    <td class="soup_col_meal"></td>
                    <% if(session.getAttribute("logged") != null) {%>
                    <td class="soup_col_portion"><input type="hidden" name="portions" class="form-control portions" value="0" min="0" autocomplete="off"/></td>
                    <% if(!session.getAttribute("logged").equals("admin")) {%>
                    <td class="soup_col_subsidized"></td>
                    <% } %>
                    <td class="soup_col_price"></td>
                    <% } %>
                </tr>
                <% for(int i = 0; i < 3; i++) {%>
                <tr class="<%=i%>">
                    <th class="lunch_col_nr"></th>
                    <td class="lunch_col_meal"></td>
                    <% if(session.getAttribute("logged") != null) {%>
                    <td><input type="number" name="portions" class="form-control portions" id="portions" value="0" min="0" autocomplete="off"/></td>
                    <% if(!session.getAttribute("logged").equals("admin")) {%>
                    <td class="lunch_col_subsidized"></td>
                    <% } %>
                    <td class="lunch_col_price"></td>
                    <% } %>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <div class="meals_container" id="dinner">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th scope="col" id="breakfast_subtitle" class="col-md-1">Večera</th>
                    <th scope="col" style="width: 650px;"></th>
                    <% if(session.getAttribute("logged") != null) {%>
                    <th scope="col" class="column_name" style="width: 100px;">Porcia</th>
                    <% if(!session.getAttribute("logged").equals("admin")) {%>
                    <th scope="col" class="column_name">Dotácia €</th>
                    <% } %>
                    <th scope="col" class="column_name">Bežná cena €</th>
                    <% } %>
                </tr>
                </thead>
                <tbody class="dinner_body">
                <tr>
                    <th class="dinner_col_nr"></th>
                    <td class="dinner_col_meal"></td>
                    <% if(session.getAttribute("logged") != null) {%>
                    <td><input type="number" name="portions" class="form-control portions" value="0" min="0" autocomplete="off"/></td>
                    <% if(!session.getAttribute("logged").equals("admin")) {%>
                    <td class="dinner_col_subsidized"></td>
                    <% } %>
                    <td class="dinner_col_price"></td>
                    <% } %>
                </tr>
                </tbody>
            </table>
        </div>
            <div class="no_menu">Pre tento deň nebolo nájdené žiadne menu.</div>

        <% if(session.getAttribute("logged") != null) {%>
        <div class="order_panel">
            <div class="packCheckbox">
                <input type="checkbox" value="true" name="pack" id="packOrder" class="packOrder" autocomplete="off"> Zabaliť objednávku za príplatok (+0.40€)
            </div>
            <div class="order_button"><button class="btn btn-primary saveBtn" id="order_btn" type="submit">Objednať</button></div>
        </div>
        </form>
        <% } %>
    </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - Jedálny lístok';

        let date_from = $('#date_from').val();
        $.ajax({
            type: 'POST',
            url: 'load-menu',
            data: '&date_from=' + date_from,
            success: function(data) {
                loadMenu(data);
            }
        });

        $('#date_from').change(function () {
            showMenu();

            $(".form-control.portions").each(function(index) {
                $( this ).val(0);
            });

            $('#packOrder').prop('checked', false);
        });

        $('#order_btn').attr('disabled', true);
        $('#breakfast').hide();
        $('#lunch').hide();
        $('#dinner').hide();
        $('.order_panel').hide();
        $('.no_menu').hide();
        checkTime();
    });

    let dailyMenu;
    function returnData(data) {
        return data;
    }

    function showMenu() {
        let date_from = $('#date_from').val();
        $.ajax({
            type: 'POST',
            url: 'load-menu',
            data: '&date_from=' + date_from,
            success: function (data) {
                loadMenu(data);
            }
        });
    }

    let order_form = $('#order');
    order_form.submit(function () {
        let date_from = $('#date_from').val();

        $.ajax({
            cache: false,
            type: order_form.attr('method'),
            url: order_form.attr('action'),
            data: order_form.serialize() +'&data='+ JSON.stringify({ data: dailyMenu }) + '&date_from=' + date_from,
            success: function (data) {
                window.location = 'menu.jsp';
            }
        });
        return false;
    });

    $(".form-control.portions").change(function () {
        let count = 0;
        $(".form-control.portions").each(function(index) {
            count += $( this ).val();
        });

        if(count === "0000000") {
            $('#order_btn').attr('disabled', true);
        } else {
            $('#order_btn').attr('disabled', false);
        }

        checkTime();
    });

    function checkTime() {
        let today = new Date();
        let date_from = $('#date_from').val();
        let cTime = String(today.getHours()).padStart(2, '0') + ":" + String(today.getMinutes()).padStart(2, '0') + ":" + String(today.getSeconds()).padStart(2, '0');
        let cDate = today.getFullYear() + '-' + String((today.getMonth() + 1)).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');

        if(cTime >= "06:45:00" && cDate === date_from) {
            $('#order_btn').attr('disabled', true);
        }
    }

    function loadMenu(data) {
        let role = '<%=request.getSession().getAttribute("logged")%>';
        let employee = '<%=request.getSession().getAttribute("logged_employee")%>';
        let lunchMeals = [];

        dailyMenu = returnData(data);

        if(data.length === 0) {
            console.log("There's no menu for this day!");
            $('#breakfast').hide();
            $('#lunch').hide();
            $('#dinner').hide();
            $('.order_panel').hide();
            $('.no_menu').show();
        } else {
            $('#breakfast').show();
            $('#lunch').show();
            $('#dinner').show();
            $('.order_panel').show();
            $('.no_menu').hide();

            data.forEach(item => {
                if(item.category === 3) {
                    lunchMeals.push(item);
                }
            });

            data.forEach(item => {
                if(item.category === 1) {
                    $('.breakfast_col_nr').html("0");
                    $('.breakfast_col_meal').html(item.meal + "&nbsp &nbsp[ " + item.allergens + " ]");

                    $('.breakfast_col_price').html((item.price).toFixed(2) + "€");

                    if(role === "pensioner") {
                        $('.breakfast_col_subsidized').html((item.subsidizedPricePensioner).toFixed(2) + "€");
                    }

                    if(employee === "príslušník policajného zboru") {
                        $('.breakfast_col_subsidized').html((item.subsidizedPricePoliceman).toFixed(2) + "€");
                    } else if (employee === "civilný zamestnanec") {
                        $('.breakfast_col_subsidized').html((item.subsidizedPriceCE) .toFixed(2) + "€");
                    }
                }

                if(item.category === 2) {
                    $('.soup_col_nr').html("0");
                    $('.soup_col_meal').html(item.meal + "&nbsp &nbsp[ " + item.allergens + " ]");

                    $('.soup_col_price').html("0.00€");
                    $('.soup_col_subsidized').html("0.00€");
                }

                let index = 0;
                let nr = 1;
                lunchMeals.forEach(item => {
                    $('.' + index + ' > .lunch_col_nr').html(nr);
                    $('.' + index + ' > .lunch_col_meal').html(item.meal + "&nbsp &nbsp[ " + item.allergens + " ]");

                    $('.' + index + ' > .lunch_col_price').html((item.price).toFixed(2) + "€");

                    if(role === "pensioner") {
                        $('.' + index + ' > .lunch_col_subsidized').html((item.subsidizedPricePensioner).toFixed(2) + "€");
                    }

                    if(employee === "príslušník policajného zboru") {
                        $('.' + index + ' > .lunch_col_subsidized').html((item.subsidizedPricePoliceman).toFixed(2) + "€");
                    } else if (employee === "civilný zamestnanec") {
                        $('.' + index + ' > .lunch_col_subsidized').html((item.subsidizedPriceCE).toFixed(2) + "€");
                    }

                    index+=1;
                    nr+=1;
                });

                if(item.category === 4) {
                    $('.dinner_col_nr').html("0");
                    $('.dinner_col_meal').html(item.meal + "&nbsp &nbsp[ " + item.allergens + " ]");

                    $('.dinner_col_price').html((item.price).toFixed(2) + "€");

                    if(role === "pensioner") {
                        $('.dinner_col_subsidized').html((item.subsidizedPricePensioner).toFixed(2) + "€");
                    }

                    if(employee === "príslušník policajného zboru") {
                        $('.dinner_col_subsidized').html((item.subsidizedPricePoliceman).toFixed(2) + "€");
                    } else if (employee === "civilný zamestnanec") {
                        $('.dinner_col_subsidized').html((item.subsidizedPriceCE).toFixed(2) + "€");
                    }
                }
            });
        }
    }
</script>
