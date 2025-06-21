package com.manage.service;

import com.manage.entity.Rule;

import java.util.List;

public interface RuleService {

    List<Rule> getAllRules();

    Rule getRuleById(Long id);

    void addRule(Rule rule);

    void updateRule(Rule rule);

    void deleteRule(Long id);
} 