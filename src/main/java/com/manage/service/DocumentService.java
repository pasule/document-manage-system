package com.manage.service;

import com.manage.entity.Document;
import java.util.List;

public interface DocumentService {
    List<Document> getAllDocuments();
    List<Document> getDocumentsByUser(Long userId);
    List<Document> getDocumentsBySecretLevel(Long secretLevelId);
    List<Document> getRecycleBin();
    void addDocument(Document document);
    int countAll();
    int countExpired();
    List<Document> getExpiredDocuments();
    Document getDocumentById(Long id);
    void moveToRecycleBin(Long id);
} 