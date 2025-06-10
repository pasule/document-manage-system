package com.manage.mapper;

import com.manage.entity.User;

public interface UserMapper {
    User findByUsername(String username);
    int insert(User user);
    User findById(Long id);
}