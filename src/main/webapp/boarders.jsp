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
        <div class="boarders_container col-sm-9">
            <div class="boarders_title">Zoznam stravníkov</div>
            <div class="boarders_header">
                <div class="form-group credit">
                    <label class="boarders_label">Od:</label>
                    <span><input type="date" class="form-control date" id="credit_from" name="credit_from" required></span>
                </div>
                <div class="form-group credit">
                    <label class="boarders_label">Do:</label>
                    <span><input type="date" class="form-control date" id="credit_to" name="credit_to" required></span>
                </div>
            </div>

            <div class="boarders_card">
                <table class="table table-striped" id="boarders">
                    <thead>
                    <tr>
                        <th scope="col" class="column_name" style="width: 20px;">Stravník</th>
                        <th scope="col" class="column_name col-md-2"></th>
                        <th scope="col" class="column_name" style="width: 250px;">E-mail</th>
                        <th scope="col" class="column_name" style="width: 100px;">Kredit</th>
                    </tr>
                    </thead>
                    <tbody class="boarders_body">
                    </tbody>
                </table>
            </div>
        </div>
</div>

<script>
    $(document).ready(function() {
        document.title = 'eStrava - Zoznam stravníkov';

        let date = new Date();
        let firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
        let lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);

        $('#credit_from').val(formatDate(firstDay));
        $('#credit_to').val(formatDate(lastDay));

        let from = $('#credit_from').val();
        let to = $('#credit_to').val();

        $('.boarders_body').hide();

        $.ajax({
            type: 'POST',
            url: 'load-users',
            data: '&credit_from=' + from + '&credit_to=' + to,
            success: function(data) {
                loadUsers(data);
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

    $("#credit_from").change(function () {
        let selectedFrom = new Date($("#credit_from").val());
        let firstDay = new Date(selectedFrom.getFullYear(), selectedFrom.getMonth(), 1);
        let lastDay = new Date(selectedFrom.getFullYear(), selectedFrom.getMonth() + 1, 0);

        $('#credit_from').val(formatDate(firstDay));
        $('#credit_to').val(formatDate(lastDay));

        let from = $('#credit_from').val();
        let to = $('#credit_to').val();

        $.ajax({
            type: 'POST',
            url: 'load-users',
            data: '&credit_from=' + from + '&credit_to=' + to,
            success: function(data) {
                loadUsers(data);
            }
        });
    });

    $("#credit_to").change(function () {
        let selectedTo = new Date($("#credit_to").val());
        let firstDay = new Date(selectedTo.getFullYear(), selectedTo.getMonth(), 1);
        let lastDay = new Date(selectedTo.getFullYear(), selectedTo.getMonth() + 1, 0);

        $('#credit_from').val(formatDate(firstDay));
        $('#credit_to').val(formatDate(lastDay));

        let from = $('#credit_from').val();
        let to = $('#credit_to').val();

        $.ajax({
            type: 'POST',
            url: 'load-users',
            data: '&credit_from=' + from + '&credit_to=' + to,
            success: function(data) {
                loadUsers(data);
            }
        });
    });

    function loadUsers(data) {
        let size = Object.keys(data[2]).length;
        let users = Object.keys(data[1]).length;
        $('.boarders_body').children("tr").remove();

        if(size === 0) {
            $('.boarders_body').hide();
        } else {
            $('.boarders_body').show();

            for(let i = 0; i < users; i++) {
                $('.boarders_body').append($('<tr class="' + i + '"></tr>'));
                $('.' + i).append($('<th class="col_userID"></th>'));
                $('.' + i).append($('<td class="col_username"></td>'));
                $('.' + i).append($('<td class="col_email"></td>'));
                $('.' + i).append($('<td class="col_credit"></td>'));
            }

            data[0].forEach((user, index) => {
                $('.' + index + ' > .col_userID').html(user.id);
                $('.' + index + ' > .col_username').html(user.username);
                $('.' + index + ' > .col_email').html(user.email);
            });

            data[1].forEach((credit, index) => {
                $('.' + index + ' > .col_credit').html(credit.toFixed(2) + "€");
            });

            $('#boarders').DataTable({
                ordering:  false,
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
                    searchPlaceholder: "Vyhľadaj stravníka...",
                    search: "",
                    zeroRecords: "Nenašli sa žiadne zodpovedajúce záznamy."
                }
            });
        }
    }
</script>
