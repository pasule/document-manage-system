<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>档案清单导出模板</title></head>
<body>
<h2>档案清单导出模板</h2>
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