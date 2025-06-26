package com.manage.controller;

import com.manage.entity.Notice;
import com.manage.entity.User;
import com.manage.service.NoticeService;
import com.manage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private UserService userService;
    /**
     * 系统通知列表页
     */
    @GetMapping("/list")
    public String list(@RequestParam(value = "title", required = false) String title,
                       @RequestParam(value = "status", required = false) Integer status,
                       @RequestParam(value = "priority", required = false) Integer priority,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       @RequestParam(value = "size", defaultValue = "10") int size,
                       Model model) {
        List<Notice> allNotices = noticeService.getNoticeByFilter(title,status,priority);
        // 分页处理
        int total = allNotices.size();
        int totalPages = (int) Math.ceil((double) total / size);

        // 确保页码在有效范围内
        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;

        // 计算当前页的数据
        int fromIndex = (page - 1) * size;
        int toIndex = Math.min(fromIndex + size, total);

        List<Notice> pagedNotices = (fromIndex < toIndex)
                ? allNotices.subList(fromIndex, toIndex)
                : new ArrayList<>();

        // 设置模型属性
        model.addAttribute("notices", pagedNotices);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("searchTitle", title);
        model.addAttribute("searchStatus", status);
        model.addAttribute("searchPriority", priority);
        //List<Notice> notices = noticeService.getAllNotices();
        //model.addAttribute("notices", notices);
        return "notice/list";
    }

    /**
     * 通知详情页
     */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Notice notice = noticeService.getNoticeById(id);
        model.addAttribute("notice", notice);
        return "notice/detail";
    }

    /**
     * 发送通知页面（系统管理员使用）
     */
    @GetMapping("/send")
    public String sendPage(Model model) {
        model.addAttribute("notice", new Notice());
        List<User> users= userService.getAllUsers();
        model.addAttribute("users",users);
        return "notice/send";
    }

    /**
     * 发送通知提交
     */
    @PostMapping("/send")
    public String send(Notice notice, Model model) {
        try {
            noticeService.sendNotice(notice);
            return "redirect:/notice/list";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("notice", notice);
            return "notice/send";
        }
    }

    /**
     * 标记通知为已读
     */
    @GetMapping("/read/{id}")
    public String markAsRead(@PathVariable Long id) {
        noticeService.markNoticeAsRead(id);
        return "redirect:/notice/list";
    }

    /**
     * 标记通知为归档状态
     */
    @GetMapping("/archive/{id}")
    public String archive(@PathVariable Long id) {
        noticeService.archiveNotice(id);
        return "redirect:/notice/list";
    }

    /**
     * 批量归档通知
     */
    @PostMapping("/batch-archive")
    public String batchArchive(@RequestParam("selectedIds") List<Long> ids) {
        System.out.println(ids);
        noticeService.batchArchiveNotices(ids);
        return "redirect:/notice/list";
    }

    /**
     * 删除通知（谨慎使用）
     */
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        noticeService.deleteNotice(id);
        return "redirect:/notice/list";
    }
}