package com.manage.service.impl;

import com.manage.entity.Borrow;
import com.manage.mapper.BorrowMapper;
import com.manage.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BorrowServiceImpl implements BorrowService {
    
    @Autowired
    private BorrowMapper borrowMapper;
    
    @Override
    public Long addBorrow(Borrow borrow) {
        borrowMapper.insert(borrow);
        return borrow.getId();
    }
    
    @Override
    public void updateBorrow(Borrow borrow) {
        borrowMapper.update(borrow);
    }
    
    @Override
    public void updateApproveId(Long borrowId, Long approveId) {
        borrowMapper.updateApproveId(borrowId, approveId);
    }
    
    @Override
    public Borrow getBorrowById(Long id) {
        return borrowMapper.findById(id);
    }
    
    @Override
    public Map<String, Object> getBorrowDetail(Long id) {
        return borrowMapper.getBorrowDetail(id);
    }
    
    @Override
    public List<Map<String, Object>> getBorrowsByDocumentId(Long documentId) {
        return borrowMapper.findByDocumentId(documentId);
    }
    
    @Override
    public boolean hasActiveBorrow(Long documentId, Long userId) {
        return borrowMapper.countActiveBorrows(documentId, userId) > 0;
    }
    
    @Override
    public List<Map<String, Object>> getBorrowList(Map<String, Object> params, int offset, int limit) {
        return borrowMapper.getBorrowList(params, offset, limit);
    }
    
    @Override
    public int countBorrows(Map<String, Object> params) {
        return borrowMapper.countBorrows(params);
    }
} 