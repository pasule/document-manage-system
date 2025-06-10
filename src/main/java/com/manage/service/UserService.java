package com.manage.service;

import com.manage.entity.User;

public interface UserService {
    User login(String username, String password);
    boolean register(User user);
    User getUserById(Long id);
}