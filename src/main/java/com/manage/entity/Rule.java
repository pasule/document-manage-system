package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Rule {
    private Long id;
    private String name;
    private String code;
    private String pattern;
    private String example;
    private String description;
    private Integer status;
    private Long createUser;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    // 扩展字段
    private String createUserName;
    private String statusText;

    public String getStatusText() {
        if (status == null) return "";
        return status == 1 ? "启用" : "停用";
    }
} 