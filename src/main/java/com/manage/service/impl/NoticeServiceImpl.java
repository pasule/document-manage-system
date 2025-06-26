package com.manage.service.impl;

import com.manage.entity.Notice;
import com.manage.mapper.NoticeMapper;
import com.manage.service.NoticeService;
import com.manage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Autowired
    private UserService userService;

    @Override
    public List<Notice> getAllNotices() {
        return noticeMapper.findAll();
    }

    @Override
    public Notice getNoticeById(Long id) {
        return noticeMapper.findById(id);
    }

    @Override
    @Transactional
    public void sendNotice(Notice notice) {
        // 验证接收人是否存在
//        if (!userService.userExists(notice.getReceiverId())) {
//            throw new RuntimeException("接收人不存在");
//        }

        // 设置默认值
        notice.setStatus(0); // 默认未读
        notice.setSendTime(LocalDateTime.now());
        notice.setType(notice.getType() != null ? notice.getType() : "system");
        //notice.setSenderId(notice.getType() != null ? notice.getType() : "system");
        notice.setPriority(notice.getPriority() != null ? notice.getPriority() : 1);

        noticeMapper.insert(notice);
    }

    @Override
    @Transactional
    public void markNoticeAsRead(Long id) {
        Notice notice = noticeMapper.findById(id);
        if (notice != null && notice.getStatus() == 0) {
            noticeMapper.updateStatus(id, 1, LocalDateTime.now());
        }
    }

    @Override
    @Transactional
    public void archiveNotice(Long id) {
        Notice notice = noticeMapper.findById(id);
        if (notice != null && notice.getStatus() != 2) {
            noticeMapper.updateStatus(id, 2, LocalDateTime.now());
        }
    }

    @Override
    @Transactional
    public void batchArchiveNotices(List<Long> ids) {
        for (Long id : ids) {
            Notice notice = noticeMapper.findById(id);
            if (notice != null && notice.getStatus() != 2) {
                noticeMapper.updateStatus(id, 2, LocalDateTime.now());
            }
        }
    }

    @Override
    @Transactional
    public void deleteNotice(Long id) {
        noticeMapper.delete(id);
    }

    @Override
    public List<Notice> getNoticeByFilter(String title, Integer status, Integer priority,Long userId) {
        Map<String, Object> map = new HashMap<>();

        if (title != null && title.length() > 0) {
            map.put("title", title);
        }
        if (status != null) {
            map.put("status", status);
        }
        if (priority != null) {
            map.put("priority", priority);
        }
        if (userId != null) {
            map.put("userId", userId);
        }
        return noticeMapper.selectByFilter(map);
    }


//    @Override
//    public List<Notice> getUnreadNoticesByUser(Long userId) {
//        return noticeMapper.findByReceiverIdAndStatus(userId, 0);
//    }

//    @Override
//    public List<Notice> getArchivedNotices() {
//        return noticeMapper.findByStatus(2);
//    }
}