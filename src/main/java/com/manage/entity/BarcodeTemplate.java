package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class BarcodeTemplate {
    private Long id;                 // 条码模板ID
    private String name;             // 模板名称
    private String code;             // 模板编码
    private String format;           // 条码格式（如CODE128、QR等）
    private Integer width;           // 条码宽度（像素）
    private Integer height;          // 条码高度（像素）
    private Integer dpi;             // 分辨率DPI
    private String contentRule;      // 条码内容生成规则
    private String previewUrl;       // 模板预览图片路径
    private String description;      // 模板描述
    private Integer status;          // 状态（1启用 0停用）
    private Long createUser;         // 创建人ID
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间
    
    // 扩展字段
    private String createUserName;    // 创建人姓名
    private String statusText;        // 状态文本
    private String formatText;        // 格式文本
    
    public String getStatusText() {
        if (status == null) return "";
        return status == 1 ? "启用" : "停用";
    }
    
    public String getFormatText() {
        if (format == null) return "";
        switch (format) {
            case "CODE128": return "CODE 128";
            case "QR": return "二维码";
            case "CODE39": return "CODE 39";
            case "EAN13": return "EAN-13";
            default: return format;
        }
    }
}