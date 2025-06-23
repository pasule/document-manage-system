<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加编号规则</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .form-container { width: 50%; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .form-actions { margin-top: 20px; }
        .form-actions button { padding: 10px 15px; border: none; border-radius: 5px; background-color: #007bff; color: white; cursor: pointer; }
        .form-actions a { padding: 10px 15px; border-radius: 5px; background-color: #6c757d; color: white; text-decoration: none; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>添加编号规则</h2>
        <c:if test="${not empty error}">
            <div style="color: red; margin-bottom: 15px;">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/rule/add" method="post">
            <div class="form-group">
                <label for="name">规则名称:</label>
                <input type="text" id="name" name="name" value="${rule.name}" required>
            </div>
            <div class="form-group">
                <label for="code">规则编码:</label>
                <input type="text" id="code" name="code" value="${rule.code}" required>
            </div>
            <div class="form-group">
                <label for="pattern">表达式:</label>
                <input type="text" id="pattern" name="pattern" value="${rule.pattern}" required>
            </div>
            <div class="form-group">
                <label for="example">示例:</label>
                <input type="text" id="example" name="example" value="${rule.example}">
            </div>
            <div class="form-group">
                <label for="description">描述:</label>
                <textarea id="description" name="description" rows="3">${rule.description}</textarea>
            </div>
            <div class="form-group">
                <label for="status">状态:</label>
                <select id="status" name="status">
                    <option value="1" ${rule.status == 1 ? 'selected' : ''}>启用</option>
                    <option value="0" ${rule.status == 0 ? 'selected' : ''}>停用</option>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit">保存</button>
                <a href="${pageContext.request.contextPath}/rule/list">取消</a>
            </div>
        </form>
    </div>
</body>
</html> 