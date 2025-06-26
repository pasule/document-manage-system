package com.manage.mapper;

import com.manage.entity.User;

import java.util.List;

public interface UserMapper {
    User findByUsername(String username);
    int insert(User user);
    User findById(Long id);
    List<User> findAll();
}