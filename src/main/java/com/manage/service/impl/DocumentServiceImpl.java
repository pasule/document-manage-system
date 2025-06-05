package com.manage.service.impl;

import com.manage.entity.Document;
import com.manage.mapper.DocumentMapper;
import com.manage.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DocumentServiceImpl implements DocumentService {
    @Autowired
    private DocumentMapper documentMapper;

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
    public void addDocument(Document document) {
        documentMapper.insert(document);
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
} 