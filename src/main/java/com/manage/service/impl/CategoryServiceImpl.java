package com.manage.service.impl;

import com.manage.entity.Category;
import com.manage.mapper.CategoryMapper;
import com.manage.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Map<String, Object>> getAllCategories() {
        List<Category> categories = categoryMapper.findAll();
        List<Map<String, Object>> result = new ArrayList<>();
        
        for (Category category : categories) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", category.getId());
            map.put("name", category.getName());
            map.put("code", category.getCode());
            map.put("parentId", category.getParentId());
            map.put("level", category.getLevel());
            map.put("path", category.getPath());
            map.put("description", category.getDescription());
            map.put("status", category.getStatus());
            result.add(map);
        }
        
        return result;
    }

    @Override
    public Map<String, Object> getCategoryById(Long id) {
        Category category = categoryMapper.findById(id);
        if (category == null) {
            return null;
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("id", category.getId());
        result.put("name", category.getName());
        result.put("code", category.getCode());
        result.put("parentId", category.getParentId());
        result.put("level", category.getLevel());
        result.put("path", category.getPath());
        result.put("description", category.getDescription());
        result.put("status", category.getStatus());
        
        return result;
    }

    @Override
    public void addCategory(Category category) {
        if (categoryMapper.findByName(category.getName()) != null) {
            throw new RuntimeException("分类名称已存在");
        }
        if (categoryMapper.findByCode(category.getCode()) != null) {
            throw new RuntimeException("分类编码已存在");
        }
        
        // 添加到 category 表
        categoryMapper.insert(category);
        
        // 同步添加到 archive_category 表
        categoryMapper.insertArchiveCategory(category);
    }

    @Override
    public void updateCategory(Category category) {
        categoryMapper.update(category);
        
        // 同步更新 archive_category 表中的数据
        categoryMapper.updateArchiveCategory(category);
    }

    @Override
    public void deleteCategory(Long id) {
        // 在删除前可以检查该分类下是否有文档
        // 注意: delete 操作会同时删除 category 和 archive_category 表中的数据
        categoryMapper.delete(id);
    }

    @Override
    public List<Map<String, Object>> getAllSecretLevels() {
        // 模拟密级数据
        List<Map<String, Object>> secretLevels = new ArrayList<>();
        
        Map<String, Object> level1 = new HashMap<>();
        level1.put("id", 1L);
        level1.put("name", "公开");
        level1.put("code", "PUBLIC");
        secretLevels.add(level1);
        
        Map<String, Object> level2 = new HashMap<>();
        level2.put("id", 2L);
        level2.put("name", "内部");
        level2.put("code", "INTERNAL");
        secretLevels.add(level2);
        
        Map<String, Object> level3 = new HashMap<>();
        level3.put("id", 3L);
        level3.put("name", "秘密");
        level3.put("code", "SECRET");
        secretLevels.add(level3);
        
        Map<String, Object> level4 = new HashMap<>();
        level4.put("id", 4L);
        level4.put("name", "机密");
        level4.put("code", "CONFIDENTIAL");
        secretLevels.add(level4);
        
        return secretLevels;
    }

    @Override
    public Map<String, Object> getSecretLevelById(Long id) {
        // 根据ID查找密级
        for (Map<String, Object> level : getAllSecretLevels()) {
            if (level.get("id").equals(id)) {
                return level;
            }
        }
        return null;
    }
} 