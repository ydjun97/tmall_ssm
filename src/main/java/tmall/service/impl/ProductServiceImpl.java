package tmall.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tmall.mapper.ProductMapper;
import tmall.pojo.*;
import tmall.service.*;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductImageService productImageService;

    @Autowired
    private OrderItemService orderItemService;

    @Autowired
    private ReviewService reviewService;

    public void setCategory(Product product) {
        int cid = product.getCid();
        Category category = categoryService.get(cid);
        product.setCategory(category);
    }

    public void setCategory(List<Product> products) {
        for(Product product : products)
            setCategory(product);
    }

    public void setFirstProductImage(Product product) {
        List<ProductImage> pis = productImageService.list(product.getId(), ProductImageService.type_single);
        if(!pis.isEmpty())
            product.setFirstProductImage(pis.get(0));
    }

    public void setFirstProductImage(List<Product> products) {
        for(Product product : products)
            setFirstProductImage(product);
    }

    @Override
    public List<Product> list(int cid) {
        ProductExample example = new ProductExample();
        example.createCriteria().andCidEqualTo(cid);
        example.setOrderByClause("id desc");

        List<Product> products = productMapper.selectByExample(example);
        setCategory(products);
        setFirstProductImage(products);
        return products;
    }

    @Override
    public void add(Product product) {
        productMapper.insert(product);
    }

    @Override
    public void delete(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Product get(int id) {
        Product product = productMapper.selectByPrimaryKey(id);
        setCategory(product);
        setFirstProductImage(product);
        return product;
    }

    @Override
    public void update(Product product) {
        productMapper.updateByPrimaryKey(product);
    }

    @Override
    public void fill(Category categorye) {
        List<Product> products = list(categorye.getId());
        categorye.setProducts(products);
    }

    @Override
    public void fill(List<Category> categories) {
        for(Category category : categories)
            fill(category);
    }

    @Override
    public void fillByRow(List<Category> categories) {
        int numberOfEachRow = 8;
        for(Category category : categories) {
//            List<Product> products = list(category.getId());
            List<Product> products = category.getProducts();
            List<List<Product>> productsByRow = new ArrayList<>();
            for(int i = 0; i < products.size(); i += numberOfEachRow) {
                int size = i + numberOfEachRow;
                size = size > products.size() ? products.size() : size;
                List<Product> ps = products.subList(i, size);
                productsByRow.add(ps);
            }
            category.setProductsByRow(productsByRow);
        }
    }

    @Override
    public void setSaleAndReviewNumber(Product product) {
        int saleCount = orderItemService.getSaleCount(product.getId());
        product.setSaleCount(saleCount);
        int reviewCount = reviewService.getCount(product.getId());
        product.setReviewCount(reviewCount);
    }

    @Override
    public void setSaleAndReviewNumber(List<Product> products) {
        for(Product product : products)
            setSaleAndReviewNumber(product);
    }

    @Override
    public List<Product> search(String keyword) {
        ProductExample example = new ProductExample();
        example.createCriteria().andNameLike("%" + keyword + "%");
        example.setOrderByClause("id desc");
        List<Product> products = productMapper.selectByExample(example);
        setFirstProductImage(products);
        setCategory(products);

        return products;
    }
}
