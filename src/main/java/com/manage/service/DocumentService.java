package com.manage.service;

import com.manage.entity.Document;
import java.util.List;
import java.util.Map;

public interface DocumentService {
    /**
     * 添加档案
     */
    Long addDocument(Document document);
    
    /**
     * 更新档案
     */
    void updateDocument(Document document);
    
    /**
     * 根据ID获取档案
     */
    Document getDocumentById(Long id);
    
    /**
     * 获取所有档案
     */
    List<Document> getAllDocuments();
    
    /**
     * 获取用户的档案
     */
    List<Document> getDocumentsByUser(Long userId);
    
    /**
     * 获取特定密级的档案
     */
    List<Document> getDocumentsBySecretLevel(Long secretLevelId);
    
    /**
     * 获取回收站中的档案
     */
    List<Document> getRecycleBin();
    
    /**
     * 将档案移入回收站
     */
    void moveToRecycleBin(Long id);
    
    /**
     * 从回收站恢复档案
     */
    void restoreFromRecycleBin(Long id);
    
    /**
     * 永久删除档案
     */
    void deleteDocument(Long id);
    
    /**
     * 作废档案
     */
    void voidDocument(Long id);
    
    /**
     * 统计所有档案数量
     */
    int countAll();
    
    /**
     * 统计过期档案数量
     */
    int countExpired();
    
    /**
     * 获取过期档案
     */
    List<Document> getExpiredDocuments();
    
    /**
     * 根据条件筛选档案
     * @param title 标题（模糊查询）
     * @param categoryId 分类ID
     * @param secretLevelId 密级ID
     * @param tagId 标签ID
     * @param status 状态
     * @return 符合条件的档案列表
     */
    List<Document> getDocumentsByFilter(String title, Long categoryId, Long secretLevelId, Long tagId, Integer status);
    
    /**
     * 根据状态获取档案
     * @param status 档案状态
     * @return 符合状态的档案列表
     */
    List<Document> getDocumentsByStatus(Integer status);
} 