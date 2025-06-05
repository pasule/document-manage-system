package com.manage.service;

import com.manage.entity.ExportTemplate;
import java.util.List;
import java.util.Map;

public interface ExportTemplateService {
    Long createTemplate(ExportTemplate template);
    void updateTemplate(ExportTemplate template);
    void deleteTemplate(Long templateId);
    ExportTemplate getTemplateById(Long templateId);
    List<ExportTemplate> getTemplatesByType(String type);
    List<ExportTemplate> getTemplatesByStatus(String status);
    List<ExportTemplate> searchTemplatesByName(String name);
    void updateTemplateStatus(Long templateId, String status);
    void batchUpdateStatus(List<Long> templateIds, String status);
    List<ExportTemplate> getMyTemplates(Long userId);
    List<ExportTemplate> searchTemplates(Map<String, Object> params);
    int countTemplates(Map<String, Object> params);
    void batchImportTemplates(List<ExportTemplate> templates);
    void batchDeleteTemplates(List<Long> templateIds);
    List<Map<String, Object>> groupTemplatesByType();
    List<Map<String, Object>> groupTemplatesByStatus();
    List<ExportTemplate> getTemplatesByFileType(String fileType);
    List<ExportTemplate> advancedSearch(Map<String, Object> params);
    Map<String, Object> validateTemplate(Long templateId);
    Long copyTemplate(Long templateId);
    Map<String, Object> getTemplatePreview(Long templateId);
} 