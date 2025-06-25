package com.manage.service;

import com.manage.entity.Category;

import java.util.List;
import java.util.Map;

public interface CategoryService {

    List<Map<String, Object>> getAllCategories();

    Map<String, Object> getCategoryById(Long id);

    void addCategory(Category category);

    void updateCategory(Category category);

    void deleteCategory(Long id);
    
    /**
     * 获取所有密级
     */
    List<Map<String, Object>> getAllSecretLevels();
    
    /**
     * 根据ID获取密级
     */
    Map<String, Object> getSecretLevelById(Long id);
} 