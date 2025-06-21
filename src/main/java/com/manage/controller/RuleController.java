package com.manage.controller;

import com.manage.entity.Rule;
import com.manage.service.RuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/rule")
public class RuleController {

    @Autowired
    private RuleService ruleService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Rule> rules = ruleService.getAllRules();
        model.addAttribute("rules", rules);
        return "rule/list";
    }

    @GetMapping("/add")
    public String addPage(Model model) {
        model.addAttribute("rule", new Rule());
        return "rule/add";
    }

    @PostMapping("/add")
    public String add(Rule rule) {
        ruleService.addRule(rule);
        return "redirect:/rule/list";
    }

    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {
        Rule rule = ruleService.getRuleById(id);
        model.addAttribute("rule", rule);
        return "rule/edit";
    }

    @PostMapping("/edit")
    public String edit(Rule rule) {
        ruleService.updateRule(rule);
        return "redirect:/rule/list";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        ruleService.deleteRule(id);
        return "redirect:/rule/list";
    }
} 