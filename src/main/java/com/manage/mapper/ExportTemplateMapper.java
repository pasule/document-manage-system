package com.manage.mapper;

import com.manage.entity.ExportTemplate;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface ExportTemplateMapper {
    int insert(ExportTemplate template);
    int update(ExportTemplate template);
    int deleteById(Long id);
    ExportTemplate selectById(Long id);
    List<ExportTemplate> selectByType(@Param("type") String type);
    List<ExportTemplate> selectByStatus(@Param("status") Integer status);
    ExportTemplate selectByName(@Param("name") String name);
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);
    int batchUpdateStatus(@Param("ids") List<Long> ids, @Param("status") Integer status);
    List<ExportTemplate> selectByCreateUser(Long createUser);
    List<ExportTemplate> selectByCondition(Map<String, Object> params);
    int countByCondition(Map<String, Object> params);
    int batchInsert(@Param("templates") List<ExportTemplate> templates);
    int batchDelete(@Param("ids") List<Long> ids);
    List<Map<String, Object>> groupByType();
    List<Map<String, Object>> groupByStatus();
    List<ExportTemplate> selectByFileType(@Param("fileType") String fileType);
    int countByFileType(@Param("fileType") String fileType);
    List<ExportTemplate> advancedSearch(Map<String, Object> params);
} 