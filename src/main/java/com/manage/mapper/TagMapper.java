package com.manage.mapper;

import com.manage.entity.Tag;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TagMapper {

    List<Tag> findAll();

    Tag findById(Long id);

    void insert(Tag tag);

    void update(Tag tag);

    Tag findByName(String name);

    void delete(Long id);
} 