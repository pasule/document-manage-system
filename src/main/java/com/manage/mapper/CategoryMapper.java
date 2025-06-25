package com.manage.mapper;

import com.manage.entity.Category;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CategoryMapper {

    List<Category> findAll();

    Category findById(Long id);

    void insert(Category category);

    void update(Category category);

    void delete(Long id);

    Category findByName(String name);

    Category findByCode(String code);
    
    /**
     * 将分类同步添加到 archive_category 表
     */
    void insertArchiveCategory(Category category);
    
    /**
     * 同步更新 archive_category 表中的数据
     */
    void updateArchiveCategory(Category category);
} 