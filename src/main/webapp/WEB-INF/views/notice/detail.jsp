<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>通知详情</title>
    <style>
        :root {
            --primary: #3498db;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
            --gray: #95a5a6;
            --dark: #2c3e50;
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
            background-color: var(--primary);
            color: white;
            padding: 20px 25px;
            position: relative;
        }

        .header h1 {
            font-size: 24px;
            font-weight: 500;
            margin-right: 120px;
        }

        .badge-container {
            position: absolute;
            top: 20px;
            right: 25px;
            display: flex;
            gap: 10px;
        }

        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 500;
            background-color: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .detail-container {
            padding: 30px;
        }

        .detail-card {
            background: #f8f9fa;
            border-left: 3px solid var(--primary);
            padding: 20px;
            border-radius: 0 4px 4px 0;
            margin-bottom: 30px;
        }

        .detail-row {
            display: flex;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            width: 120px;
            font-weight: 500;
            color: var(--dark);
        }

        .detail-value {
            flex: 1;
            color: #555;
        }

        .content-card {
            padding: 20px;
            border: 1px solid #e9ecef;
            border-radius: 4px;
            margin-bottom: 30px;
            background: white;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }

        .content-header {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            color: var(--dark);
        }

        .content-body {
            line-height: 1.8;
            color: #444;
            font-size: 15px;
            white-space: pre-wrap; /* 保留内容原始格式 */
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            justify-content: center;
        }

        .btn {
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            text-align: center;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-archive {
            background-color: var(--gray);
            color: white;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .status-badge {
            padding: 3px 10px;
            border-radius: 4px;
            font-size: 13px;
            display: inline-block;
        }

        .status-0 { background-color: var(--danger); color: white; }
        .status-1 { background-color: var(--success); color: white; }
        .status-2 { background-color: var(--gray); color: white; }

        .priority-badge {
            padding: 3px 10px;
            border-radius: 4px;
            font-size: 13px;
            display: inline-block;
        }

        .priority-1 { background-color: #ecf0f1; color: var(--dark); }
        .priority-2 { background-color: var(--warning); color: white; }
        .priority-3 { background-color: var(--danger); color: white; }

        .type-badge {
            padding: 3px 10px;
            border-radius: 4px;
            font-size: 13px;
            display: inline-block;
            background-color: #e1f5fe;
            color: #0288d1;
        }

        .time-info {
            display: flex;
            gap: 8px;
            font-size: 14px;
            color: #7f8c8d;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>${notice.title}</h1>
        <div class="badge-container">
            <div class="badge">
                <fmt:formatDate value="${notice.sendTime}" pattern="yyyy-MM-dd HH:mm"/>
            </div>
            <div class="badge">
                <c:choose>
                    <c:when test="${notice.type == 'system'}">系统通知</c:when>
                    <c:when test="${notice.type == 'approval'}">审批通知</c:when>
                    <c:when test="${notice.type == 'borrow'}">借阅通知</c:when>
                    <c:otherwise>其他通知</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="detail-container">
        <div class="detail-card">
            <!-- 通知ID -->
            <div class="detail-row">
                <div class="detail-label">通知ID</div>
                <div class="detail-value">${notice.id}</div>
            </div>

            <!-- 发送人信息 -->
            <div class="detail-row">
                <div class="detail-label">发送人</div>
                <div class="detail-value">
                    <div>${sender.name} (ID: ${notice.senderId})</div>
                </div>
            </div>

            <!-- 接收人信息 -->
            <div class="detail-row">
                <div class="detail-label">接收人</div>
                <div class="detail-value">
                    <div>${receiver.name} (ID: ${notice.receiverId})</div>
                </div>
            </div>

            <!-- 通知类型 -->
            <div class="detail-row">
                <div class="detail-label">通知类型</div>
                <div class="detail-value">
                        <span class="type-badge">
                            <c:choose>
                                <c:when test="${notice.type == 'system'}">系统通知</c:when>
                                <c:when test="${notice.type == 'approval'}">审批通知</c:when>
                                <c:when test="${notice.type == 'borrow'}">借阅通知</c:when>
                                <c:otherwise>其他通知</c:otherwise>
                            </c:choose>
                        </span>
                </div>
            </div>

            <!-- 优先级 -->
            <div class="detail-row">
                <div class="detail-label">优先级</div>
                <div class="detail-value">
                        <span class="priority-badge priority-${notice.priority}">
                            <c:choose>
                                <c:when test="${notice.priority == 1}">普通</c:when>
                                <c:when test="${notice.priority == 2}">重要</c:when>
                                <c:when test="${notice.priority == 3}">紧急</c:when>
                                <c:otherwise>未知</c:otherwise>
                            </c:choose>
                        </span>
                </div>
            </div>

            <!-- 通知状态 -->
            <div class="detail-row">
                <div class="detail-label">状态</div>
                <div class="detail-value">
                        <span class="status-badge status-${notice.status}">
                            <c:choose>
                                <c:when test="${notice.status == 0}">未读</c:when>
                                <c:when test="${notice.status == 1}">已读</c:when>
                                <c:when test="${notice.status == 2}">已归档</c:when>
                                <c:otherwise>未知状态</c:otherwise>
                            </c:choose>
                        </span>
                    <!-- 阅读时间 -->
                    <c:if test="${notice.readTime != null}">
                        <div class="time-info">
                            阅读时间: <fmt:formatDate value="${notice.readTime}" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                    </c:if>
                    <!-- 归档时间 -->
                    <c:if test="${notice.archiveTime != null}">
                        <div class="time-info">
                            归档时间: <fmt:formatDate value="${notice.archiveTime}" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- 发送时间 -->
            <div class="detail-row">
                <div class="detail-label">发送时间</div>
                <div class="detail-value">
                    <fmt:formatDate value="${notice.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                </div>
            </div>

            <!-- 备注信息 -->
            <c:if test="${not empty notice.remark}">
                <div class="detail-row">
                    <div class="detail-label">备注</div>
                    <div class="detail-value">${notice.remark}</div>
                </div>
            </c:if>
        </div>

        <!-- 通知内容 -->
        <div class="content-card">
            <div class="content-header">通知内容</div>
            <div class="content-body">${notice.content}</div>
        </div>

        <!-- 操作按钮 -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/notice/list"
               class="btn btn-primary">返回列表</a>

            <!-- 标记为已读按钮（仅当未读时显示） -->
            <c:if test="${notice.status == 0}">
                <a href="${pageContext.request.contextPath}/notice/read/${notice.id}"
                   class="btn btn-primary">标记为已读</a>
            </c:if>

            <!-- 归档按钮（仅当未归档时显示） -->
            <c:if test="${notice.status != 2}">
                <a href="${pageContext.request.contextPath}/notice/archive/${notice.id}"
                   class="btn btn-archive">归档通知</a>
            </c:if>

            <!-- 删除按钮 -->
            <a href="${pageContext.request.contextPath}/notice/delete/${notice.id}"
               class="btn btn-danger"
               onclick="return confirm('确定要删除这条通知吗？')">删除通知</a>
        </div>
    </div>
</div>
</body>
</html>