package tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import tmall.pojo.Category;
import tmall.pojo.Property;
import tmall.service.CategoryService;
import tmall.service.PropertyService;
import tmall.util.Page;

import java.util.List;

@Controller
@RequestMapping("")
public class PropertyController {

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("admin_property_list")
    public String list(Model model, int cid, Page page) {
        Category c = categoryService.get(cid);

        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Property> ps = propertyService.list(cid);
        int total = (int) new PageInfo<>(ps).getTotal();
        page.setTotal(total);
        page.setParam("&cid=" + cid);

        model.addAttribute("ps", ps);
        model.addAttribute("c", c);
        return "admin/listProperty";
    }

    @RequestMapping("admin_property_add")
    public String add(Property property) {
        propertyService.add(property);
        return "redirect:/admin_property_list?cid=" + property.getCid();
    }

    @RequestMapping("admin_property_delete")
    public String delete(int id) {
        Property property = propertyService.get(id);
        propertyService.delete(id);
        return "redirect:/admin_property_list?cid=" + property.getCid();
    }

    @RequestMapping("admin_property_edit")
    public String edit(int id, Model model) {
        Property property = propertyService.get(id);
        Category c = categoryService.get(property.getCid());
        property.setCategory(c);

        model.addAttribute("p", property);
        return "admin/editProperty";
    }

    @RequestMapping("admin_property_update")
    public String update(Property property) {
        propertyService.update(property);
        return "redirect:/admin_property_list?cid=" + property.getCid();
    }
}
