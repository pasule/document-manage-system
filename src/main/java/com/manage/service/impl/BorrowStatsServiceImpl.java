package com.manage.service.impl;

import com.manage.entity.BorrowStats;
import com.manage.mapper.BorrowStatsMapper;
import com.manage.service.BorrowStatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BorrowStatsServiceImpl implements BorrowStatsService {
    @Autowired
    private BorrowStatsMapper borrowStatsMapper;

    @Override
    public List<BorrowStats> getAll() {
        return borrowStatsMapper.selectAll();
    }
} 