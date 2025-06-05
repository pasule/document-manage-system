package com.manage.controller;

import com.manage.entity.ExportTemplate;
import com.manage.service.ExportTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/report")
public class ReportController {
    @Autowired
    private ExportTemplateService exportTemplateService;

    @GetMapping("/exportList")
    public String exportList(Model model) {
        List<ExportTemplate> templates = exportTemplateService.getTemplatesByType("document_list");
        model.addAttribute("templates", templates);
        return "report/exportList";
    }

    @GetMapping("/borrowStats")
    public String borrowStats(Model model) {
        List<ExportTemplate> templates = exportTemplateService.getTemplatesByType("borrow_stats");
        model.addAttribute("templates", templates);
        return "report/borrowStats";
    }

    @GetMapping("/secretLevel")
    public String secretLevel(Model model) {
        List<ExportTemplate> templates = exportTemplateService.getTemplatesByType("secret_level");
        model.addAttribute("templates", templates);
        return "report/secretLevel";
    }

    @GetMapping("/barcode")
    public String barcode(Model model) {
        // 你可以实现BarcodeTemplateService
        return "report/barcode";
    }
} 