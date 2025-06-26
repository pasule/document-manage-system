<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>作废审批</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .approve-card { width: 90%; max-width: 600px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
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
        .btn-secondary { background: #757575; color: white; text-decoration: none; display: inline-block; }
        .btn-secondary:hover { background: #616161; }
        .error-message { color: #d32f2f; margin-top: 20px; text-align: center; }
        .status-badge { display: inline-block; padding: 5px 10px; border-radius: 4px; color: white; font-size: 14px; font-weight: bold; margin-bottom: 20px; }
        .status-pending { background-color: #ff9800; } /* 待审批 */
        .status-summary { text-align: center; margin-bottom: 20px; }
        .nav-links { display: flex; justify-content: center; gap: 15px; margin-top: 24px; }
        .document-preview { border: 1px solid #e0e0e0; padding: 15px; margin-bottom: 20px; border-radius: 4px; }
        .document-preview h3 { color: #1976d2; margin-top: 0; }
    </style>
</head>
<body>
<div class="approve-card">
    <h2>作废审批</h2>
    
    <div class="status-summary">
        <span class="status-badge status-pending">待审批</span>
    </div>
    
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    
    <!-- 档案预览 -->
    <div class="document-preview">
        <h3>档案信息</h3>
        <div class="info-group">
            <label>档案编号:</label>
            <div class="info-text">${approve.documentCode}</div>
        </div>
        
        <div class="info-group">
            <label>档案标题:</label>
            <div class="info-text">${approve.documentTitle}</div>
        </div>
    </div>
    
    <!-- 申请信息 -->
    <div class="info-group">
        <label>申请人:</label>
        <div class="info-text">${approve.applicantName}</div>
    </div>
    
    <div class="info-group">
        <label>申请时间:</label>
        <div class="info-text">${approve.applyTime}</div>
    </div>
    
    <div class="info-group">
        <label>作废原因:</label>
        <div class="info-text">${approve.remark}</div>
    </div>
    
    <form action="${pageContext.request.contextPath}/document/approve-void" method="post">
        <input type="hidden" name="approveId" value="${approve.id}">
        
        <div class="form-group">
            <label>审批意见:</label>
            <textarea name="approveRemark" class="form-control" required placeholder="请输入您的审批意见..."></textarea>
        </div>
        
        <div class="btn-group">
            <button type="submit" name="action" value="approve" class="btn btn-approve">批准作废</button>
            <button type="submit" name="action" value="reject" class="btn btn-reject">拒绝作废</button>
        </div>
    </form>
    
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/document/view-void?id=${approve.id}" class="btn btn-secondary">查看详情</a>
        <a href="${pageContext.request.contextPath}/document/void-approve-list" class="btn btn-secondary">返回列表</a>
    </div>
</div>
</body>
</html> 