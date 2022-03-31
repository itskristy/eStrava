<%@ page import="sk.uniza.kmikt.allergens.AllergenController" %>
<%@ page import="sk.uniza.kmikt.allergens.Allergen" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    AllergenController alc = new AllergenController();
    List<Allergen> allergens = alc.selectAllAllergens();
%>

<div class="sidebar col-sm-3">
    <div class="sidebar_subtitle">Výber dňa</div>
    <div class ="sidebar_card">
        <div class="form-group">
            <span><input type="date" class="form-control date" id="date_from" name="date_from" required></span>
        </div>
    </div>
    <div class="sidebar_subtitle">Zoznam alergénov</div>
    <div class ="sidebar_card" id="allergens_table">
        <table class="table table-sm">
            <tbody>
            <% for (Allergen allergen : allergens) {
                int id = allergen.getId();
                String name = allergen.getName();
            %>
            <tr>
                <td id="allergen_id"><%=id%></td>
                <td id="allergen_name"><%=name%></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
