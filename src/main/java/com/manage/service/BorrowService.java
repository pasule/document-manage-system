package com.manage.service;

import com.manage.entity.Borrow;
import java.util.List;
import java.util.Map;

public interface BorrowService {
    /**
     * 添加借阅记录
     */
    Long addBorrow(Borrow borrow);
    
    /**
     * 更新借阅记录
     */
    void updateBorrow(Borrow borrow);
    
    /**
     * 更新审批ID
     */
    void updateApproveId(Long borrowId, Long approveId);
    
    /**
     * 根据ID获取借阅记录
     */
    Borrow getBorrowById(Long id);
    
    /**
     * 获取借阅详情
     */
    Map<String, Object> getBorrowDetail(Long id);
    
    /**
     * 根据档案ID获取借阅记录
     */
    List<Map<String, Object>> getBorrowsByDocumentId(Long documentId);
    
    /**
     * 检查是否有未完成的借阅
     */
    boolean hasActiveBorrow(Long documentId, Long userId);
    
    /**
     * 获取借阅列表
     */
    List<Map<String, Object>> getBorrowList(Map<String, Object> params, int offset, int limit);
    
    /**
     * 统计借阅记录数
     */
    int countBorrows(Map<String, Object> params);
} 