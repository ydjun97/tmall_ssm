package tmall.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tmall.mapper.OrderMapper;
import tmall.pojo.Order;
import tmall.pojo.OrderExample;
import tmall.pojo.OrderItem;
import tmall.pojo.User;
import tmall.service.OrderItemService;
import tmall.service.OrderService;
import tmall.service.UserService;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private OrderItemService orderItemService;

    public void setUser(Order order) {
        User user = userService.get(order.getUid());
        order.setUser(user);
    }

    public void setUser(List<Order> orders) {
        for(Order order : orders)
            setUser(order);
    }

    @Override
    public List<Order> list() {
        OrderExample example = new OrderExample();
        example.setOrderByClause("id desc");
        List<Order> orders = orderMapper.selectByExample(example);
        setUser(orders);
        return orders;
    }

    @Override
    public List<Order> list(int uid, String excludedStatus) {
        OrderExample example = new OrderExample();
        example.createCriteria().andUidEqualTo(uid).andStatusNotEqualTo(excludedStatus);
        example.setOrderByClause("id desc");
        List<Order> orders = orderMapper.selectByExample(example);
        return orders;
    }

    @Override
    public void add(Order order) {
        orderMapper.insert(order);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackForClassName="Exception")
    public float add(Order order, List<OrderItem> orderItems) {
        int total = 0;
        add(order);

        if(false)
            throw new RuntimeException();

        for(OrderItem orderItem : orderItems){
            orderItem.setOid(order.getId());
            orderItemService.update(orderItem);
            total += orderItem.getProduct().getPromotePrice() * orderItem.getNumber();
        }

        return total;
    }

    @Override
    public void delete(int id) {
        orderMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Order get(int id) {
        Order order = orderMapper.selectByPrimaryKey(id);
//        setUser(order);
        return order;
    }

    @Override
    public void update(Order order) {
        orderMapper.updateByPrimaryKeySelective(order);
    }
}
