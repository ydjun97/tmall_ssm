package tmall.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import tmall.pojo.Category;
import tmall.pojo.OrderItem;
import tmall.pojo.User;
import tmall.service.CategoryService;
import tmall.service.OrderItemService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class OrtherInterceptor implements HandlerInterceptor {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private OrderItemService orderItemService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object o,
                           ModelAndView modelAndView) throws Exception {
        HttpSession session = request.getSession();

        List<Category> categorys = categoryService.list();
        String contextPath = session.getServletContext().getContextPath();
        int cartTotalItemNumber = 0;

        User user = (User) session.getAttribute("user");
        if(null != user){
            List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
            for(OrderItem orderItem : orderItems)
                cartTotalItemNumber += orderItem.getNumber();
        }

        session.setAttribute("cs", categorys);
        session.setAttribute("contextPath", contextPath);
        session.setAttribute("cartTotalItemNumber", cartTotalItemNumber);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object o,
                                 Exception e) throws Exception {

    }
}
