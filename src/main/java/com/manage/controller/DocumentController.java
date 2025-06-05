package com.manage.controller;

import com.manage.entity.Document;
import com.manage.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/document")
public class DocumentController {
    @Autowired
    private DocumentService documentService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Document> docs = documentService.getAllDocuments();
        model.addAttribute("docs", docs);
        return "document/list";
    }

    @GetMapping("/my")
    public String myDocs(Model model, @SessionAttribute("userId") Long userId) {
        List<Document> docs = documentService.getDocumentsByUser(userId);
        model.addAttribute("docs", docs);
        return "document/my";
    }

    @GetMapping("/secret")
    public String secretDocs(Model model, @RequestParam("secretLevelId") Long secretLevelId) {
        List<Document> docs = documentService.getDocumentsBySecretLevel(secretLevelId);
        model.addAttribute("docs", docs);
        return "document/secret";
    }

    @GetMapping("/recycle")
    public String recycleBin(Model model) {
        List<Document> docs = documentService.getRecycleBin();
        model.addAttribute("docs", docs);
        return "document/recycle";
    }

    @GetMapping("/upload")
    public String uploadPage() {
        return "document/upload";
    }

    @PostMapping("/upload")
    public String upload(Document document) {
        documentService.addDocument(document);
        return "redirect:/document/list";
    }
} 