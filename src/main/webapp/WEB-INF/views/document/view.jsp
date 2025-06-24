<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>档案详情</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .view-card { width: 480px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; }
        .detail-table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        .detail-table td { padding: 10px 8px; border-bottom: 1px solid #e0e0e0; }
        .detail-table tr:last-child td { border-bottom: none; }
        .detail-table td:first-child { color: #1976d2; font-weight: bold; width: 100px; }
        .back-link { display: block; text-align: center; margin-top: 24px; color: #1976d2; text-decoration: underline; }
        .back-link:hover { color: #1565c0; }
    </style>
</head>
<body>
<div class="view-card">
    <h2>档案详情</h2>
    <table class="detail-table">
        <tr><td>编号:</td><td>${document.code}</td></tr>
        <tr><td>标题:</td><td>${document.title}</td></tr>
        <tr><td>密级:</td><td>${document.secretLevelName}</td></tr>
        <tr><td>状态:</td><td>
            <c:choose>
                <c:when test="${document.status == 1}">正常</c:when>
                <c:when test="${document.status == 0}">回收站</c:when>
                <c:when test="${document.status == 2}">作废</c:when>
                <c:otherwise>未知</c:otherwise>
            </c:choose>
        </td></tr>
        <tr><td>页数:</td><td>${document.pageCount}</td></tr>
        <tr><td>大小:</td><td>${document.size} 字节</td></tr>
        <tr><td>创建时间:</td><td>${document.createTime}</td></tr>
        <tr><td>描述:</td><td>${document.description}</td></tr>
    </table>
    <a href="${pageContext.request.contextPath}/document/list" class="back-link">返回列表</a>
</div>
</body>
</html>