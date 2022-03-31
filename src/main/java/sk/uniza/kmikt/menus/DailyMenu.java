package sk.uniza.kmikt.menus;

import java.util.ArrayList;
import java.util.Date;

public class DailyMenu {
    private int menuId;
    private String date;
    private String sqlDate;
    private ArrayList<Integer> meals;

    public DailyMenu(int menuId, String date, String sqlDate) {
        this.menuId = menuId;
        this.date = date;
        this.sqlDate = sqlDate;
    }

    public DailyMenu(String date) {
        this.date = date;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSqlDate() {
        return sqlDate;
    }

    public void setSqlDate(String sqlDate) {
        this.sqlDate = sqlDate;
    }
}
