package com.manage.service.impl;

import com.manage.entity.ExportTemplate;
import com.manage.mapper.ExportTemplateMapper;
import com.manage.service.ExportTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ExportTemplateServiceImpl implements ExportTemplateService {
    @Autowired
    private ExportTemplateMapper exportTemplateMapper;

    @Override
    @Transactional
    public Long createTemplate(ExportTemplate template) {
        template.setCreateTime(LocalDateTime.now());
        template.setUpdateTime(LocalDateTime.now());
        template.setStatus(1);
        exportTemplateMapper.insert(template);
        return template.getId();
    }

    @Override
    @Transactional
    public void updateTemplate(ExportTemplate template) {
        template.setUpdateTime(LocalDateTime.now());
        exportTemplateMapper.update(template);
    }

    @Override
    @Transactional
    public void deleteTemplate(Long templateId) {
        exportTemplateMapper.deleteById(templateId);
    }

    @Override
    public ExportTemplate getTemplateById(Long templateId) {
        return exportTemplateMapper.selectById(templateId);
    }

    @Override
    public List<ExportTemplate> getTemplatesByType(String type) {
        return exportTemplateMapper.selectByType(type);
    }

    @Override
    public List<ExportTemplate> getTemplatesByStatus(String status) {
        Integer statusInt = null;
        try {
            statusInt = Integer.valueOf(status);
        } catch (Exception e) {
            return new ArrayList<>();
        }
        return exportTemplateMapper.selectByStatus(statusInt);
    }

    @Override
    public List<ExportTemplate> searchTemplatesByName(String name) {
        ExportTemplate template = exportTemplateMapper.selectByName(name);
        List<ExportTemplate> result = new ArrayList<>();
        if (template != null) {
            result.add(template);
        }
        return result;
    }

    @Override
    @Transactional
    public void updateTemplateStatus(Long templateId, String status) {
        Integer statusInt = null;
        try {
            statusInt = Integer.valueOf(status);
        } catch (Exception e) {
            return;
        }
        exportTemplateMapper.updateStatus(templateId, statusInt);
    }

    @Override
    @Transactional
    public void batchUpdateStatus(List<Long> templateIds, String status) {
        Integer statusInt = null;
        try {
            statusInt = Integer.valueOf(status);
        } catch (Exception e) {
            return;
        }
        exportTemplateMapper.batchUpdateStatus(templateIds, statusInt);
    }

    @Override
    public List<ExportTemplate> getMyTemplates(Long userId) {
        return exportTemplateMapper.selectByCreateUser(userId);
    }

    @Override
    public List<ExportTemplate> searchTemplates(Map<String, Object> params) {
        return exportTemplateMapper.selectByCondition(params);
    }

    @Override
    public int countTemplates(Map<String, Object> params) {
        return exportTemplateMapper.countByCondition(params);
    }

    @Override
    @Transactional
    public void batchImportTemplates(List<ExportTemplate> templates) {
        LocalDateTime now = LocalDateTime.now();
        for (ExportTemplate template : templates) {
            template.setCreateTime(now);
            template.setUpdateTime(now);
            template.setStatus(1);
        }
        exportTemplateMapper.batchInsert(templates);
    }

    @Override
    @Transactional
    public void batchDeleteTemplates(List<Long> templateIds) {
        exportTemplateMapper.batchDelete(templateIds);
    }

    @Override
    public List<Map<String, Object>> groupTemplatesByType() {
        return exportTemplateMapper.groupByType();
    }

    @Override
    public List<Map<String, Object>> groupTemplatesByStatus() {
        return exportTemplateMapper.groupByStatus();
    }

    @Override
    public List<ExportTemplate> getTemplatesByFileType(String fileType) {
        return exportTemplateMapper.selectByFileType(fileType);
    }

    @Override
    public List<ExportTemplate> advancedSearch(Map<String, Object> params) {
        return exportTemplateMapper.advancedSearch(params);
    }

    @Override
    public Map<String, Object> validateTemplate(Long templateId) {
        Map<String, Object> result = new HashMap<>();
        ExportTemplate template = getTemplateById(templateId);
        if (template != null) {
            boolean isValid = true;
            List<String> errors = new ArrayList<>();
            if (template.getName() == null || template.getName().trim().isEmpty()) {
                isValid = false;
                errors.add("模板名称不能为空");
            }
            if (template.getType() == null || template.getType().trim().isEmpty()) {
                isValid = false;
                errors.add("模板类型不能为空");
            }
            if (template.getFilePath() == null || template.getFilePath().trim().isEmpty()) {
                isValid = false;
                errors.add("模板文件路径不能为空");
            }
            result.put("valid", isValid);
            result.put("errors", errors);
        } else {
            result.put("valid", false);
            result.put("errors", List.of("模板不存在"));
        }
        return result;
    }

    @Override
    @Transactional
    public Long copyTemplate(Long templateId) {
        ExportTemplate sourceTemplate = getTemplateById(templateId);
        if (sourceTemplate != null) {
            ExportTemplate newTemplate = new ExportTemplate();
            newTemplate.setName(sourceTemplate.getName() + "_copy");
            newTemplate.setType(sourceTemplate.getType());
            newTemplate.setFilePath(sourceTemplate.getFilePath());
            newTemplate.setDescription(sourceTemplate.getDescription());
            newTemplate.setFileType(sourceTemplate.getFileType());
            newTemplate.setCreateTime(LocalDateTime.now());
            newTemplate.setUpdateTime(LocalDateTime.now());
            newTemplate.setStatus(1);
            exportTemplateMapper.insert(newTemplate);
            return newTemplate.getId();
        }
        return null;
    }

    @Override
    public Map<String, Object> getTemplatePreview(Long templateId) {
        Map<String, Object> preview = new HashMap<>();
        ExportTemplate template = getTemplateById(templateId);
        if (template != null) {
            preview.put("template", template);
            Map<String, Object> sampleData = new HashMap<>();
            preview.put("sampleData", sampleData);
        }
        return preview;
    }
} 