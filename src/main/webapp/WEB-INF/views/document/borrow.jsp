<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>档案借阅申请</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .borrow-card { width: 480px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 8px; color: #1976d2; font-weight: bold; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #e0e0e0; border-radius: 4px; box-sizing: border-box; }
        .form-control:focus { border-color: #1976d2; outline: none; }
        textarea.form-control { min-height: 100px; }
        .btn-submit { width: 100%; background: #1976d2; color: white; border: none; padding: 12px; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn-submit:hover { background: #1565c0; }
        .error-message { color: #d32f2f; margin-top: 20px; text-align: center; }
        .back-link { display: block; text-align: center; margin-top: 24px; color: #1976d2; text-decoration: underline; }
        .back-link:hover { color: #1565c0; }
    </style>
</head>
<body>
<div class="borrow-card">
    <h2>档案借阅申请</h2>
    
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/document/borrow" method="post">
        <input type="hidden" name="documentId" value="${document.id}">
        
        <div class="form-group">
            <label>档案编号:</label>
            <input type="text" class="form-control" value="${document.code}" readonly>
        </div>
        
        <div class="form-group">
            <label>档案标题:</label>
            <input type="text" class="form-control" value="${document.title}" readonly>
        </div>
        
        <div class="form-group">
            <label>预计归还日期:</label>
            <input type="date" name="dueDate" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>备注:</label>
            <textarea name="remark" class="form-control"></textarea>
        </div>
        
        <button type="submit" class="btn-submit">提交借阅申请</button>
    </form>
    
    <a href="${pageContext.request.contextPath}/document/view?id=${document.id}" class="back-link">返回档案详情</a>
</div>
</body>
</html> 