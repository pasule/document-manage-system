package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.LocalDate;

@Data
public class HotRanking {
    private Long id;                    // 排行ID
    private Long documentId;            // 档案ID
    private Integer accessCount;        // 访问次数
    private Integer uniqueUserCount;    // 独立访问用户数
    private LocalDateTime lastAccessTime; // 最近访问时间
    private LocalDate rankingDate;      // 统计日期
    private LocalDateTime createTime;    // 创建时间
    private LocalDateTime updateTime;    // 更新时间
    
    // 展示用扩展字段
    private String documentTitle;        // 文档标题
    private String documentCode;         // 文档编码
    private String categoryName;         // 分类名称
    private Long categoryId;             // 分类ID
    
    // 统计相关字段
    private Double avgAccessCount;       // 平均访问次数
    private Double accessGrowthRate;     // 访问增长率
    private Integer rankPosition;        // 排名位置
}