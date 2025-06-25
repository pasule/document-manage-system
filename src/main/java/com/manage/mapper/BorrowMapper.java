package com.manage.mapper;

import com.manage.entity.Borrow;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

public interface BorrowMapper {
    /**
     * 插入借阅记录
     */
    int insert(Borrow borrow);
    
    /**
     * 更新借阅记录
     */
    int update(Borrow borrow);
    
    /**
     * 更新审批ID
     */
    int updateApproveId(@Param("borrowId") Long borrowId, @Param("approveId") Long approveId);
    
    /**
     * 根据ID查找借阅记录
     */
    Borrow findById(Long id);
    
    /**
     * 获取借阅详情（包含关联信息）
     */
    Map<String, Object> getBorrowDetail(Long id);
    
    /**
     * 根据文档ID查找借阅记录
     */
    List<Map<String, Object>> findByDocumentId(Long documentId);
    
    /**
     * 统计用户的活跃借阅记录数
     */
    int countActiveBorrows(@Param("documentId") Long documentId, @Param("userId") Long userId);
    
    /**
     * 获取借阅列表
     */
    List<Map<String, Object>> getBorrowList(@Param("params") Map<String, Object> params, 
                                          @Param("offset") int offset, 
                                          @Param("limit") int limit);
    
    /**
     * 统计借阅记录数
     */
    int countBorrows(@Param("params") Map<String, Object> params);
} 