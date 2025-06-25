<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>审批</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .approve-card { width: 480px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; }
        .info-group { margin-bottom: 18px; }
        .info-group label { display: block; margin-bottom: 8px; color: #1976d2; font-weight: bold; }
        .info-text { padding: 10px; background-color: #f5f5f5; border-radius: 4px; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 8px; color: #1976d2; font-weight: bold; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #e0e0e0; border-radius: 4px; box-sizing: border-box; }
        .form-control:focus { border-color: #1976d2; outline: none; }
        textarea.form-control { min-height: 100px; }
        .btn-group { display: flex; gap: 15px; margin-top: 30px; }
        .btn { flex: 1; padding: 12px; border-radius: 4px; cursor: pointer; font-size: 16px; border: none; text-align: center; }
        .btn-approve { background: #4caf50; color: white; }
        .btn-approve:hover { background: #388e3c; }
        .btn-reject { background: #f44336; color: white; }
        .btn-reject:hover { background: #d32f2f; }
        .error-message { color: #d32f2f; margin-top: 20px; text-align: center; }
        .back-link { display: block; text-align: center; margin-top: 24px; color: #1976d2; text-decoration: underline; }
        .back-link:hover { color: #1565c0; }
    </style>
</head>
<body>
<div class="approve-card">
    <h2>审批</h2>
    
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    
    <div class="info-group">
        <label>审批类型:</label>
        <div class="info-text">
            <c:choose>
                <c:when test="${approve.type == 'borrow'}">借阅审批</c:when>
                <c:when test="${approve.type == 'void'}">作废审批</c:when>
                <c:otherwise>${approve.type}</c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="info-group">
        <label>关联业务:</label>
        <div class="info-text">${approve.refTitle}</div>
    </div>
    
    <div class="info-group">
        <label>申请人:</label>
        <div class="info-text">${approve.applicantName}</div>
    </div>
    
    <div class="info-group">
        <label>申请时间:</label>
        <div class="info-text">${approve.applyTime}</div>
    </div>
    
    <div class="info-group">
        <label>申请内容:</label>
        <div class="info-text">${approve.remark}</div>
    </div>
    
    <form action="${pageContext.request.contextPath}/document/process-approve" method="post">
        <input type="hidden" name="approveId" value="${approve.id}">
        
        <div class="form-group">
            <label>审批意见:</label>
            <textarea name="approveRemark" class="form-control" required></textarea>
        </div>
        
        <div class="btn-group">
            <button type="submit" name="action" value="approve" class="btn btn-approve">批准</button>
            <button type="submit" name="action" value="reject" class="btn btn-reject">拒绝</button>
        </div>
    </form>
    
    <a href="${pageContext.request.contextPath}/document/approve-list" class="back-link">返回审批列表</a>
</div>
</body>
</html> 