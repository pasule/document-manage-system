<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>上传档案</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .upload-card { width: 400px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: bold; color: #1976d2; }
        .form-group input[type="text"], .form-group input[type="file"] { width: 100%; padding: 8px; border: 1px solid #bdbdbd; border-radius: 4px; box-sizing: border-box; }
        .form-group input[type="submit"] { width: 100%; background: #1976d2; color: #fff; border: none; border-radius: 4px; padding: 12px; font-size: 16px; cursor: pointer; transition: background 0.2s; }
        .form-group input[type="submit"]:hover { background: #1565c0; }
    </style>
</head>
<body>
<div class="upload-card">
    <h2>上传档案</h2>
    <form action="${pageContext.request.contextPath}/document/upload" method="post">
        <div class="form-group">
            <label>编号:</label>
            <input type="text" name="code" required>
        </div>
        <div class="form-group">
            <label>标题:</label>
            <input type="text" name="title" required>
        </div>
        <div class="form-group">
            <label>密级:</label>
            <input type="text" name="secretLevelName" required>
        </div>
        <div class="form-group">
            <label>文件:</label>
            <input type="file" name="file" required>
        </div>
        <div class="form-group">
            <input type="submit" value="上传">
        </div>
    </form>
</div>
</body>
</html>