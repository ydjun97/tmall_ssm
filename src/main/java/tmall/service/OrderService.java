package tmall.service;

import tmall.pojo.Order;
import tmall.pojo.OrderItem;

import java.util.List;

public interface OrderService {

    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";

    List<Order> list();

    List<Order> list(int uid, String excludedStatus);

    void add(Order order);

    float add(Order order, List<OrderItem> orderItems);

    void delete(int id);

    Order get(int id);

    void update(Order order);
}
