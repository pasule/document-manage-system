<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/functions" %>
<html>
<head>
    <title>系统通知管理</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f6f8;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 25px;
        }
        h2 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
            margin-bottom: 25px;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            text-align: center;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }
        .btn-secondary {
            background-color: #7f8c8d;
            color: white;
        }
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        .search-form {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 25px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .search-form input, .search-form select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-form .form-group {
            display: flex;
            flex-direction: column;
            min-width: 200px;
        }
        .search-form label {
            font-size: 13px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        th {
            background-color: #2c3e50;
            color: white;
            padding: 12px 15px;
            text-align: left;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f7fd;
        }
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            color: #555;
        }
        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        .status-0 {
            background-color: #e74c3c;
            color: white;
        }
        .status-1 {
            background-color: #27ae60;
            color: white;
        }
        .status-2 {
            background-color: #7f8c8d;
            color: white;
        }
        .priority-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        .priority-1 {
            background-color: #bdc3c7;
            color: #2c3e50;
        }
        .priority-2 {
            background-color: #f39c12;
            color: white;
        }
        .priority-3 {
            background-color: #c0392b;
            color: white;
        }
        .actions {
            display: flex;
            gap: 8px;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 5px;
        }
        .pagination a, .pagination span {
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
        }
        .pagination a.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        .type-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            background-color: #e0f7fa;
            color: #00838f;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>系统通知管理</h2>

    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/notice/send" class="btn btn-primary">发送新通知</a>
        <button type="button" class="btn btn-secondary" id="batchArchiveBtn">批量归档</button>
    </div>

    <!-- 搜索区域 -->
    <div class="search-form">
        <div class="form-group">
            <label for="title">通知标题</label>
            <input type="text" id="title" name="title" placeholder="输入标题关键字">
        </div>

        <div class="form-group">
            <label for="status">状态</label>
            <select id="status" name="status">
                <option value="">全部状态</option>
                <option value="0">未读</option>
                <option value="1">已读</option>
                <option value="2">已归档</option>
            </select>
        </div>

        <div class="form-group">
            <label for="priority">优先级</label>
            <select id="priority" name="priority">
                <option value="">全部优先级</option>
                <option value="1">普通</option>
                <option value="2">重要</option>
                <option value="3">紧急</option>
            </select>
        </div>

        <div class="form-group">
            <label>&nbsp;</label>
            <button class="btn btn-primary" style="align-self: flex-end;">搜索</button>
        </div>
    </div>

    <table>
        <thead>
        <tr class="icon-text-width=100%">
            <th>ID</th>
            <th>标题</th>
            <th>类型</th>
            <th>优先级</th>
            <th>状态</th>
            <th>发送人</th>
            <th>接收人</th>
            <th>发送时间</th>
            <th>阅读时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="notice" items="${notices}">
            <tr>
                <td>
                    <input type="checkbox" class="notice-checkbox" value="${notice.id}">
                </td>
                <td>${notice.id}</td>
                <td>${notice.title}</td>
                <td>
                            <span class="type-badge">
                                <c:choose>
                                    <c:when test="${notice.type == 'system'}">系统</c:when>
                                    <c:when test="${notice.type == 'approval'}">审批</c:when>
                                    <c:when test="${notice.type == 'borrow'}">借阅</c:when>
                                    <c:otherwise>其他</c:otherwise>
                                </c:choose>
                            </span>
                </td>
                <td>
                            <span class="priority-badge priority-${notice.priority}">
                                <c:choose>
                                    <c:when test="${notice.priority == 1}">普通</c:when>
                                    <c:when test="${notice.priority == 2}">重要</c:when>
                                    <c:when test="${notice.priority == 3}">紧急</c:when>
                                    <c:otherwise>未知</c:otherwise>
                                </c:choose>
                            </span>
                </td>
                <td>
                            <span class="status-badge status-${notice.status}">
                                <c:choose>
                                    <c:when test="${notice.status == 0}">未读</c:when>
                                    <c:when test="${notice.status == 1}">已读</c:when>
                                    <c:when test="${notice.status == 2}">已归档</c:when>
                                    <c:otherwise>未知状态</c:otherwise>
                                </c:choose>
                            </span>
                </td>
                <td>${notice.senderId}</td>
                <td>${notice.receiverId}</td>
                <td><fmt:formatDate value="${notice.sendTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                    <c:choose>
                        <c:when test="${notice.readTime != null}">
                            <fmt:formatDate value="${notice.readTime}" pattern="yyyy-MM-dd HH:mm"/>
                        </c:when>
                        <c:otherwise>
                            -
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="actions">
                    <c:if test="${notice.status != 1 && notice.status != 2}">
                        <a href="${pageContext.request.contextPath}/notice/read/${notice.id}"
                           class="btn btn-primary"
                           style="padding: 5px 10px; font-size: 12px;">已读</a>
                    </c:if>
                    <c:if test="${notice.status != 2}">
                        <a href="${pageContext.request.contextPath}/notice/archive/${notice.id}"
                           class="btn btn-secondary"
                           style="padding: 5px 10px; font-size: 12px;">归档</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/notice/detail/${notice.id}"
                       class="btn"
                       style="background-color: #e0f7fa; color: #00838f; padding: 5px 10px; font-size: 12px;">详情</a>
                    <a href="${pageContext.request.contextPath}/notice/delete/${notice.id}"
                       class="btn btn-danger"
                       style="padding: 5px 10px; font-size: 12px;"
                       onclick="return confirm('确定要删除这条通知吗？')">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${page > 1}">
            <a href="?page=1">首页</a>
            <a href="?page=${page-1}">上页</a>
        </c:if>

        <c:forEach begin="1" end="${totalPages}" varStatus="loop">
            <c:choose>
                <c:when test="${loop.index == page}">
                    <span class="active">${loop.index}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=${loop.index}">${loop.index}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${page < totalPages}">
            <a href="?page=${page+1}">下页</a>
            <a href="?page=${totalPages}">末页</a>
        </c:if>
    </div>

</div>
<script>
    // 批量归档功能
    document.getElementById('batchArchiveBtn').addEventListener('click', function() {
        const selectedIds = [];
        document.querySelectorAll('.notice-checkbox:checked').forEach(checkbox => {
            selectedIds.push(checkbox.value);
        });

        if (selectedIds.length === 0) {
            alert('请至少选择一条通知进行归档');
            return;
        }

        // 动态创建表单提交
        const form = document.createElement('form');
        form.method = 'post';
        form.action = '${pageContext.request.contextPath}/notice/batch-archive';

        // 添加每个选中的ID作为隐藏字段
        selectedIds.forEach(id => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'selectedIds'; // 参数名必须与后端匹配
            input.value = id;
            form.appendChild(input);
        });

        // 将表单添加到DOM并提交
        document.body.appendChild(form);
        form.submit();
    });
</script>
</body>
</html>