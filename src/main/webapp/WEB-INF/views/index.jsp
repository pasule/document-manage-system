<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>档案管理系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #333;
            color: white;
            padding: 10px 0;
            text-align: center;
        }
        .user-info {
            float: right;
            margin-right: 20px;
            color: white;
        }
        .menu {
            background-color: #444;
            overflow: hidden;
        }
        .menu a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        .menu a:hover {
            background-color: #ddd;
            color: black;
        }
        .content {
            padding: 20px;
            background-color: white;
            margin-top: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .feature-box {
            border: 1px solid #ddd;
            padding: 15px;
            margin: 10px;
            border-radius: 5px;
            background-color: #f9f9f9;
            width: 28%;
            float: left;
            min-height: 150px;
        }
        .feature-box h3 {
            margin-top: 0;
            color: #333;
        }
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="user-info">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    欢迎，${sessionScope.realName != null ? sessionScope.realName : sessionScope.username} | 
                    <a href="${pageContext.request.contextPath}/logout" style="color: white;">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" style="color: white;">登录</a> | 
                    <a href="${pageContext.request.contextPath}/register" style="color: white;">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
        <h1>档案管理系统</h1>
    </div>
    
    <div class="menu">
        <a href="${pageContext.request.contextPath}/">首页</a>
        <a href="${pageContext.request.contextPath}/document/list">档案列表</a>
        <a href="${pageContext.request.contextPath}/document/my">我的档案</a>
        <a href="${pageContext.request.contextPath}/document/upload">上传档案</a>
        <a href="${pageContext.request.contextPath}/document/recycle">回收站</a>
        <a href="${pageContext.request.contextPath}/stats/count">统计信息</a>
        <a href="${pageContext.request.contextPath}/tag/list">标签管理</a>
        <a href="${pageContext.request.contextPath}/category/list">分类管理</a>
        <a href="${pageContext.request.contextPath}/rule/list">编号规则管理</a>
    </div>
    
    <div class="container">
        <div class="content">
            <h2>欢迎使用档案管理系统</h2>
            
            <c:if test="${empty sessionScope.username}">
                <p>请先 <a href="${pageContext.request.contextPath}/login">登录</a> 或 <a href="${pageContext.request.contextPath}/register">注册</a> 以使用系统功能。</p>
            </c:if>
            
            <c:if test="${not empty sessionScope.username}">
                <div class="clearfix">
                    <div class="feature-box">
                        <h3>档案管理</h3>
                        <p>查看、上传、管理各类档案文件。</p>
                        <a href="${pageContext.request.contextPath}/document/list">进入档案列表</a>
                    </div>
                    
                    <div class="feature-box">
                        <h3>我的档案</h3>
                        <p>管理您创建的档案文件。</p>
                        <a href="${pageContext.request.contextPath}/document/my">查看我的档案</a>
                    </div>
                    
                    <div class="feature-box">
                        <h3>统计信息</h3>
                        <p>查看系统档案统计数据。</p>
                        <a href="${pageContext.request.contextPath}/stats/count">查看统计</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>