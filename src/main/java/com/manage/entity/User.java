package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class User {
    private Long id;                 // 用户ID
    private String username;         // 用户名
    private String password;         // 密码
    private String realName;         // 真实姓名
    private Integer status;          // 状态（1启用 0停用）
    private LocalDateTime createTime; // 创建时间
}