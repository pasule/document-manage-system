<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文件测试</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        h2 {
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        form {
            margin-top: 20px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>文件存储测试</h1>
        
        <div class="section">
            <h2>目录信息</h2>
            <div class="info">
                <c:out value="${fileInfo}" escapeXml="false"/>
            </div>
        </div>
        
        <div class="section">
            <h2>上传测试</h2>
            <form action="${pageContext.request.contextPath}/document/upload" method="post" enctype="multipart/form-data">
                <div>
                    <label for="title">文档标题:</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div>
                    <label for="file">选择文件:</label>
                    <input type="file" id="file" name="file" required>
                </div>
                <input type="submit" value="上传文件">
            </form>
        </div>
        
        <div class="section">
            <h2>直接上传测试</h2>
            <p>直接上传文件到uploads目录，不通过数据库</p>
            <form action="${pageContext.request.contextPath}/document/upload-test" method="post" enctype="multipart/form-data">
                <div>
                    <label for="testFile">选择文件:</label>
                    <input type="file" id="testFile" name="file" required>
                </div>
                <input type="submit" value="直接上传测试">
            </form>
        </div>
        
        <div class="section">
            <h2>手动测试下载链接</h2>
            <p>尝试手动构建下载链接来测试文件访问</p>
            <form id="testForm" onsubmit="return false;">
                <div>
                    <label for="filename">文件名:</label>
                    <input type="text" id="filename" placeholder="例如: 1624512345_test.jpg">
                </div>
                <button type="button" onclick="testDownload()">测试访问</button>
            </form>
            <div id="result" style="margin-top: 10px;"></div>
            
            <script>
                function testDownload() {
                    var filename = document.getElementById('filename').value;
                    if (!filename) {
                        alert('请输入文件名');
                        return;
                    }
                    
                    var basePath = '${pageContext.request.contextPath}';
                    var url = basePath + '/uploads/' + filename;
                    
                    // 显示链接
                    var resultDiv = document.getElementById('result');
                    resultDiv.innerHTML = '<p>测试链接: <a href="' + url + '" target="_blank">' + url + '</a></p>';
                    
                    // 测试文件是否存在
                    var img = new Image();
                    img.onload = function() {
                        resultDiv.innerHTML += '<p style="color: green;">文件存在并可访问</p>';
                    };
                    img.onerror = function() {
                        resultDiv.innerHTML += '<p style="color: red;">文件不存在或无法访问</p>';
                    };
                    img.src = url;
                }
            </script>
        </div>
        
        <div class="section">
            <h2>测试文件下载</h2>
            <p>直接下载测试文件(test.txt)</p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/uploads/test.txt" target="_blank">方式1：直接访问静态资源</a></li>
                <li><a href="${pageContext.request.contextPath}/document/download-test-file" target="_blank">方式2：通过控制器下载</a></li>
            </ul>
        </div>
        
        <div class="section">
            <h2>诊断工具</h2>
            <p>检查服务器配置和文件访问情况</p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/document/test-paths" target="_blank">检查路径配置</a></li>
                <li><a href="${pageContext.request.contextPath}/document/test-files" target="_blank">检查文件目录</a></li>
                <li><a href="${pageContext.request.contextPath}/document/diagnose-uploads" target="_blank">诊断上传目录问题</a></li>
            </ul>
        </div>
    </div>
</body>
</html> 