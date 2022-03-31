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
    <div class="my_orders_container col-sm-9">
        <div class="my_orders_title">História objednávok</div>
        <div class="my_orders_header">
            <div class="form-group order">
                <label class="order_label">Od:</label>
                <span><input type="date" class="form-control date" id="orders_from" name="orders_from" required></span>
            </div>
            <div class="form-group order">
                <label class="order_label">Do:</label>
                <span><input type="date" class="form-control date" id="orders_to" name="orders_to" required></span>
            </div>
        </div>
        <div class="my_orders_card">
            <table class="table table-striped" id="orders">
                <thead>
                <tr>
                    <th scope="col" class="column_name col-md-2">Dátum objednávky</th>
                    <th scope="col" style="width: 650px;"></th>
                    <th scope="col" class="column_name" style="width: 100px;">Cena</th>
                    <th scope="col" class="column_name" style="width: 100px;">Balné</th>
                    <th scope="col" class="column_name col-md-2">Dátum stravy</th>
                    <th scope="col" style="width: 100px;"></th>
                    <th scope="col" class="column_name" style="width: 100px;">Burza</th>
                </tr>
                </thead>
                <tbody class="order_body">
                </tbody>
            </table>
        </div>
        <div class="my_orders_footer">
            <div class="total_sum">Spolu:</div>
            <div class="total_sum_val"></div>
        </div>

    </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - História objednávok';

        let date = new Date();
        let firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
        let lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);

        $('#orders_from').val(formatDate(firstDay));
        $('#orders_to').val(formatDate(lastDay));

        let from = $('#orders_from').val();
        let to = $('#orders_to').val();

        $('.order_body').hide();
        $('.my_orders_footer').hide();

        $.ajax({
            type: 'POST',
            url: 'load-orders',
            data: '&orders_from=' + from + '&orders_to=' + to,
            success: function(data) {
                loadOrders(data);
            }
        });
    });

    function formatDate(date) {
        let d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [year, month, day].join('-');
    }

    $("#orders_from").change(function () {
        let selectedFrom = new Date($("#orders_from").val());
        let firstDay = new Date(selectedFrom.getFullYear(), selectedFrom.getMonth(), 1);
        let lastDay = new Date(selectedFrom.getFullYear(), selectedFrom.getMonth() + 1, 0);

        $('#orders_from').val(formatDate(firstDay));
        $('#orders_to').val(formatDate(lastDay));

        let from = $('#orders_from').val();
        let to = $('#orders_to').val();

        $.ajax({
            type: 'POST',
            url: 'load-orders',
            data: '&orders_from=' + from + '&orders_to=' + to,
            success: function(data) {
                loadOrders(data);
            }
        });
    });

    $("#orders_to").change(function () {
        let selectedTo = new Date($("#orders_to").val());
        let firstDay = new Date(selectedTo.getFullYear(), selectedTo.getMonth(), 1);
        let lastDay = new Date(selectedTo.getFullYear(), selectedTo.getMonth() + 1, 0);

        $('#orders_from').val(formatDate(firstDay));
        $('#orders_to').val(formatDate(lastDay));

        let from = $('#orders_from').val();
        let to = $('#orders_to').val();

        $.ajax({
            type: 'POST',
            url: 'load-orders',
            data: '&orders_from=' + from + '&orders_to=' + to,
            success: function(data) {
                loadOrders(data);
            }
        });
    });

    function loadOrders(data) {
        let size = Object.keys(data[1]).length;
        let total = 0;
        $('.order_body').children("tr").remove();

        if(size === 0) {
            $('.order_body').hide();
            $('.my_orders_footer').hide();
        } else {
            $('.order_body').show();
            $('.my_orders_footer').show();

            for(let i = 0; i < size; i++) {
                $('.order_body').append($('<tr class="' + i + '"></tr>'));
                $('.' + i).append($('<th class="col_date"></th>'));
                $('.' + i).append($('<td class="col_meal"></td>'));
                $('.' + i).append($('<td class="col_price"></td>'));
                $('.' + i).append($('<td class="col_fee"></td>'));
                $('.' + i).append($('<td class="col_menu"></td>'));
                $('.' + i).append($('<td class="delete_btn"><a class="btn btn-danger" role="button"><i class="bi bi-trash-fill"></i></a></td>'));
                $('.' + i).append($('<td class="market_btn"><a class="btn btn-primary" role="button"><i class="bi bi-plus-lg"></i></a></td>'));
            }


            data[0].forEach((order) => {
                let date = order.orderDate.replaceAll('-', '.').split(".")

                data[1].forEach((item, index) => {
                    if (order.id === item.orderId) {
                        $('.' + index + ' > .col_date').html(date[2] + ". " + date[1] + ". " + date[0]);
                    }
                });
            });

            data[1].forEach((item, index) => {
                total += item.price;
                $('.' + index + ' > .col_price').html((item.price).toFixed(2) + "€");
                if(item.isPacked === true) {
                    $('.' + index + ' > .col_fee').html("+0.40€");
                    total += 0.4;
                } else {
                    $('.' + index + ' > .col_fee').html("-");
                }

                if(item.isMarketed) {
                    $('.' + index).css("background-color", "steelblue");
                }

                $('.' + index + ' > .delete_btn > .btn').attr("href", "delete-order?itemId=" + item.itemId + "&orderId=" + item.orderId);
                $('.' + index + ' > .market_btn > .btn').attr("href", "transfer-item?itemId=" + item.itemId);
            });

            data[2].forEach((meal, index) => {
                $('.' + index + ' > .col_meal').html(meal.meal);
            });

            let today = new Date();
            let cTime = String(today.getHours()).padStart(2, '0') + ":" + String(today.getMinutes()).padStart(2, '0') + ":" + String(today.getSeconds()).padStart(2, '0');
            let cDate = today.getFullYear() + '-' + String((today.getMonth() + 1)).padStart(2, '0') + '-' + + String(today.getDate()).padStart(2, '0');

            let distMenus = [];
            data[3].forEach((menu) => {
               if(distMenus.length === 0) {
                   distMenus.push(menu);
               } else {
                   distMenus.forEach((item) => {
                       if(item.menuId !== menu.menuId) {
                           distMenus.push(menu);
                       }
                   })
               }
            });

            distMenus.forEach((menu) => {
                let tempOrders = [];
                data[0].forEach((order) => {
                    if(menu.menuId === order.menuId) {
                        tempOrders.push(order);
                    }
                });

                tempOrders.forEach((order) => {
                    data[1].forEach((item, index) => {
                        if(order.id === item.orderId) {
                            $('.' + index + ' > .col_menu').html(menu.date);

                            if(cTime >= "06:45:00" && new Date(menu.sqlDate).toISOString().slice(0, 10) <= cDate) {
                                $('.' + index + ' > .delete_btn > .btn').hide();
                            }

                            if((cTime >= "06:45:00" && cTime <= "12:00:00") && new Date(menu.sqlDate).toISOString().slice(0, 10) === cDate && !item.isMarketed) {
                                $('.' + index + ' > .market_btn > .btn').show();
                            } else {
                                $('.' + index + ' > .market_btn > .btn').hide();
                            }
                        }
                    });
                });

            });

            $('#orders').DataTable({
                ordering:  false,
                searching: false,
                info: false,
                lengthChange: false,
                pagingType: "simple",
                pageLength: 6,
                retrieve: true,

                language: {
                    paginate: {
                        "next": '<i class="bi bi-chevron-right"></i>',
                        "previous": '<i class="bi bi-chevron-left"></i>'
                    },
                    zeroRecords: "Nenašli sa žiadne zodpovedajúce záznamy."
                }
            });

            console.log(total.toFixed(2));
            $('.total_sum_val').html(total.toFixed(2) + "€");
        }
    }
</script>
