package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class LifecycleSetting {
    private Long id;                  // 生命周期ID
    private String name;               // 生命周期名称
    private String code;               // 生命周期编码
    private String description;        // 生命周期描述
    private Integer retentionYears;    // 保管年限
    private Integer warningDays;       // 到期预警天数
    private Integer status;            // 状态
    private Long createUser;           // 创建人ID
    private LocalDateTime createTime;  // 创建时间
    private LocalDateTime updateTime;  // 更新时间
}