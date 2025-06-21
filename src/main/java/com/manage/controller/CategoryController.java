package com.manage.controller;

import com.manage.entity.Category;
import com.manage.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Category> categories = categoryService.getAllCategories();
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
    public String add(Category category) {
        categoryService.addCategory(category);
        return "redirect:/category/list";
    }

    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {
        Category category = categoryService.getCategoryById(id);
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