package tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import tmall.pojo.Category;
import tmall.service.CategoryService;
import tmall.util.ImageUtil;
import tmall.util.Page;
import tmall.util.UploadImageFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("admin")
    public String admin() {
        return "redirect:admin_category_list";
    }

    @RequestMapping("admin_category_list")
    public String list(Model model, Page page) {
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Category> cs = categoryService.list();
        int total = (int) new PageInfo<>(cs).getTotal();
        page.setTotal(total);

        model.addAttribute("cs", cs);
        model.addAttribute("page", page);
        return "admin/listCategory";
    }

    @RequestMapping("admin_category_add")
    public String add(Category category, HttpSession session, UploadImageFile image) throws IOException {
        categoryService.add(category);
        System.out.println(category.getId() + ":" + category.getName());

        File fileFolder = new File(session.getServletContext().getRealPath("img/category"));
        File file = new File(fileFolder, category.getId() + ".jpg");
        if(!file.getParentFile().exists())
            file.getParentFile().mkdirs();
        System.out.println(file.getAbsolutePath());

        image.getImage().transferTo(file);
        BufferedImage bufferedImage = ImageUtil.change2jpg(file);
        ImageIO.write(bufferedImage, "jpg", file);

        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_delete")
    public String delete(int id) {
        categoryService.delete(id);

        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_edit")
    public String edit(int id, Model model) {
        Category category = categoryService.get(id);
        model.addAttribute("c", category);

        return "admin/editCategory";
    }

    @RequestMapping("admin_category_update")
    public String update(Category category, HttpSession session, UploadImageFile uploadImageFile) throws IOException {
        categoryService.update(category);

        MultipartFile image = uploadImageFile.getImage();
        if(image != null && !image.isEmpty()){
            File fileFolder = new File(session.getServletContext().getRealPath("img/category"));
            File file = new File(fileFolder, category.getId() + ".jpg");
            System.out.println(file.getAbsolutePath());

            image.transferTo(file);
            BufferedImage bufferedImage = ImageUtil.change2jpg(file);
            ImageIO.write(bufferedImage, "jpg", file);
        }

        return "redirect:/admin_category_list";
    }
}
