package com.manage.controller;

import com.manage.entity.Category;
import com.manage.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Map<String, Object>> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "category/list";
    }

    @GetMapping("/add")
    public String addPage(Model model) {
        model.addAttribute("category", new Category());
        // find all categories for parent category selection
        model.addAttribute("categories", categoryService.getAllCategories());
        return "category/add";
    }

    @PostMapping("/add")
    public String add(Category category, Model model) {
        try {
            categoryService.addCategory(category);
            return "redirect:/category/list";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("category", category);
            model.addAttribute("categories", categoryService.getAllCategories());
            return "category/add";
        }
    }

    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {
        Map<String, Object> categoryMap = categoryService.getCategoryById(id);
        
        // 将 Map 转换为 Category 对象以便表单绑定
        Category category = new Category();
        if (categoryMap != null) {
            category.setId((Long) categoryMap.get("id"));
            category.setName((String) categoryMap.get("name"));
            category.setCode((String) categoryMap.get("code"));
            category.setParentId((Long) categoryMap.get("parentId"));
            category.setLevel((Integer) categoryMap.get("level"));
            category.setPath((String) categoryMap.get("path"));
            category.setDescription((String) categoryMap.get("description"));
            category.setStatus((Integer) categoryMap.get("status"));
        }
        
        model.addAttribute("category", category);
        model.addAttribute("categories", categoryService.getAllCategories());
        return "category/edit";
    }

    @PostMapping("/edit")
    public String edit(Category category) {
        categoryService.updateCategory(category);
        return "redirect:/category/list";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        categoryService.deleteCategory(id);
        return "redirect:/category/list";
    }
} 