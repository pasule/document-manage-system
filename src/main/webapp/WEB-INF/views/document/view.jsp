<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head><title>档案详情</title></head>
<body>
<h2>档案详情</h2>
<table border="1">
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
<p>
    <a href="${pageContext.request.contextPath}/document/list">返回列表</a>
</p>
</body>
</html>