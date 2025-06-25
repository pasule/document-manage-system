package com.manage.model;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class User {
    private Long id;
    private String username;
    private String password;
    private String realName;
    private Integer status; // 1启用 0停用
    private LocalDateTime createTime;
    private Integer role; // 1普通用户 2管理员
} 