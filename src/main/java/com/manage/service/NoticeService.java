package com.manage.service;

import com.manage.entity.Notice;

import java.util.List;

public interface NoticeService {
    // 获取所有通知
    List<Notice> getAllNotices();

    // 获取单个通知详情
    Notice getNoticeById(Long id);

    // 发送新通知
    void sendNotice(Notice notice);

    // 标记已读
    void markNoticeAsRead(Long id);

    // 归档通知
    void archiveNotice(Long id);

    // 批量归档
    void batchArchiveNotices(List<Long> ids);

    // 删除通知
    void deleteNotice(Long id);


    List<Notice> getNoticeByFilter(String title, Integer status, Integer priority,Long userId);
}