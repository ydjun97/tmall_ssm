package tmall.interceptor;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import tmall.pojo.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                             Object o) throws Exception {
        String[] pages = {"forehome", "foreregister", "forelogin", "foreproduct", "forechecklogin",
            "foreloginAjax", "forecategory", "foresearch"};

        String uri = httpServletRequest.getRequestURI();
        String context = httpServletRequest.getContextPath();
        uri = StringUtils.remove(uri, context);

        if(uri.startsWith("/fore")){
//            String path = StringUtils.substringAfterLast(uri, "/fore");
            String path = StringUtils.substringAfterLast(uri, "/");
//            System.out.println(path);
            if(!Arrays.asList(pages).contains(path)){
                User user = (User) httpServletRequest.getSession().getAttribute("user");
                if(null == user){
                    httpServletResponse.sendRedirect("login");
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                           Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                                Object o, Exception e) throws Exception {

    }
}
