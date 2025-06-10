<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head><title>过期档案列表</title></head>
<body>
<h2>过期档案列表</h2>
<table border="1">
    <tr>
        <th>编号</th><th>标题</th><th>密级</th><th>过期时间</th>
    </tr>
    <c:forEach var="doc" items="${expiredDocs}">
        <tr>
            <td>${doc.code}</td>
            <td>${doc.title}</td>
            <td>${doc.secretLevelName}</td>
            <td>${doc.expiredDate}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 