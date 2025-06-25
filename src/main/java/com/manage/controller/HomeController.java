package com.manage.controller;

import com.manage.entity.User;
import com.manage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;


@Controller
public class HomeController {
    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                       @RequestParam String password,
                       @RequestParam(value = "isAdmin", defaultValue = "0") String isAdmin,
                       HttpSession session,
                       Model model) {
        // 管理员登录逻辑
        if ("1".equals(isAdmin)) {
            if ("admin".equals(username) && "123456".equals(password)) {
                // 创建一个管理员用户对象
                User adminUser = new User();
                adminUser.setId(0L); // 使用特殊ID表示管理员
                adminUser.setUsername("admin");
                adminUser.setRealName("系统管理员");
                adminUser.setRole(2); // 2表示管理员角色
                
                // 设置会话属性
                session.setAttribute("userId", adminUser.getId());
                session.setAttribute("username", adminUser.getUsername());
                session.setAttribute("realName", adminUser.getRealName());
                session.setAttribute("isAdmin", true);
                
                return "redirect:/";
            } else {
                model.addAttribute("error", "管理员账号或密码错误");
                return "login";
            }
        }
        
        // 普通用户登录逻辑
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("realName", user.getRealName());
            session.setAttribute("isAdmin", user.getRole() != null && user.getRole() == 2);
            return "redirect:/";
        } else {
            model.addAttribute("error", "用户名或密码错误");
            return "login";
        }
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(User user, Model model) {
        try {
            // 默认注册为普通用户
            user.setRole(1); // 1表示普通用户
            
            Long userId = userService.register(user);
            if (userId != null) {
                return "redirect:/login";
            } else {
                model.addAttribute("error", "注册失败，用户名可能已存在");
                return "register";
            }
        } catch (Exception e) {
            model.addAttribute("error", "注册失败: " + e.getMessage());
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}