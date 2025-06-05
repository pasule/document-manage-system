package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Category {
    private Long id;                 // 分类ID
    private String name;             // 分类名称
    private String code;             // 分类编码
    private Long parentId;           // 上级分类ID
    private Integer level;           // 分类层级
    private String path;             // 分类路径
    private String description;      // 分类描述
    private Integer status;          // 状态（1启用 0停用）
    private Long createUser;         // 创建人ID
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间
    
    // 扩展字段
    private String parentName;        // 父分类名称
    private String createUserName;    // 创建人姓名
    private String statusText;        // 状态文本
    
    public String getStatusText() {
        if (status == null) return "";
        return status == 1 ? "启用" : "停用";
    }
}