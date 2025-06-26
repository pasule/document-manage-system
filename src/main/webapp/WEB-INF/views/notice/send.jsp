<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>发送新通知</title>
    <style>
        :root {
            --primary: #3498db;
            --success: #2ecc71;
            --danger: #e74c3c;
            --gray: #95a5a6;
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
            background-color: var(--primary);
            color: white;
            padding: 20px 25px;
        }

        .header h1 {
            font-size: 24px;
            font-weight: 500;
        }

        .form-container {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-col {
            flex: 1;
        }

        .radio-group {
            display: flex;
            gap: 20px;
        }

        .radio-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .radio-item input[type="radio"] {
            appearance: none;
            width: 18px;
            height: 18px;
            border: 2px solid #bdc3c7;
            border-radius: 50%;
            position: relative;
            cursor: pointer;
        }

        .radio-item input[type="radio"]:checked {
            border-color: var(--primary);
        }

        .radio-item input[type="radio"]:checked::after {
            content: '';
            position: absolute;
            top: 3px;
            left: 3px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--primary);
        }

        .priority-indicator {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .priority-1 { background-color: #ecf0f1; color: #7f8c8d; }
        .priority-2 { background-color: #f39c12; color: white; }
        .priority-3 { background-color: #c0392b; color: white; }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .btn {
            padding: 12px 25px;
            border-radius: 5px;
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

        .btn-cancel {
            background-color: var(--gray);
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .error-message {
            color: var(--danger);
            background-color: #ffebee;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            border-left: 4px solid var(--danger);
        }

        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 10px;
        }

        .user-selector {
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
        }

        .user-item {
            display: flex;
            align-items: center;
            padding: 8px 10px;
            cursor: pointer;
            border-radius: 4px;
        }

        .user-item:hover {
            background-color: #e3f2fd;
        }

        .user-name {
            font-weight: 500;
        }

        .user-department {
            font-size: 13px;
            color: #7f8c8d;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>发送新通知</h1>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
            发送失败：${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/notice/send" method="post" class="form-container">
        <div class="form-group">
            <label class="form-label">通知标题 *</label>
            <input type="text" class="form-control" name="title" required
                   placeholder="请输入通知标题" value="${notice.title}">
        </div>

        <div class="form-group">
            <label class="form-label">通知内容 *</label>
            <textarea class="form-control" name="content" required
                      placeholder="请输入通知详细内容...">${notice.content}</textarea>
        </div>

        <div class="form-row">
            <div class="form-col">
                <div class="form-group">
                    <label class="form-label">通知类型</label>
                    <select class="form-control" name="type">
                        <option value="system" selected>系统通知</option>
                        <option value="approval">审批通知</option>
                        <option value="borrow">借阅通知</option>
                        <option value="other">其他通知</option>
                    </select>
                </div>
            </div>

            <div class="form-col">
                <div class="form-group">
                    <label class="form-label">接收人 *</label>
                    <select class="form-control" name="receiverId" required>
                        <option value="">请选择接收人</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}" ${user.id == notice.receiverId ? 'selected' : ''}>
                                    ${user.realName} (${user.username})
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">优先级</label>
            <div class="radio-group">
                <div class="radio-item">
                    <input type="radio" id="priority1" name="priority" value="1" checked>
                    <label for="priority1">
                        <span class="priority-indicator priority-1">普通</span>
                    </label>
                </div>
                <div class="radio-item">
                    <input type="radio" id="priority2" name="priority" value="2"
                    ${notice.priority == 2 ? 'checked' : ''}>
                    <label for="priority2">
                        <span class="priority-indicator priority-2">重要</span>
                    </label>
                </div>
                <div class="radio-item">
                    <input type="radio" id="priority3" name="priority" value="3"
                    ${notice.priority == 3 ? 'checked' : ''}>
                    <label for="priority3">
                        <span class="priority-indicator priority-3">紧急</span>
                    </label>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">备注</label>
            <textarea class="form-control" name="remark"
                      placeholder="添加备注信息...">${notice.remark}</textarea>
        </div>

        <div class="action-buttons">
            <button type="submit" class="btn btn-primary">发送通知</button>
            <a href="${pageContext.request.contextPath}/notice/list" class="btn btn-cancel">取消返回</a>
        </div>
    </form>
</div>
</body>
</html>