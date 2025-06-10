<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head><title>热门档案排行</title></head>
<body>
<h2>热门档案排行</h2>
<table border="1">
    <tr>
        <th>排名</th><th>档案编号</th><th>标题</th><th>借阅次数</th>
    </tr>
    <c:forEach var="item" items="${ranking}" varStatus="status">
        <tr>
            <td>${status.index + 1}</td>
            <td>${item.code}</td>
            <td>${item.title}</td>
            <td>${item.count}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 