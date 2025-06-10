<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head><title>上传档案</title></head>
<body>
<h2>上传档案</h2>
<form action="${pageContext.request.contextPath}/document/upload" method="post">
    <label>编号: <input type="text" name="code" required></label><br>
    <label>标题: <input type="text" name="title" required></label><br>
    <label>密级: <input type="text" name="secretLevelName" required></label><br>
    <label>文件: <input type="file" name="file" required></label><br>
    <input type="submit" value="上传">
</form>
</body>
</html>