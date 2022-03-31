<%@include file="index.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
    if (session.getAttribute("logged") == null && session.getAttribute("logged").equals("admin")) {
        response.sendRedirect("menu.jsp");
        return;
    }
%>

<div class="container">
    <jsp:include page="sidebar.jsp" />
        <div class="order_list_container col-sm-9">
            <div class="order_list_title">Zoznam objednávok</div>
            <div class="order_list_header">
                <div class="form-group credit">
                    <label class="order_list_label">Deň:</label>
                    <span><input type="date" class="form-control date" id="dateOf" name="dateOf" required></span>
                </div>
            </div>

            <div class="order_list_card">
                <table class="table table-striped" id="list-orders">
                    <thead>
                    <tr>
                        <th scope="col" class="column_name" style="width: 20px;">Stravník</th>
                        <th scope="col" class="column_name col-md-2"></th>
                        <th scope="col" class="column_name" style="width: 250px;">Objednané jedlo</th>
                        <th scope="col" class="column_name" style="width: 100px;">Zabaliť</th>
                    </tr>
                    </thead>
                    <tbody class="order_list_body">
                    </tbody>
                </table>
            </div>
        </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - Zoznam objednávok';

        let date = new Date();
        $('#dateOf').val(formatDate(date));

        let dateOf = $('#dateOf').val();

        $('.order_list_body').hide();

        $.ajax({
            type: 'POST',
            url: 'load-date-orders',
            data: '&dateOf=' + dateOf,
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

    $("#dateOf").change(function () {
        let dateOf = $('#dateOf').val();

        $.ajax({
            type: 'POST',
            url: 'load-date-orders',
            data: '&dateOf=' + dateOf,
            success: function(data) {
                loadOrders(data);
            }
        });
    });

    function loadOrders(data) {
        let size = Object.keys(data[1]).length;
        $('.order_list_body').children("tr").remove();

        if(size === 0) {
            $('.order_list_body').hide();
        } else {
            $('.order_list_body').show();

            for(let i = 0; i < size; i++) {
                $('.order_list_body').append($('<tr class="' + i + '"></tr>'));
                $('.' + i).append($('<th class="col_userID"></th>'));
                $('.' + i).append($('<td class="col_username"></td>'));
                $('.' + i).append($('<td class="col_meal"></td>'));
                $('.' + i).append($('<td class="col_isPacked"></td>'));
            }

            data[1].forEach((item, i) => {
                data[2].forEach((meal, index) => {
                    if(item.mealId === meal.id) {
                        $('.' + index + ' > .col_meal').html(meal.meal);
                    }
                });

                data[0].forEach((order) => {
                    if (order.id === item.orderId){
                        data[3].forEach((user) => {
                            if(user.id === order.userId) {
                                $('.' + i + ' > .col_userID').html(order.userId);
                                $('.' + i + ' > .col_username').html(user.username);
                            }
                        });
                    }
                });

                if(item.isPacked) {
                    $('.' + i + ' > .col_isPacked').html("Áno");
                } else {
                    $('.' + i + ' > .col_isPacked').html("Nie");
                }

            });

            $('#list-orders').DataTable({
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
        }
    }
</script>
