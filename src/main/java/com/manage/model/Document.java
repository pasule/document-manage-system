package com.manage.model;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class Document {
    private Long id;
    private String code;
    private String title;
    private Long categoryId;
    private Long secretLevelId;
    private Integer status; // 1正常 0回收站 2作废
    private String fileUrl;
    private Integer pageCount;
    private Long size;
    private Long ownerId;
    private Long createUser;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String description;
    
    // 非数据库字段，用于展示
    private String categoryName;
    private String secretLevelName;
    private String ownerName;
    private String createUserName;
} 