package com.manage.mapper;

import com.manage.entity.Document;
import java.util.List;
import java.util.Map;

public interface DocumentMapper {
    List<Document> selectAll();
    List<Document> selectByCreateUser(Long createUser);
    List<Document> selectBySecretLevelId(Long secretLevelId);
    List<Document> selectRecycleBin();
    int insert(Document document);
    int countAll();
    int countExpired();
    List<Document> selectExpired();

    Document selectById(Long id);
    void updateByPrimaryKeySelective(Document document);
    int deleteByPrimaryKey(Long id);
    
    /**
     * 根据条件筛选档案
     * @param params 筛选条件
     * @return 符合条件的档案列表
     */
    List<Document> selectByFilter(Map<String, Object> params);

    /**
     * 根据状态查询档案
     */
    List<Document> findByStatus(Integer status);
} 