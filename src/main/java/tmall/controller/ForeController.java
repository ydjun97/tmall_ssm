package tmall.controller;

import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;
import tmall.comparator.*;
import tmall.pojo.*;
import tmall.service.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ForeController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;
    @Autowired
    private ProductImageService productImageService;
    @Autowired
    private PropertyValueService propertyValueService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private OrderItemService orderItemService;
    @Autowired
    private OrderService orderService;

    @RequestMapping("forehome")
    public String home(Model model) {
        List<Category> categories = categoryService.list();
        productService.fill(categories);
        productService.fillByRow(categories);
        model.addAttribute("cs", categories);

        return "fore/home";
    }

    @RequestMapping("foreregister")
    public String register(Model model, User user) {
        String name = user.getName();
        name = HtmlUtils.htmlEscape(name);
        user.setName(name);

        if(userService.isExists(name)){
            String msg = "用户名已经被使用，不能使用";
            model.addAttribute("msg", msg);
            model.addAttribute("user", null);
            return "fore/register";
        }

        userService.add(user);
        return "redirect:/registerSuccess";
    }

    @RequestMapping("forelogin")
    public String login(Model model, @RequestParam("name") String name, HttpSession session,
                        @RequestParam("password") String password){
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name, password);
        if(null == user) {
            model.addAttribute("msg", "账号密码错误");
            return "fore/login";
        }

        session.setAttribute("user", user);
        return "redirect:forehome";
    }

    @RequestMapping("forelogout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:forehome";
    }

    @RequestMapping("foreproduct")
    public String product(Model model, int pid) {
        Product product = productService.get(pid);
        List<ProductImage> productSingleImages = productImageService.list(pid, ProductImageService.type_single);
        List<ProductImage> productDetailImages = productImageService.list(pid, ProductImageService.type_detail);
        product.setProductSingleImages(productSingleImages);
        product.setProductDetailImages(productDetailImages);
        productService.setSaleAndReviewNumber(product);

        List<PropertyValue> propertyValues = propertyValueService.list(pid);
        List<Review> reviews = reviewService.list(pid);

        model.addAttribute("p", product);
        model.addAttribute("pvs", propertyValues);
        model.addAttribute("rs", reviews);

        return "fore/product";
    }

    @RequestMapping("forechecklogin")
    @ResponseBody
    public String checklogin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if(null == user)
            return "fail";
        return "success";
    }

    @RequestMapping("foreloginAjax")
    @ResponseBody
    public String loginAjax(HttpSession session, @RequestParam("name") String name,
                            @RequestParam("password") String password){
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name, password);
        if(null == user)
            return "fail";

        session.setAttribute("user", user);
        return "success";
    }

    @RequestMapping("forecategory")
    public String category(Model model, @RequestParam("cid") int cid,
                           String sort) {
        Category category = categoryService.get(cid);
        productService.fill(category);
        productService.setSaleAndReviewNumber(category.getProducts());

        if(null != sort) {
            switch(sort) {
                case "all":
                   Collections.sort(category.getProducts(), new ProductAllComparator());
                   break;
                case "date":
                    Collections.sort(category.getProducts(), new ProductDateComparator());
                    break;
                case "price":
                    Collections.sort(category.getProducts(), new ProductPriceComparator());
                    break;
                case "review":
                    Collections.sort(category.getProducts(), new ProductReviewComparator());
                    break;
                case "saleCount":
                    Collections.sort(category.getProducts(), new ProductSaleCountComparator());
                    break;
            }
        }

        model.addAttribute("c", category);
        return "fore/category";
    }

    @RequestMapping("foresearch")
    public String search(Model model, String keyword) {
        PageHelper.offsetPage(0, 20);
        List<Product> products = productService.search(keyword);
        model.addAttribute("ps", products);

        return "fore/searchResult";
    }

    @RequestMapping("forebuyone")
    public String buyone(int pid, int num, HttpSession session) {
        Product product = productService.get(pid);
        User user = (User) session.getAttribute("user");
        int oiid = 0;
        boolean found = false;

        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        for (OrderItem orderItem : orderItems) {
            if (orderItem.getPid().intValue() == product.getId().intValue()) {
                orderItem.setNumber(orderItem.getNumber() + num);
                orderItemService.update(orderItem);
                oiid = orderItem.getId();
                found = true;
                break;
            }
        }
        if(!found){
            OrderItem orderItem = new OrderItem();
            orderItem.setPid(pid);
            orderItem.setUid(user.getId());
            orderItem.setNumber(num);
            orderItemService.add(orderItem);
            oiid = orderItem.getId();
        }
        return "redirect:forebuy?oiid=" + oiid;
    }

    @RequestMapping("forebuy")
    public String buy(Model model, String[] oiid, HttpSession session) {
        List<OrderItem> orderItems = new ArrayList<>();
        int total = 0;
        for(String strid : oiid) {
            int id = Integer.parseInt(strid);
            OrderItem orderItem = orderItemService.get(id);
            total += orderItem.getNumber() * orderItem.getProduct().getPromotePrice();
            orderItems.add(orderItem);
        }
        model.addAttribute("total", total);
        session.setAttribute("ois", orderItems);

        return "fore/buy";
    }

    @RequestMapping("foreaddCart")
    @ResponseBody
    public String addCart(int pid, int num, Model model, HttpSession session) {
        Product product = productService.get(pid);
        User user = (User) session.getAttribute("user");
        boolean found = false;

        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        for(OrderItem orderItem : orderItems) {
            if(orderItem.getPid().intValue() == product.getId().intValue()) {
                orderItem.setNumber(orderItem.getNumber() + num);
                orderItemService.update(orderItem);
                found = true;
                break;
            }
        }
        if(!found) {
            OrderItem orderItem = new OrderItem();
            orderItem.setNumber(num);
            orderItem.setPid(product.getId());
            orderItem.setUid(user.getId());
            orderItemService.add(orderItem);
        }

        return "success";
    }

    @RequestMapping("forecart")
    public String cart(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        model.addAttribute("ois", orderItems);

        return "fore/cart";
    }

    @RequestMapping("foredeleteOrderItem")
    @ResponseBody
    public String deleteOrderItem(HttpSession session, int oiid) {
        User user = (User) session.getAttribute("user");
        if(null == user)
            return "fail";
        orderItemService.delete(oiid);
        return "success";
    }

    @RequestMapping("foreChangeOrderItem")
    @ResponseBody
    public String changeOrderItem(HttpSession session, int pid, int number) {
        User user = (User) session.getAttribute("user");
        if(null == user)
            return "fail";
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        for(OrderItem orderItem : orderItems){
            if(orderItem.getPid().intValue() == pid){
                orderItem.setNumber(number);
                orderItemService.update(orderItem);
                break;
            }
        }
        return "success";
    }

    @RequestMapping("forecreateOrder")
    public String createOrder(HttpSession session, Order order) {
        List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("ois");
        User user = (User) session.getAttribute("user");

        String orderCode = new SimpleDateFormat("yyyyMMddhhmmssSSS").format(new Date()) + user.getId();
        order.setOrderCode(orderCode);
        order.setCreateDate(new Date());
        order.setUid(user.getId());
        order.setStatus(OrderService.waitPay);

        float total = orderService.add(order, orderItems);
//        session.setAttribute("total", total);

        return "redirect:forealipay?oid=" + order.getId() + "&total=" + total;
    }

    @RequestMapping("forepayed")
    public String payed(Model model, int oid) {
        Order order = orderService.get(oid);
        order.setPayDate(new Date());
        order.setStatus(OrderService.waitDelivery);
        orderService.update(order);
        model.addAttribute("o", order);
        return "fore/payed";
    }

    @RequestMapping("forebought")
    public String bought(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<Order> orders = orderService.list(user.getId(), OrderService.delete);
        orderItemService.fill(orders);
        model.addAttribute("os", orders);
        return "fore/bought";
    }

    @RequestMapping("foredeleteOrder")
    @ResponseBody
    public String deleteOrder(HttpSession session, int oid) {
        User user = (User) session.getAttribute("user");
        if(null == user)
            return "fail";
        Order order = orderService.get(oid);
        order.setStatus(OrderService.delete);
        orderService.update(order);
        return "success";
    }

    @RequestMapping("foreconfirmPay")
    public String confirmPay(Model model, int oid){
        Order order = orderService.get(oid);
        orderItemService.fill(order);
        model.addAttribute("o", order);
        return "fore/confirmPay";
    }

    @RequestMapping("foreorderConfirmed")
    public String orderConfirmed(int oid) {
        Order order = orderService.get(oid);
        order.setStatus(OrderService.waitReview);
        order.setConfirmDate(new Date());
        orderService.update(order);
        return "fore/orderConfirmed";
    }

    @RequestMapping("forereview")
    public String review(Model model, int oid){
        Order order = orderService.get(oid);
        orderItemService.fill(order);
        Product product = order.getOrderItems().get(0).getProduct();
        productService.setSaleAndReviewNumber(product);
        List<Review> reviews = reviewService.list(product.getId());
        for(Review review : reviews) {
            User user = userService.get(review.getUid());
            review.setUser(user);
        }

        model.addAttribute("o", order);
        model.addAttribute("p", product);
        model.addAttribute("reviews", reviews);
        return "fore/review";
    }

    @RequestMapping("foredoreview")
    public String doReview(Model model, @RequestParam("oid") int oid,
                           @RequestParam("pid") int pid, HttpSession session, String content) {
        Order order = orderService.get(oid);
        order.setStatus(OrderService.finish);
        orderService.update(order);

        User user = (User) session.getAttribute("user");
        Product product = productService.get(pid);
        content = HtmlUtils.htmlEscape(content);

        Review review = new Review();
        review.setContent(content);
        review.setPid(product.getId());
        review.setUid(user.getId());
        review.setCreateDate(new Date());
        reviewService.add(review);

        return "redirect:forereview?oid="+oid+"&showonly=true";
    }
}
