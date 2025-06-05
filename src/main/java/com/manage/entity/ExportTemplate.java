package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ExportTemplate {
    private Long id;                 // 模板ID
    private String name;             // 模板名称
    private String type;             // 模板类型（如档案清单、借阅统计等）
    private String filePath;         // 模板文件存储路径
    private String fileType;         // 模板文件类型
    private String description;      // 模板描述
    private Integer status;          // 状态（1启用 0停用）
    private Long createUser;         // 创建人ID
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间
    
    // 展示用扩展字段
    private String createUserName;    // 创建人姓名
    private String statusText;        // 状态文本
    private String typeText;          // 类型文本
    
    public String getStatusText() {
        if (status == null) return "";
        return status == 1 ? "启用" : "停用";
    }
    
    public String getTypeText() {
        if (type == null) return "";
        switch (type) {
            case "document_list": return "档案清单";
            case "borrow_stats": return "借阅统计";
            case "secret_level": return "密级报表";
            default: return type;
        }
    }
}