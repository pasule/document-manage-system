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
        return approveMapper.getApproveList(params, offset, limit);
    }
    
    @Override
    public int countApproves(Map<String, Object> params) {
        return approveMapper.countApproves(params);
    }
} 