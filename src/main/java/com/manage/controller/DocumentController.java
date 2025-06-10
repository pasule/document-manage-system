package com.manage.controller;

import com.manage.entity.Document;
import com.manage.entity.User;
import com.manage.service.DocumentService;
import com.manage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class DocumentController {
    @Autowired
    private DocumentService documentService;
    
    @Autowired
    private UserService userService;
    
    // 首页
    @GetMapping("/")
    public String index() {
        return "index";
    }
    
    // 登录页面
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }
    
    // 登录处理
    @PostMapping("/login")
    public String login(@RequestParam String username, 
                       @RequestParam String password, 
                       HttpSession session, 
                       Model model) {
        User user = userService.login(username, password);
        if (user != null) {
            // 登录成功，将用户信息存入session
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("realName", user.getRealName());
            return "redirect:/";
        } else {
            // 登录失败
            model.addAttribute("error", "用户名或密码错误");
            return "login";
        }
    }
    
    // 注册页面
    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }
    
    // 注册处理
    @PostMapping("/register")
    public String register(User user, Model model) {
        boolean success = userService.register(user);
        if (success) {
            return "redirect:/login";
        } else {
            model.addAttribute("error", "注册失败，用户名可能已存在");
            return "register";
        }
    }
    
    // 退出登录
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    
    @GetMapping("/document/list")
    public String list(Model model) {
        List<Document> docs = documentService.getAllDocuments();
        model.addAttribute("docs", docs);
        return "document/list";
    }

    @GetMapping("/document/my")
    public String myDocs(Model model, HttpSession session) {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            // 未登录，跳转到登录页
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        List<Document> docs = documentService.getDocumentsByUser(userId);
        model.addAttribute("docs", docs);
        return "document/my";
    }

    @GetMapping("/document/secret")
    public String secretDocs(Model model, @RequestParam("secretLevelId") Long secretLevelId) {
        List<Document> docs = documentService.getDocumentsBySecretLevel(secretLevelId);
        model.addAttribute("docs", docs);
        return "document/secret";
    }

    @GetMapping("/document/recycle")
    public String recycleBin(Model model) {
        List<Document> docs = documentService.getRecycleBin();
        model.addAttribute("docs", docs);
        return "document/recycle";
    }

    @GetMapping("/document/upload")
    public String uploadPage() {
        return "document/upload";
    }

    @PostMapping("/document/upload")
    public String upload(Document document, HttpSession session) {
        // 自动生成唯一编号
        document.setCode(java.util.UUID.randomUUID().toString().replace("-", ""));
        // 设置创建人和所属人
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj != null) {
            Long userId = (Long) userIdObj;
            document.setCreateUser(userId);
            document.setOwnerId(userId);
        }
        // 设置创建时间
        document.setCreateTime(java.time.LocalDateTime.now());
        // 设置状态为正常
        document.setStatus(1);
        documentService.addDocument(document);
        return "redirect:/document/list";
    }

    @GetMapping("/document/view")
    public String viewDocument(@RequestParam("id") Long id, Model model) {
        Document document = documentService.getDocumentById(id);
        if (document == null) {
            return "redirect:/document/list";
        }
        model.addAttribute("document", document);
        return "document/view";
    }

    @GetMapping("/document/delete")
    public String deleteDocument(@RequestParam("id") Long id) {
        // 将档案状态更改为"回收站"(0)而不是真正删除
        documentService.moveToRecycleBin(id);
        return "redirect:/document/list";
    }
}