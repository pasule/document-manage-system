package com.manage.model;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class Borrow {
    private Long id;
    private Long documentId;
    private Long userId;
    private LocalDateTime borrowTime;
    private LocalDateTime returnTime;
    private LocalDateTime dueTime;
    private Integer status; // 0申请中 1已借出 2已归还 3逾期 4已拒绝
    private Long approveId;
    private String purpose;
    private String remark;
} 