package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SecrecyLevel {
    private Long id;                  // 密级ID
    private String name;               // 密级名称
    private String code;               // 密级编码
    private String description;       // 密级描述
    private Integer levelOrder;        // 密级排序
    private Integer status;            // 状态
    private Long createUser;           // 创建人ID
    private LocalDateTime createTime;  // 创建时间
    private LocalDateTime updateTime;  // 更新时间
}