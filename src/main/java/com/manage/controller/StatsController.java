package com.manage.controller;

import com.manage.service.DocumentService;
import com.manage.service.BorrowStatsService;
import com.manage.service.HotRankingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/stats")
public class StatsController {
    @Autowired
    private DocumentService documentService;
    @Autowired
    private BorrowStatsService borrowStatsService;
    @Autowired
    private HotRankingService hotRankingService;

    @GetMapping("/count")
    public String count(Model model) {
        int total = documentService.countAll();
        int expired = documentService.countExpired();
        model.addAttribute("total", total);
        model.addAttribute("expired", expired);
        return "stats/count";
    }

    @GetMapping("/borrow")
    public String borrowStats(Model model) {
        model.addAttribute("stats", borrowStatsService.getAll());
        return "stats/borrow";
    }

    @GetMapping("/hot")
    public String hotRanking(Model model) {
        model.addAttribute("ranking", hotRankingService.getTop());
        return "stats/hot";
    }

    @GetMapping("/expired")
    public String expiredList(Model model) {
        model.addAttribute("expiredDocs", documentService.getExpiredDocuments());
        return "stats/expired";
    }
} 