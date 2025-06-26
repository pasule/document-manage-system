<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/functions" %>
<html>
<head>
    <title>分类管理</title>
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
    <h2>分类管理</h2>

    <a href="${pageContext.request.contextPath}/category/add" class="add-button">添加新分类</a>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>分类名称</th>
                <th>分类编码</th>
                <th>父分类ID</th>
                <th>层级</th>
                <th>状态</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                    <td>${category.code}</td>
                    <td>${category.parentId}</td>
                    <td>${category.level}</td>
                    <td>${category.statusText}</td>
                    <td>${f:formatLocalDateTime(category.createTime, 'yyyy-MM-dd HH:mm:ss')}</td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/category/edit/${category.id}">编辑</a>
                        <a href="${pageContext.request.contextPath}/category/delete/${category.id}" onclick="return confirm('确定要删除吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>