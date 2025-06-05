package com.manage.mapper;

import com.manage.entity.HotRanking;
import java.util.List;

public interface HotRankingMapper {
    List<HotRanking> selectTop();
} 