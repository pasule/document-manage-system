package com.manage.service.impl;

import com.manage.entity.SecretLevel;
import com.manage.mapper.SecretLevelMapper;
import com.manage.service.SecretLevelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SecretLevelServiceImpl implements SecretLevelService {
    @Autowired
    private SecretLevelMapper secretLevelMapper;

    @Override
    public List<SecretLevel> getAllSecretLevels() {
        return secretLevelMapper.selectAll();
    }
} 