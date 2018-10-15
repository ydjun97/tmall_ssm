package tmall.service;

import tmall.pojo.ProductImage;

import java.util.List;

public interface ProductImageService {

    String type_single = "type_single";
    String type_detail = "type_detail";

    public List<ProductImage> list(int pid, String type);

    public void add(ProductImage productImage);

    public void delete(int id);

    public ProductImage get(int id);

    public void update(ProductImage productImage);
}
