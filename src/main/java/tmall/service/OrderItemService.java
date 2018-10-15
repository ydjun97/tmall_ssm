package tmall.service;

import tmall.pojo.Order;
import tmall.pojo.OrderItem;

import java.util.List;

public interface OrderItemService {

    public List<OrderItem> list();

    public void add(OrderItem orderItem);

    public void delete(int id);

    public OrderItem get(int id);

    public void update(OrderItem orderItem);

    public void fill(Order order);

    public void fill(List<Order> orders);

    public int getSaleCount(int pid);

    public List<OrderItem> listByUser(int uid);
}
