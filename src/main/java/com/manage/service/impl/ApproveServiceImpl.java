package com.manage.service.impl;

import com.manage.entity.Approve;
import com.manage.mapper.ApproveMapper;
import com.manage.service.ApproveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service
public class ApproveServiceImpl implements ApproveService {
    
    @Autowired
    private ApproveMapper approveMapper;
    
    @Override
    public Long addApprove(Approve approve) {
        approveMapper.insert(approve);
        return approve.getId();
    }
    
    @Override
    public void updateApprove(Approve approve) {
        approveMapper.update(approve);
    }
    
    @Override
    public Approve getApproveById(Long id) {
        return approveMapper.findById(id);
    }
    
    @Override
    public Map<String, Object> getApproveDetail(Long id) {
        return approveMapper.getApproveDetail(id);
    }
    
    @Override
    public List<Map<String, Object>> getApprovesByDocumentId(Long documentId) {
        return approveMapper.findByDocumentId(documentId);
    }
    
    @Override
    public List<Map<String, Object>> getApproveList(Map<String, Object> params, int offset, int limit) {
        System.out.println("[DEBUG] ApproveService.getApproveList 查询参数: " + params);
        List<Map<String, Object>> result = approveMapper.getApproveList(params, offset, limit);
        System.out.println("[DEBUG] ApproveService.getApproveList 查询结果数量: " + (result != null ? result.size() : 0));
        return result;
    }
    
    @Override
    public int countApproves(Map<String, Object> params) {
        System.out.println("[DEBUG] ApproveService.countApproves 查询参数: " + params);
        int count = approveMapper.countApproves(params);
        System.out.println("[DEBUG] ApproveService.countApproves 查询结果: " + count);
        return count;
    }
    
    @Override
    public List<Approve> getAllApproves() {
        return approveMapper.findAll();
    }
} 