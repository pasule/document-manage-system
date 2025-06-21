package com.manage.mapper;

import com.manage.entity.Rule;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RuleMapper {

    List<Rule> findAll();

    Rule findById(Long id);

    void insert(Rule rule);

    void update(Rule rule);

    void delete(Long id);
} 