package com.manage.model;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class Approve {
    private Long id;
    private String type;
    private Long refId;
    private Long applicantId;
    private Long approverId;
    private Integer status; // 0待审批 1通过 2拒绝
    private LocalDateTime applyTime;
    private LocalDateTime approveTime;
    private String remark;
} 