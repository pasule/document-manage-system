<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="/functions" %>
<html>
<head>
    <title>标签管理</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        a { text-decoration: none; color: #007bff; }
        .actions a { margin-right: 10px; }
        .add-button { display: inline-block; margin-bottom: 15px; padding: 10px 15px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
    <h2>标签管理</h2>

    <a href="${pageContext.request.contextPath}/tag/add" class="add-button">添加新标签</a>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>标签名称</th>
                <th>颜色</th>
                <th>状态</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="tag" items="${tags}">
                <tr>
                    <td>${tag.id}</td>
                    <td>${tag.name}</td>
                    <td style="background-color: ${tag.color};">${tag.color}</td>
                    <td>${tag.statusText}</td>
                    <td>${f:formatLocalDateTime(tag.createTime, 'yyyy-MM-dd HH:mm:ss')}</td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/tag/edit/${tag.id}">编辑</a>
                        <a href="${pageContext.request.contextPath}/tag/delete/${tag.id}" onclick="return confirm('确定要删除吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html> 