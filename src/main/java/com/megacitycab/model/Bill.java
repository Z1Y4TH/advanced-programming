package com.megacitycab.model;

public class Bill {
    private int bookingId;
    private double totalAmount;
    private double tax;
    private double discount;
    private double finalAmount;

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
        calculateFinalAmount();
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
        calculateFinalAmount();
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
        calculateFinalAmount();
    }

    public double getFinalAmount() {
        return finalAmount;
    }

    private void calculateFinalAmount() {
        this.finalAmount = totalAmount + (totalAmount * (tax / 100.0)) - (totalAmount * (discount / 100.0));
    }
}