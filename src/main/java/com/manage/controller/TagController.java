package com.manage.controller;

import com.manage.entity.Tag;
import com.manage.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/tag")
public class TagController {

    @Autowired
    private TagService tagService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Tag> tags = tagService.getAllTags();
        model.addAttribute("tags", tags);
        return "tag/list";
    }

    @GetMapping("/add")
    public String addPage(Model model) {
        model.addAttribute("tag", new Tag());
        return "tag/add";
    }

    @PostMapping("/add")
    public String add(Tag tag, Model model, RedirectAttributes redirectAttributes) {
        if (tagService.isTagNameExists(tag.getName())) {
            model.addAttribute("tag", tag);
            model.addAttribute("error", "标签名称已存在，请使用其他名称");
            return "tag/add";
        }

        tagService.addTag(tag);
        redirectAttributes.addFlashAttribute("success", "标签添加成功");
        return "redirect:/tag/list";
    }

    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {
        Tag tag = tagService.getTagById(id);
        model.addAttribute("tag", tag);
        return "tag/edit";
    }

    @PostMapping("/edit")
    public String edit(Tag tag) {
        tagService.updateTag(tag);
        return "redirect:/tag/list";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        tagService.deleteTag(id);
        return "redirect:/tag/list";
    }
} 