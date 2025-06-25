<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>登录 - 档案管理系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 350px;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            border: none;
            padding: 10px;
            font-size: 16px;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
            text-align: center;
        }
        .register-link {
            text-align: center;
            margin-top: 15px;
        }
        .login-options {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .login-option {
            flex: 1;
            text-align: center;
            padding: 10px;
            cursor: pointer;
            border-radius: 4px;
        }
        .login-option.active {
            background-color: #e0f7fa;
            font-weight: bold;
        }
        .admin-login-info {
            margin-top: 10px;
            font-size: 12px;
            color: #777;
            text-align: center;
            display: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>登录</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <div class="login-options">
            <div class="login-option active" id="user-login-option" onclick="switchLoginType('user')">普通用户登录</div>
            <div class="login-option" id="admin-login-option" onclick="switchLoginType('admin')">管理员登录</div>
        </div>
        
        <div id="admin-login-info" class="admin-login-info">
            管理员账号: admin<br>
            默认密码: 123456
        </div>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <input type="hidden" id="isAdmin" name="isAdmin" value="0">
            
            <div class="form-group">
                <label for="username">用户名:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">密码:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <input type="submit" value="登录">
            </div>
        </form>
        
        <div class="register-link">
            还没有账号？<a href="${pageContext.request.contextPath}/register">立即注册</a>
        </div>
    </div>
    
    <script>
        function switchLoginType(type) {
            if (type === 'admin') {
                document.getElementById('admin-login-option').classList.add('active');
                document.getElementById('user-login-option').classList.remove('active');
                document.getElementById('isAdmin').value = '1';
                document.getElementById('admin-login-info').style.display = 'block';
                document.getElementById('username').value = 'admin';
                document.getElementById('password').value = '123456';
            } else {
                document.getElementById('user-login-option').classList.add('active');
                document.getElementById('admin-login-option').classList.remove('active');
                document.getElementById('isAdmin').value = '0';
                document.getElementById('admin-login-info').style.display = 'none';
                document.getElementById('username').value = '';
                document.getElementById('password').value = '';
            }
        }
    </script>
</body>
</html>