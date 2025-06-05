package com.manage.service.impl;

import com.manage.entity.HotRanking;
import com.manage.mapper.HotRankingMapper;
import com.manage.service.HotRankingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HotRankingServiceImpl implements HotRankingService {
    @Autowired
    private HotRankingMapper hotRankingMapper;

    @Override
    public List<HotRanking> getTop() {
        return hotRankingMapper.selectTop();
    }
} 