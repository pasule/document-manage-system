<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head><title>全部档案</title></head>
<body>
<h2>全部档案</h2>
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
                <a href="${pageContext.request.contextPath}/document/view?id=${doc.id}">查看</a>
                <a href="${pageContext.request.contextPath}/document/delete?id=${doc.id}"
                   onclick="return confirm('确定要删除这个档案吗？')">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>