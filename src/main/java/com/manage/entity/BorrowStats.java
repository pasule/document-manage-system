package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.LocalDate;

@Data
public class BorrowStats {
    private Long id;                     // 统计ID
    private Long documentId;             // 档案ID
    private Long userId;                 // 用户ID
    private Integer borrowCount;         // 借阅次数
    private LocalDateTime lastBorrowTime; // 最近借阅时间
    private Integer totalBorrowDays;     // 累计借阅天数
    private LocalDate statsDate;         // 统计日期
    private LocalDateTime createTime;     // 创建时间
    private LocalDateTime updateTime;     // 更新时间
    
    // 展示用扩展字段
    private String documentTitle;         // 文档标题
    private String documentCode;          // 文档编码
    private String userName;              // 用户姓名
    private String categoryName;          // 分类名称
    private Long categoryId;              // 分类ID
    
    // 统计相关字段
    private Double avgBorrowDays;         // 平均借阅天数
    private Double borrowFrequency;       // 借阅频率（次数/月）
    private Integer overdueTimes;         // 逾期次数
    private Integer rankPosition;         // 借阅排名
}