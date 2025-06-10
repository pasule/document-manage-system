<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head><title>借阅统计导出模板</title></head>
<body>
<h2>借阅统计导出模板</h2>
<table border="1">
    <tr>
        <th>模板名称</th><th>类型</th><th>操作</th>
    </tr>
    <c:forEach var="tpl" items="${templates}">
        <tr>
            <td>${tpl.name}</td>
            <td>${tpl.typeText}</td>
            <td>
                <a href="#">导出</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 