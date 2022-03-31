package sk.uniza.kmikt.meals;

import java.util.ArrayList;
import java.util.List;

public class Meal {
    private int id;
    private int category;
    private String meal;
    private double subsidizedPriceCE;
    private double subsidizedPricePoliceman;
    private double subsidizedPricePensioner;
    private double price;
    private List<Integer> allergens;

    public Meal(int id, int category, String meal, double price) {
        this.id = id;
        this.category = category;
        this.meal = meal;
        this.price = price;
    }

    public Meal(int category, String meal, double price) {
        this.category = category;
        this.meal = meal;
        this.price = price;
    }

    public Meal(String meal, double subsidizedPriceCE, double subsidizedPricePoliceman, double subsidizedPricePensioner) {
        this.meal = meal;
        this.subsidizedPriceCE = subsidizedPriceCE;
        this.subsidizedPricePoliceman = subsidizedPricePoliceman;
        this.subsidizedPricePensioner = subsidizedPricePensioner;
    }

    public Meal(int id, int category, String meal, double subsidizedPriceCE, double subsidizedPricePoliceman, double subsidizedPricePensioner, double price) {
        this.id = id;
        this.category = category;
        this.meal = meal;
        this.subsidizedPriceCE = subsidizedPriceCE;
        this.subsidizedPricePoliceman = subsidizedPricePoliceman;
        this.subsidizedPricePensioner = subsidizedPricePensioner;
        this.price = price;
    }

    public Meal() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public String getMeal() {
        return meal;
    }

    public void setMeal(String meal) {
        this.meal = meal;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getSubsidizedPriceCE() {
        return subsidizedPriceCE;
    }

    public void setSubsidizedPriceCE(double subsidizedPriceCE) {
        this.subsidizedPriceCE = subsidizedPriceCE;
    }

    public double getSubsidizedPricePoliceman() {
        return subsidizedPricePoliceman;
    }

    public void setSubsidizedPricePoliceman(double subsidizedPricePoliceman) {
        this.subsidizedPricePoliceman = subsidizedPricePoliceman;
    }

    public double getSubsidizedPricePensioner() {
        return subsidizedPricePensioner;
    }

    public void setSubsidizedPricePensioner(double subsidizedPricePensioner) {
        this.subsidizedPricePensioner = subsidizedPricePensioner;
    }

    public List<Integer> getAllergens() {
        return allergens;
    }

    public void setAllergens(List<Integer> allergens) {
        this.allergens = allergens;
    }
}
