<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head><title>我的档案</title></head>
<body>
<h2>我的档案</h2>
<table border="1">
    <tr>
        <th>编号</th><th>标题</th><th>密级</th><th>操作</th>
    </tr>
    <c:forEach var="doc" items="${docs}">
        <tr>
            <td>${doc.code}</td>
            <td>${doc.title}</td>
            <td>${doc.secretLevelName}</td>
            <td>
                <a href="#">查看</a>
                <a href="#">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 