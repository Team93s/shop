package com.igeek.shop.dao;

import com.igeek.common.utils.DataSourceUtils;
import com.igeek.shop.entity.OrderItem;
import com.igeek.shop.entity.Orders;

import java.sql.SQLException;
import java.util.List;

/**
 * @version 1.0
 * @Description 订单及订单明细的数据交互层
 * @Author chenmin
 * @Date 2021/6/9 11:43
 */
public class OrdersDao extends BasicDao<Orders> {

    //插入订单Orders信息
    public int insertOrders(Orders orders) throws SQLException {
        String sql = "insert into orders values(?,?,?,?,?,?,?,?)";
        int i = this.updateInfo(DataSourceUtils.getConnection(),sql,
                orders.getOid() , orders.getOrdertime(),
                orders.getTotal() , orders.getState(),
                orders.getAddress() , orders.getName() , orders.getTelephone(),
                orders.getUser().getUid());
        return i;
    }

    //插入订单明细OrderItem信息
    public void insertOrderItem(Orders orders) throws SQLException {
        String sql = "insert into orderitem values(UUID_SHORT(),?,?,?,?)";
        List<OrderItem> list = orders.getList();
        for (OrderItem orderItem : list) {
            this.updateInfo(DataSourceUtils.getConnection(),sql,
                    orderItem.getCount() , orderItem.getSubTotal(),
                    orderItem.getProduct().getPid(),
                    orderItem.getOrders().getOid());
        }
    }

}
