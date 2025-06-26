package com.manage.service.impl;

import com.manage.entity.Document;
import com.manage.mapper.DocumentMapper;
import com.manage.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

@Service
public class DocumentServiceImpl implements DocumentService {
    @Autowired
    private DocumentMapper documentMapper;

    @Override
    public Long addDocument(Document document) {
        documentMapper.insert(document);
        return document.getId();
    }

    @Override
    public void updateDocument(Document document) {
        documentMapper.updateByPrimaryKeySelective(document);
    }

    @Override
    public Document getDocumentById(Long id) {
        return documentMapper.selectById(id);
    }

    @Override
    public List<Document> getAllDocuments() {
        return documentMapper.selectAll();
    }

    @Override
    public List<Document> getDocumentsByUser(Long userId) {
        return documentMapper.selectByCreateUser(userId);
    }

    @Override
    public List<Document> getDocumentsBySecretLevel(Long secretLevelId) {
        return documentMapper.selectBySecretLevelId(secretLevelId);
    }

    @Override
    public List<Document> getRecycleBin() {
        return documentMapper.selectRecycleBin();
    }

    @Override
    public void moveToRecycleBin(Long id) {
        Document doc = new Document();
        doc.setId(id);
        doc.setStatus(0); // 0表示回收站
        documentMapper.updateByPrimaryKeySelective(doc);
    }

    @Override
    public void restoreFromRecycleBin(Long id) {
        Document doc = new Document();
        doc.setId(id);
        doc.setStatus(1); // 1表示正常
        documentMapper.updateByPrimaryKeySelective(doc);
    }

    @Override
    public void deleteDocument(Long id) {
        documentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void voidDocument(Long id) {
        Document doc = new Document();
        doc.setId(id);
        doc.setStatus(2); // 2表示作废
        documentMapper.updateByPrimaryKeySelective(doc);
    }

    @Override
    public int countAll() {
        return documentMapper.countAll();
    }

    @Override
    public int countExpired() {
        return documentMapper.countExpired();
    }

    @Override
    public List<Document> getExpiredDocuments() {
        return documentMapper.selectExpired();
    }
    
    @Override
    public List<Document> getDocumentsByFilter(String title, Long categoryId, Long secretLevelId, Long tagId, Integer status) {
        Map<String, Object> params = new HashMap<>();
        
        // 添加查询条件，只有当参数不为空时才添加
        if (title != null && !title.trim().isEmpty()) {
            params.put("title", title);
        }
        
        if (categoryId != null) {
            params.put("categoryId", categoryId);
        }
        
        if (secretLevelId != null) {
            params.put("secretLevelId", secretLevelId);
        }
        
        if (tagId != null) {
            params.put("tagId", tagId);
        }
        
        if (status != null) {
            params.put("status", status);
        }
        
        return documentMapper.selectByFilter(params);
    }

    @Override
    public List<Document> getDocumentsByStatus(Integer status) {
        return documentMapper.findByStatus(status);
    }
}