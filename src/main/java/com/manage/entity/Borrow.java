package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Borrow {
    private Long id;                 // 借阅记录ID
    private Long documentId;         // 档案ID
    private Long userId;             // 借阅人ID
    private LocalDateTime borrowTime; // 借阅时间
    private LocalDateTime returnTime; // 归还时间
    private LocalDateTime dueTime;    // 应还时间
    private Integer status;          // 状态（0申请中 1已借出 2已归还 3逾期）
    private Long approveId;          // 审批记录ID
    private String remark;           // 备注
    
    // 扩展字段
    private String documentTitle;     // 文档标题
    private String documentCode;      // 文档编码
    private String userName;          // 借阅人姓名
    private String approveStatus;     // 审批状态
    private String statusText;        // 状态文本
    
    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 0: return "申请中";
            case 1: return "已借出";
            case 2: return "已归还";
            case 3: return "逾期";
            default: return "未知";
        }
    }
}