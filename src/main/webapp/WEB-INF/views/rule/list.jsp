<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/functions" %>
<html>
<head>
    <title>编号规则管理</title>
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
    <h2>编号规则管理</h2>

    <a href="${pageContext.request.contextPath}/rule/add" class="add-button">添加新规则</a>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>规则名称</th>
                <th>规则编码</th>
                <th>表达式</th>
                <th>示例</th>
                <th>状态</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="rule" items="${rules}">
                <tr>
                    <td>${rule.id}</td>
                    <td>${rule.name}</td>
                    <td>${rule.code}</td>
                    <td>${rule.pattern}</td>
                    <td>${rule.example}</td>
                    <td>${rule.statusText}</td>
                    <td>${f:formatLocalDateTime(rule.createTime, 'yyyy-MM-dd HH:mm:ss')}</td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/rule/edit/${rule.id}">编辑</a>
                        <a href="${pageContext.request.contextPath}/rule/delete/${rule.id}" onclick="return confirm('确定要删除吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html> 