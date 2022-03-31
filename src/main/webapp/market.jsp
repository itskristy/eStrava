<%@include file="index.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container">
    <jsp:include page="sidebar.jsp" />
        <div class="market_container col-sm-9">
            <div class="market_title">Burza</div>
            <div class="menu_date"></div>
            <form method="post" action="insert-marketed-order" name="marketedOrder" id="marketedOrder" role="form">
                <div class="market_card">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col" class="column_name col-md-1"></th>
                            <th scope="col" class="column_name" style="width: 650px;"></th>
                            <% if(session.getAttribute("logged") != null) {
                                if(!session.getAttribute("logged").equals("admin")) { %>
                            <th scope="col" class="column_name" style="width: 100px;">Dotácia €</th>
                            <% } %>
                            <th scope="col" class="column_name" style="width: 120px;">Bežná cena €</th>
                            <th scope="col" class="column_name" style="width: 100px;"></th>
                            <% } %>
                        </tr>
                        </thead>
                        <tbody class="market_body">
                        </tbody>
                    </table>
                </div>
                <% if(session.getAttribute("logged") != null) {%>
                <div class="market_order_panel">
                    <div class="packCheckbox">
                        <input type="checkbox" value="true" name="pack" id="packOrder" class="packOrder" autocomplete="off"> Zabaliť objednávku za príplatok (+0.40€)
                    </div>
                    <div class="order_button"><button class="btn btn-primary saveBtn" id="market_order_btn" type="submit">Objednať</button></div>
                </div>
            </form>
            <% } %>
        </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - Burza';

        $('.market_card').hide();
        $('.market_order_panel').hide();

        let date_from = $('#date_from').val();
        $.ajax({
            type: 'POST',
            url: 'load-market',
            data: '&date_from=' + date_from,
            success: function(data) {
                loadMarket(data);
            }
        });

        $('#date_from').change(function () {
            showMarket();
            $('#packOrder').prop('checked', false);
        });

        if($('input[name=meal]:checked').length === 0) {
            $('#market_order_btn').attr('disabled', true);
        }
    });

    function showMarket() {
        let date_from = $('#date_from').val();
        $.ajax({
            type: 'POST',
            url: 'load-market',
            data: '&date_from=' + date_from,
            success: function(data) {
                loadMarket(data);
            }
        });
    }

    function checkTime() {
        let today = new Date();
        let date_from = $('#date_from').val();
        let cTime = String(today.getHours()).padStart(2, '0') + ":" + String(today.getMinutes()).padStart(2, '0') + ":" + String(today.getSeconds()).padStart(2, '0');
        let cDate = today.getFullYear() + '-' + String((today.getMonth() + 1)).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');

        if(cTime >= "18:00:00" && cDate === date_from) {
            $('#market_order_btn').attr('disabled', true);
        }
    }

    function loadMarket(data) {
        let size = Object.keys(data[0]).length;
        let role = '<%=request.getSession().getAttribute("logged")%>';
        let employee = '<%=request.getSession().getAttribute("logged_employee")%>';

        $('.market_body').children("tr").remove();

        if(size === 0) {
            console.log("There're no marketed items for this day!");
            $('.market_card').hide();
            $('.market_order_panel').hide();
        } else {
            $('.market_card').show();
            $('.market_order_panel').show();

            for(let i = 0; i < size; i++) {
                $('.market_body').append($('<tr class="' + i + '"></tr>'));
                $('.' + i).append($('<th class="col_nr"></th>'));
                $('.' + i).append($('<td class="col_meal"></td>'));
                $('.' + i).append($('<% if(session.getAttribute("logged") != null) { if(!session.getAttribute("logged").equals("admin")) {%> <td class="col_subsidized_price"></td>  <%} }%>'));
                $('.' + i).append($('<% if(session.getAttribute("logged") != null) {%> <td class="col_price"></td> <%}%>'));
                $('.' + i).append($('<% if(session.getAttribute("logged") != null) {%> <td class="col_order"></td> <%}%>'));
            }

            data[0].forEach((item, index) => {
               $('.' + index + ' > .col_nr').html(index);
               $('.' + index + ' > .col_order').html('<div><input type="checkbox" value="'+ item.itemId + '" name="meal" class="marketed_meal"></div>');
            });

            data[1].forEach((item, index) => {
                $('.' + index + ' > .col_meal').html(item.meal + "&nbsp &nbsp[ " + item.allergens + " ]");

                $('.' + index + ' > .col_price').html((item.price).toFixed(2) + "€");

                if(role === "pensioner") {
                    $('.' + index + ' > .col_subsidized_price').html((item.subsidizedPricePensioner).toFixed(2) + "€")
                }

                if(employee === "príslušník policajného zboru") {
                    $('.' + index + ' > .col_subsidized_price').html((item.subsidizedPricePoliceman).toFixed(2) + "€")
                } else if (employee === "civilný zamestnanec") {
                    $('.' + index + ' > .col_subsidized_price').html((item.subsidizedPriceCE).toFixed(2) + "€")
                }
            });
        }
    }

    $(document).on("change", "input[name='meal']", function () {
        if($('input[name=meal]:checked').length > 0) {
            $('#market_order_btn').attr('disabled', false);
        } else {
            $('#market_order_btn').attr('disabled', true);
        }
        checkTime();
     });


    let order_form = $('#marketedOrder');
    order_form.submit(function () {
        let date_from = $('#date_from').val();

        $.ajax({
            cache: false,
            type: order_form.attr('method'),
            url: order_form.attr('action'),
            data: order_form.serialize() + '&date_from=' + date_from,
            success: function (data) {
                window.location = 'market.jsp';
            }
        });
        return false;
    });
</script>
