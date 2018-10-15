package tmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tmall.pojo.Product;
import tmall.pojo.PropertyValue;
import tmall.service.ProductService;
import tmall.service.PropertyValueService;

import java.util.List;

@Controller
@RequestMapping("")
public class PropertyValueController {

    @Autowired
    private PropertyValueService propertyValueService;

    @Autowired
    private ProductService productService;

    @RequestMapping("admin_product_editPropertyValue")
    public String edit(int pid, Model model) {
        Product p = productService.get(pid);
        propertyValueService.init(p);
        List<PropertyValue> pvs = propertyValueService.list(pid);

        model.addAttribute("p", p);
        model.addAttribute("pvs", pvs);

        return "admin/editPropertyValue";
    }

    @RequestMapping("admin_propertyValue_update")
    @ResponseBody
    public String update(PropertyValue propertyValue) {
        propertyValueService.update(propertyValue);
        return "success";
    }

}
