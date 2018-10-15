package tmall.service;

import tmall.pojo.Category;
import tmall.util.Page;

import java.util.List;

public interface CategoryService {

//    public List<Category> list(Page page);
    public List<Category> list();

//    public int total();

    public void add(Category category);

    public void delete(int id);

    public Category get(int id);

    public void update(Category category);
}
