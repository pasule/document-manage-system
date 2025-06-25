<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>系统诊断</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .container { width: 90%; max-width: 800px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; }
        .diagnostic-info { background-color: #f5f5f5; padding: 20px; border-radius: 5px; }
        .back-link { display: block; text-align: center; margin-top: 24px; color: #1976d2; text-decoration: underline; }
        .back-link:hover { color: #1565c0; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 10px; text-align: left; border: 1px solid #ddd; }
        th { background-color: #f0f0f0; }
    </style>
</head>
<body>
<div class="container">
    <h2>系统诊断信息</h2>
    
    <div class="diagnostic-info">
        ${diagnosticInfo}
    </div>
    
    <a href="${pageContext.request.contextPath}/" class="back-link">返回首页</a>
    <a href="${pageContext.request.contextPath}/document/approve-list" class="back-link">返回审批列表</a>
</div>
</body>
</html> 