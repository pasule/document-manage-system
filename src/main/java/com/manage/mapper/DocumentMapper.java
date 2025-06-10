package com.manage.mapper;

import com.manage.entity.Document;
import java.util.List;

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
} 