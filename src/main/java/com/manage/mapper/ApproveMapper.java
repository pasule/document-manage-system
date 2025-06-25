package com.manage.mapper;

import com.manage.entity.Approve;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

public interface ApproveMapper {
    /**
     * 插入审批记录
     */
    int insert(Approve approve);
    
    /**
     * 更新审批记录
     */
    int update(Approve approve);
    
    /**
     * 根据ID查找审批记录
     */
    Approve findById(Long id);
    
    /**
     * 获取审批详情（包含关联信息）
     */
    Map<String, Object> getApproveDetail(Long id);
    
    /**
     * 根据文档ID查找审批记录
     */
    List<Map<String, Object>> findByDocumentId(Long documentId);
    
    /**
     * 获取审批列表
     */
    List<Map<String, Object>> getApproveList(@Param("params") Map<String, Object> params, 
                                           @Param("offset") int offset, 
                                           @Param("limit") int limit);
    
    /**
     * 统计审批记录数
     */
    int countApproves(@Param("params") Map<String, Object> params);
} 