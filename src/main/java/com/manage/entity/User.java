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
    private Integer role;            // 1普通用户 2管理员
    
    // 显式添加 getter 方法
    public Long getId() { return id; }
    public String getUsername() { return username; }
    public String getRealName() { return realName; }
    public Integer getRole() { return role; }
    public String getPassword() { return password; }
    public Integer getStatus() { return status; }
    
    // 显式添加 setter 方法
    public void setId(Long id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setPassword(String password) { this.password = password; }
    public void setRealName(String realName) { this.realName = realName; }
    public void setStatus(Integer status) { this.status = status; }
    public void setRole(Integer role) { this.role = role; }
}