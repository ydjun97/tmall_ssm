package tmall.service;

import tmall.pojo.Category;
import tmall.pojo.Product;

import java.util.List;

public interface ProductService {

    public List<Product> list(int cid);

    public void add(Product product);

    public void delete(int id);

    public Product get(int id);

    public void update(Product product);

    public void fill(Category categorye);

    public void fill(List<Category> categories);

    public void fillByRow(List<Category> categories);

    public void setSaleAndReviewNumber(Product product);

    public void setSaleAndReviewNumber(List<Product> products);

    public List<Product> search(String keyword);
}
