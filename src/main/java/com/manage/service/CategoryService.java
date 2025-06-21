package com.manage.service;

import com.manage.entity.Category;

import java.util.List;

public interface CategoryService {

    List<Category> getAllCategories();

    Category getCategoryById(Long id);

    void addCategory(Category category);

    void updateCategory(Category category);

    void deleteCategory(Long id);
} 