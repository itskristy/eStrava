package sk.uniza.kmikt.orders;

public class OrderItem {
    private int itemId;
    private int mealId;
    private int orderId;
    private double price;
    private boolean isPacked;
    private boolean isMarketed;

    public OrderItem(int itemId, int mealId, int orderId, double price, boolean isPacked, boolean isMarketed) {
        this.itemId = itemId;
        this.mealId = mealId;
        this.orderId = orderId;
        this.price = price;
        this.isPacked = isPacked;
        this.isMarketed = isMarketed;
    }

    public OrderItem() {

    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getMealId() {
        return mealId;
    }

    public void setMealId(int mealId) {
        this.mealId = mealId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isPacked() {
        return isPacked;
    }

    public void setPacked(boolean packed) {
        isPacked = packed;
    }

    public boolean isMarketed() {
        return isMarketed;
    }

    public void setMarketed(boolean marketed) {
        isMarketed = marketed;
    }
}
