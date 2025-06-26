package com.manage.mapper;

import com.manage.entity.Notice;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NoticeMapper {

    List<Notice> findAll();

    Notice findById(Long id);

    void insert(Notice notice);

    void update(Notice notice);

    void delete(Long id);

    // 根据接收人ID查询通知
    List<Notice> findByReceiverId(Long receiverId);

    // 根据优先级查询通知
    List<Notice> findByPriority(Integer priority);

    // 根据状态查询通知
    List<Notice> findByStatus(Integer status);

    // 更新通知阅读状态
    void updateStatus(Long id, Integer status, java.time.LocalDateTime readTime);
}