package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Document {
    private Long id;                 // 档案ID
    private String code;             // 档案编号
    private String title;            // 档案标题
    private Long categoryId;         // 分类ID
    private Long secretLevelId;      // 密级ID
    private Integer status;          // 状态（1正常 0回收站 2作废）
    private String fileUrl;          // 文件存储路径
    private Integer pageCount;       // 页数
    private Long size;               // 文件大小（字节）
    private Long ownerId;            // 所属人ID
    private Long createUser;         // 创建人ID
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间
    private String description;      // 档案描述
    
    // 展示用扩展字段
    private String secretLevelName;   // 密级名称
    private String categoryName;      // 分类名称
    private String ownerName;         // 所属人姓名
    private String createUserName;    // 创建人姓名
    private String statusText;        // 状态文本
    
    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "正常";
            case 0: return "回收站";
            case 2: return "作废";
            default: return "未知";
        }
    }
}