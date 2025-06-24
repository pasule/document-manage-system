<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>我的档案</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .doc-table { width: 90%; margin: 30px auto; border-collapse: collapse; background: #fff; box-shadow: 0 2px 8px #e0e0e0; border-radius: 8px; overflow: hidden; }
        .doc-table th, .doc-table td { padding: 14px 12px; text-align: center; }
        .doc-table th { background: #388e3c; color: #fff; font-size: 16px; }
        .doc-table tr:nth-child(even) { background: #e8f5e9; }
        .doc-table tr:hover { background: #c8e6c9; }
        .action-btn { background: #388e3c; color: #fff; border: none; border-radius: 4px; padding: 6px 16px; margin: 0 4px; cursor: pointer; transition: background 0.2s; text-decoration: none; }
        .action-btn:hover { background: #2e7031; }
    </style>
</head>
<body>
<h2 style="text-align:center; color:#388e3c; margin-top:30px;">我的档案</h2>
<table class="doc-table">
    <tr>
        <th>编号</th><th>标题</th><th>密级</th><th>操作</th>
    </tr>
    <c:forEach var="doc" items="${docs}">
        <tr>
            <td>${doc.code}</td>
            <td>${doc.title}</td>
            <td>${doc.secretLevelName}</td>
            <td>
                <a href="${pageContext.request.contextPath}/document/view?id=${doc.id}" class="action-btn">查看</a>
                <a href="#" class="action-btn" style="background:#e53935;">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 