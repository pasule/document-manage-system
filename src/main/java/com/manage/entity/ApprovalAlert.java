package com.manage.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ApprovalAlert {
    private Long id;                 // 审批提醒ID
    private Long approvalId;          // 关联审批ID
    private Long receiverId;          // 接收人ID
    private String alertType;         // 提醒类型
    private String content;           // 提醒内容
    private Integer status;           // 状态
    private LocalDateTime sendTime;   // 发送时间
    private LocalDateTime readTime;   // 阅读时间
    private LocalDateTime handleTime; // 处理时间
    private String remark;            // 备注
}