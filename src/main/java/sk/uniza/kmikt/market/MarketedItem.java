package sk.uniza.kmikt.market;

public class MarketedItem {
    private int itemId;
    private int orderItemId;

    public MarketedItem(int itemId, int orderItemId) {
        this.itemId = itemId;
        this.orderItemId = orderItemId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }
}
