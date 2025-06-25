package com.manage.service;

import com.manage.entity.Approve;
import java.util.List;
import java.util.Map;

public interface ApproveService {
    /**
     * 添加审批记录
     */
    Long addApprove(Approve approve);
    
    /**
     * 更新审批记录
     */
    void updateApprove(Approve approve);
    
    /**
     * 根据ID获取审批记录
     */
    Approve getApproveById(Long id);
    
    /**
     * 获取审批详情
     */
    Map<String, Object> getApproveDetail(Long id);
    
    /**
     * 根据档案ID获取审批记录
     */
    List<Map<String, Object>> getApprovesByDocumentId(Long documentId);
    
    /**
     * 获取审批列表
     */
    List<Map<String, Object>> getApproveList(Map<String, Object> params, int offset, int limit);
    
    /**
     * 统计审批记录数
     */
    int countApproves(Map<String, Object> params);
    
    /**
     * 获取所有审批记录
     */
    List<Approve> getAllApproves();
} 