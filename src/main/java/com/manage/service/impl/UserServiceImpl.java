package com.manage.service.impl;

import com.manage.entity.User;
import com.manage.mapper.UserMapper;
import com.manage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String username, String password) {
        User user = userMapper.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User user) {
        // 检查用户名是否已存在
        User existingUser = userMapper.findByUsername(user.getUsername());
        if (existingUser != null) {
            return false;
        }
        
        // 设置默认状态为启用
        user.setStatus(1);
        
        // 插入新用户
        return userMapper.insert(user) > 0;
    }

    @Override
    public User getUserById(Long id) {
        return userMapper.findById(id);
    }
}