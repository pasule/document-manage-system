<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>批量归档通知</title>
    <style>
        :root {
            --primary: #3498db;
            --warning: #f39c12;
            --danger: #e74c3c;
            --gray: #95a5a6;
            --dark: #2c3e50;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f1f5f9;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background-color: var(--warning);
            color: white;
            padding: 20px 25px;
        }

        .header h1 {
            font-size: 24px;
            font-weight: 500;
        }

        .content {
            padding: 25px;
        }

        .alert-box {
            background-color: #fff8e1;
            border-left: 4px solid var(--warning);
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 0 4px 4px 0;
        }

        .alert-box h3 {
            color: var(--dark);
            margin-bottom: 10px;
        }

        .notice-list {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #eee;
            border-radius: 4px;
            margin-bottom: 25px;
        }

        .notice-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        .notice-item:last-child {
            border-bottom: none;
        }

        .notice-info {
            flex: 1;
        }

        .notice-title {
            font-weight: 500;
            margin-bottom: 5px;
            color: var(--dark);
        }

        .notice-meta {
            display: flex;
            font-size: 13px;
            color: #7f8c8d;
            gap: 15px;
        }

        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .priority-1 { background-color: #ecf0f1; color: var(--dark); }
        .priority-2 { background-color: var(--warning); color: white; }
        .priority-3 { background-color: var(--danger); color: white; }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn {
            padding: 12px 30px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            text-align: center;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }

        .btn-confirm {
            background-color: var(--warning);
            color: white;
        }

        .btn-cancel {
            background-color: var(--gray);
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .selected-count {
            text-align: center;
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: 500;
            color: var(--dark);
        }

        .selected-count span {
            color: var(--warning);
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>批量归档通知</h1>
    </div>

    <div class="content">
        <div class="alert-box">
            <h3>操作确认</h3>
            <p>您即将归档选中的通知。归档后，这些通知将被标记为"已归档"状态，不再显示在常规通知列表中。</p>
        </div>

        <div class="selected-count">
            已选择 <span>${fn:length(notices)}</span> 条通知
        </div>

        <div class="notice-list">
            <c:forEach var="notice" items="${notices}">
                <div class="notice-item">
                    <div class="notice-info">
                        <div class="notice-title">${notice.title}</div>
                        <div class="notice-meta">
                            <span>发送人: ${notice.senderName}</span>
                            <span>接收人: ${notice.receiverName}</span>
                            <span>发送时间: <fmt:formatDate value="${notice.sendTime}" pattern="yyyy-MM-dd"/></span>
                            <span class="badge priority-${notice.priority}">
                                    <c:choose>
                                        <c:when test="${notice.priority == 1}">普通</c:when>
                                        <c:when test="${notice.priority == 2}">重要</c:when>
                                        <c:when test="${notice.priority == 3}">紧急</c:when>
                                    </c:choose>
                                </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <form action="${pageContext.request.contextPath}/notice/batch-archive" method="post">
            <!-- 传递选中的通知ID -->
            <c:forEach var="notice" items="${notices}">
                <input type="hidden" name="selectedIds" value="${notice.id}">
            </c:forEach>

            <div class="action-buttons">
                <button type="submit" class="btn btn-confirm">确认归档</button>
                <a href="${pageContext.request.contextPath}/notice/list" class="btn btn-cancel">取消返回</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>