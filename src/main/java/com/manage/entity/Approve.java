package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Approve {
    private Long id;                 // 审批ID
    private String type;             // 审批类型（借阅/入库/出库/作废等）
    private Long refId;              // 关联业务ID
    private Long applicantId;        // 申请人ID
    private Long approverId;         // 审批人ID
    private Integer status;          // 状态（0待审批 1通过 2拒绝）
    private LocalDateTime applyTime;  // 申请时间
    private LocalDateTime approveTime; // 审批时间
    private String remark;           // 备注
    
    // 扩展字段
    private String applicantName;     // 申请人姓名
    private String approverName;      // 审批人姓名
    private String statusText;        // 状态文本
    private String refTitle;          // 关联业务标题
    
    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 0: return "待审批";
            case 1: return "已通过";
            case 2: return "已拒绝";
            default: return "未知";
        }
    }
} 