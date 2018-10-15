package tmall.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import tmall.mapper.CategoryMapper;
import tmall.pojo.Category;
import tmall.pojo.CategoryExample;
import tmall.service.CategoryService;
import tmall.util.Page;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    CategoryMapper categoryMapper;

    @Override
//    public List<Category> list(Page page) {
//        return categoryMapper.list(page);
//    }
    public List<Category> list() {
        CategoryExample example = new CategoryExample();
        example.setOrderByClause("id desc");
        return categoryMapper.selectByExample(example);
    }

//    @Override
//    public int total() {
//        return categoryMapper.total();
//    }

    @Override
    public void add(Category category) {
        categoryMapper.insert(category);
    }

    @Override
    public void delete(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Category get(int id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
    }
}
