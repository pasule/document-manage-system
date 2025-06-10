<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head><title>借阅统计</title></head>
<body>
<h2>借阅统计</h2>
<table border="1">
    <tr>
        <th>档案编号</th><th>标题</th><th>借阅次数</th>
    </tr>
    <c:forEach var="stat" items="${stats}">
        <tr>
            <td>${stat.code}</td>
            <td>${stat.title}</td>
            <td>${stat.count}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 