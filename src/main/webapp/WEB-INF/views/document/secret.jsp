<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>密级档案</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .doc-table { width: 90%; margin: 30px auto; border-collapse: collapse; background: #fff; box-shadow: 0 2px 8px #e0e0e0; border-radius: 8px; overflow: hidden; }
        .doc-table th, .doc-table td { padding: 14px 12px; text-align: center; }
        .doc-table th { background: #8e24aa; color: #fff; font-size: 16px; }
        .doc-table tr:nth-child(even) { background: #f3e5f5; }
        .doc-table tr:hover { background: #ce93d8; }
        .action-btn { background: #8e24aa; color: #fff; border: none; border-radius: 4px; padding: 6px 16px; margin: 0 4px; cursor: pointer; transition: background 0.2s; text-decoration: none; }
        .action-btn:hover { background: #6d1b7b; }
        .header-container { display: flex; justify-content: space-between; align-items: center; width: 90%; margin: 30px auto 10px auto; }
        .home-button { background: #ff9800; color: #fff; border: none; border-radius: 4px; padding: 8px 16px; cursor: pointer; text-decoration: none; font-weight: bold; }
        .home-button:hover { background: #f57c00; }
    </style>
    <script>
        function confirmDelete(id) {
            if (confirm("确定要将此档案移至回收站吗？")) {
                window.location.href = "${pageContext.request.contextPath}/document/delete?id=" + id;
            }
        }
    </script>
</head>
<body>
<div class="header-container">
    <h2 style="color:#8e24aa; margin:0;">密级档案</h2>
    <a href="${pageContext.request.contextPath}/" class="home-button">返回主页</a>
</div>

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
                <a href="javascript:void(0)" onclick="confirmDelete(${doc.id})" class="action-btn" style="background:#e53935;">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 