package com.manage.service;

import com.manage.entity.User;

import java.util.List;

public interface UserService {
    /**
     * 根据ID获取用户
     */
    User getUserById(Long id);

    /**
     * 检查用户是否是管理员
     */
    boolean isAdmin(Long userId);

    /**
     * 用户登录
     */
    User login(String username, String password);

    /**
     * 用户注册
     */
    Long register(User user);

    /**
     * 获取所有用户
     */
    List<User> getAllUsers();
}