package tmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class PageController {

    @RequestMapping("register")
    public String register() {
        return "fore/register";
    }
    @RequestMapping("registerSuccess")
    public String registerSuccessPage() {
        return "fore/registerSuccess";
    }
    @RequestMapping("login")
    public String loginPage() {
        return "fore/login";
    }
    @RequestMapping("forealipay")
    public String alipay(){
        return "fore/alipay";
    }
}
