package com.manage.service.impl;

import com.manage.entity.Category;
import com.manage.mapper.CategoryMapper;
import com.manage.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> getAllCategories() {
        return categoryMapper.findAll();
    }

    @Override
    public Category getCategoryById(Long id) {
        return categoryMapper.findById(id);
    }

    @Override
    public void addCategory(Category category) {
        // 在添加前可以进行一些业务检查，例如父节点是否存在等
        categoryMapper.insert(category);
    }

    @Override
    public void updateCategory(Category category) {
        categoryMapper.update(category);
    }

    @Override
    public void deleteCategory(Long id) {
        // 在删除前可以检查该分类下是否有文档
        categoryMapper.delete(id);
    }
} 