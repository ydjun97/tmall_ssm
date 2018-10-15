package tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import tmall.pojo.User;
import tmall.service.UserService;
import tmall.util.Page;

import java.util.List;

@Controller
@RequestMapping("")
public class UserController {

    public UserController() {
        super();
        System.out.println("启动tomcat时所有controller已经实例化");
    }

    @Autowired
    private UserService userService;

    @RequestMapping("admin_user_list")
    public String list(Model model, Page page) {
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<User> us = userService.list();
        int total = (int) new PageInfo<>(us).getTotal();
        page.setTotal(total);

        model.addAttribute("us", us);
        model.addAttribute("page", page);
        return "admin/listUser";
    }
}
