package com.manage.service.impl;

import com.manage.entity.Rule;
import com.manage.mapper.RuleMapper;
import com.manage.service.RuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RuleServiceImpl implements RuleService {

    @Autowired
    private RuleMapper ruleMapper;

    @Override
    public List<Rule> getAllRules() {
        return ruleMapper.findAll();
    }

    @Override
    public Rule getRuleById(Long id) {
        return ruleMapper.findById(id);
    }

    @Override
    public void addRule(Rule rule) {
        ruleMapper.insert(rule);
    }

    @Override
    public void updateRule(Rule rule) {
        ruleMapper.update(rule);
    }

    @Override
    public void deleteRule(Long id) {
        ruleMapper.delete(id);
    }
} 