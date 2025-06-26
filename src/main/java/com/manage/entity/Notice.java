package com.manage.entity;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class Notice {
    private Long id;                 // 通知ID
    private String title;            // 通知标题
    private String content;          // 通知内容
    private String type;             // 通知类型（system/approval/borrow/other）
    private Integer priority;        // 优先级（1普通 2重要 3紧急）
    private Integer status;          // 状态（0未读 1已读 2归档）
    private Long senderId;           // 发送人ID
    private Long receiverId;         // 接收人ID
    private LocalDateTime sendTime;  // 发送时间
    private LocalDateTime readTime;  // 阅读时间
    private LocalDateTime archiveTime; // 归档时间
    private String remark;           // 备注

    // 添加适配JSP的方法
    public Date getsendTime() {
        if (this.sendTime == null) {
            return null;
        }
        return Date.from(sendTime.atZone(ZoneId.systemDefault()).toInstant());
    }
    public Date getreadTime() {
        if (this.readTime == null) {
            return null;
        }
        return Date.from(readTime.atZone(ZoneId.systemDefault()).toInstant());
    }

}