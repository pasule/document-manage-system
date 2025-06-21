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
} 