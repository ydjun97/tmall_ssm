package tmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import tmall.pojo.Product;
import tmall.pojo.ProductImage;
import tmall.service.ProductImageService;
import tmall.service.ProductService;
import tmall.util.ImageUtil;
import tmall.util.UploadImageFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductImageController {

    @Autowired
    private ProductImageService productImageService;

    @Autowired
    private ProductService productService;

    @RequestMapping("admin_productImage_list")
    public String list(Model model, int pid) {
        Product p = productService.get(pid);
        List<ProductImage> pisSingle = productImageService.list(pid, ProductImageService.type_single);
        List<ProductImage> pisDetail = productImageService.list(pid, ProductImageService.type_detail);

        model.addAttribute("p", p);
        model.addAttribute("pisSingle", pisSingle);
        model.addAttribute("pisDetail", pisDetail);
        return "admin/listProductImage";
    }

    @RequestMapping("admin_productImage_add")
    public String add(ProductImage productImage, HttpSession session, UploadImageFile file) throws IOException {
        productImageService.add(productImage);

        String imageFolder = null;
        String imageFolder_middle = null;
        String imageFolder_small = null;
        if(productImage.getType().equals(ProductImageService.type_single)) {
            imageFolder = session.getServletContext().getRealPath("img/productSingle");
            imageFolder_middle = session.getServletContext().getRealPath("img/productSingle_middle");
            imageFolder_small = session.getServletContext().getRealPath("img/productSingle_small");
        }
        else
            imageFolder = session.getServletContext().getRealPath("img/productDetail");

        File f = new File(imageFolder, productImage.getId() + ".jpg");
        f.getParentFile().mkdirs();

        MultipartFile image = file.getImage();
        image.transferTo(f);
        BufferedImage buffImg = ImageUtil.change2jpg(f);
        ImageIO.write(buffImg, ".jpg", f);
        if(productImage.getType().equals(ProductImageService.type_single)){
            File f_middle = new File(imageFolder_middle, productImage.getId() + ".jpg");
            File f_small = new File(imageFolder_small, productImage.getId() + ".jpg");
            ImageUtil.resizeImage(f, 217, 190, f_middle);
            ImageUtil.resizeImage(f, 56, 56, f_small);
        }

        return "redirect:/admin_productImage_list?pid=" + productImage.getPid();
    }

    @RequestMapping("admin_productImage_delete")
    public String delete(int id, HttpSession session) {
        ProductImage productImage = productImageService.get(id);

        String fileName = productImage.getId() + ".jpg";
        String imageFolder = null;
        String imageFolder_middle = null;
        String imageFolder_small = null;
        if(productImage.getType().equals(ProductImageService.type_single)) {
            imageFolder = session.getServletContext().getRealPath("img/productSingle");
            imageFolder_middle = session.getServletContext().getRealPath("img/productSingle_middle");
            imageFolder_small = session.getServletContext().getRealPath("img/productSingle_small");
            File f = new File(imageFolder, fileName);
            File f_middle = new File(imageFolder_middle, fileName);
            File f_small = new File(imageFolder_small, fileName);
            f.delete();
            f_middle.delete();
            f_small.delete();
        }
        else{
            imageFolder = session.getServletContext().getRealPath("img/productDetail");
            File f = new File(imageFolder, fileName);
            f.delete();
        }

        productImageService.delete(id);

        return "redirect:/admin_productImage_list?pid=" + productImage.getPid();
    }
}
