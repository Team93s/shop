package com.igeek.shop.service;

import com.igeek.common.utils.DataSourceUtils;
import com.igeek.shop.dao.OrdersDao;
import com.igeek.shop.entity.Orders;

import java.sql.SQLException;

/**
 * @version 1.0
 * @Description TODO
 * @Author chenmin
 * @Date 2021/6/9 11:42
 */
public class OrderService {

    private OrdersDao dao = new OrdersDao();

    //提交订单
    public boolean submitOrders(Orders orders){
        try {
            //开启事务  不再自动提交事务
            DataSourceUtils.startTransaction();

            //保持事务的一致性
            dao.insertOrders(orders);

            //int i = 10/0;

            dao.insertOrderItem(orders);

            return true;
        } catch (Exception e) {
            //事务回滚
            try {
                DataSourceUtils.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            //关闭资源
            //提交事务
            try {
                DataSourceUtils.commitAndRelease();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
