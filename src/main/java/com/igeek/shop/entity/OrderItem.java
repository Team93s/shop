package com.igeek.shop.entity;

/**
 * @version 1.0
 * @Description 订单明细
 * @Author chenmin
 * @Date 2021/6/9 10:00
 */
public class OrderItem {
    //明细编号
    private String itemId;
    //购买数量
    private int count;
    //小计
    private double subTotal;

    //商品信息  一条订单明细只能有一个商品
    private Product product;

    //订单信息  一条订单明细只能从属于一个订单
    private Orders orders;


    public OrderItem() {
    }

    public OrderItem(String itemId, int count, double subTotal, Product product, Orders orders) {
        this.itemId = itemId;
        this.count = count;
        this.subTotal = subTotal;
        this.product = product;
        this.orders = orders;
    }

    /**
     * 获取
     * @return itemId
     */
    public String getItemId() {
        return itemId;
    }

    /**
     * 设置
     * @param itemId
     */
    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    /**
     * 获取
     * @return count
     */
    public int getCount() {
        return count;
    }

    /**
     * 设置
     * @param count
     */
    public void setCount(int count) {
        this.count = count;
    }

    /**
     * 获取
     * @return subTotal
     */
    public double getSubTotal() {
        return subTotal;
    }

    /**
     * 设置
     * @param subTotal
     */
    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    /**
     * 获取
     * @return product
     */
    public Product getProduct() {
        return product;
    }

    /**
     * 设置
     * @param product
     */
    public void setProduct(Product product) {
        this.product = product;
    }

    /**
     * 获取
     * @return orders
     */
    public Orders getOrders() {
        return orders;
    }

    /**
     * 设置
     * @param orders
     */
    public void setOrders(Orders orders) {
        this.orders = orders;
    }

    public String toString() {
        return "OrderItem{itemId = " + itemId + ", count = " + count + ", subTotal = " + subTotal + ", product = " + product + ", orders = " + orders + "}";
    }
}
