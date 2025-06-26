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
        .header {
            background-color: #333;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info span {
            margin-right: 15px;
        }
        .user-info a {
            color: white;
            text-decoration: none;
        }
        .user-info a:hover {
            text-decoration: underline;
        }
        .sidebar {
            width: 200px;
            background-color: #333;
            color: white;
            position: fixed;
            height: 100%;
            padding-top: 20px;
        }
        .menu-item {
            padding: 10px 20px;
            border-bottom: 1px solid #444;
        }
        .menu-item:hover {
            background-color: #444;
        }
        .menu-item a {
            color: white;
            text-decoration: none;
            display: block;
        }
        .content {
            margin-left: 200px;
            padding: 20px;
        }
        .admin-badge {
            background-color: #ff9800;
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 12px;
            margin-left: 5px;
        }
        .menu-category {
            padding: 10px 20px;
            background-color: #222;
            font-weight: bold;
            border-bottom: 1px solid #444;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>档案管理系统</h1>
        <div class="user-info">
            <c:choose>
                <c:when test="${not empty username}">
                    <span>欢迎, ${realName}
                        <c:if test="${isAdmin}">
                            <span class="admin-badge">管理员</span>
                        </c:if>
                    </span>
                    <a href="${pageContext.request.contextPath}/logout">退出登录</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">登录</a>
                    <a href="${pageContext.request.contextPath}/register" style="margin-left: 10px;">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="sidebar">
        <div class="menu-category">档案管理</div>
        <div class="menu-item">
            <a href="${pageContext.request.contextPath}/document/list">档案列表</a>
        </div>
        <div class="menu-item">
            <a href="${pageContext.request.contextPath}/document/upload">上传档案</a>
        </div>
        <div class="menu-item">
            <a href="${pageContext.request.contextPath}/document/my">我的档案</a>
        </div>
        <div class="menu-item">
            <a href="${pageContext.request.contextPath}/document/borrow-list?mine=true">我的借阅</a>
        </div>
        <div class="menu-item">
            <a href="${pageContext.request.contextPath}/document/recycle">回收站</a>
        </div>

        <c:if test="${isAdmin}">
            <div class="menu-category">管理员功能</div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/document/approve-list?pending=true">待审批</a>
            </div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/document/borrow-list">借阅管理</a>
            </div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/category/list">分类管理</a>
            </div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/tag/list">标签管理</a>
            </div>
        </c:if>

        <div class="menu-category">系统设置</div>
        <div class="menu-item">
            <a href="${pageContext.request.contextPath}/rule/list">档号规则</a>
        </div>
    </div>

    <div class="content">
        <h2>欢迎使用档案管理系统</h2>
        <p>请从左侧菜单选择相应功能进行操作。</p>

        <c:if test="${isAdmin}">
            <div style="margin-top: 20px; padding: 15px; background-color: #e1f5fe; border-radius: 5px; border-left: 4px solid #03a9f4;">
                <h3 style="margin-top: 0;">管理员待办事项</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/document/approve-list?pending=true">待处理审批</a></li>
                    <li><a href="${pageContext.request.contextPath}/document/borrow-list?status=0">待处理借阅申请</a></li>
                </ul>
            </div>
        </c:if>
    </div>
</body>
</html>