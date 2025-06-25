<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>借阅审批</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 700px;
            margin: 20px auto;
            background: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }
        h2 {
            color: #333;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-top: 0;
        }
        .info-section {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            border-left: 4px solid #5bc0de;
        }
        .document-info {
            border-left-color: #5cb85c;
        }
        .user-info {
            border-left-color: #f0ad4e;
        }
        .borrow-info {
            border-left-color: #d9534f;
        }
        .info-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
            font-size: 16px;
        }
        .info-row {
            display: flex;
            margin-bottom: 8px;
        }
        .info-label {
            width: 100px;
            font-weight: bold;
            color: #555;
        }
        .info-value {
            flex: 1;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            height: 100px;
            resize: vertical;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 14px;
            text-align: center;
            white-space: nowrap;
            cursor: pointer;
            border: 1px solid transparent;
            border-radius: 4px;
            text-decoration: none;
        }
        .btn-approve {
            color: #fff;
            background-color: #5cb85c;
            border-color: #4cae4c;
            flex: 1;
            margin-right: 10px;
        }
        .btn-reject {
            color: #fff;
            background-color: #d9534f;
            border-color: #d43f3a;
            flex: 1;
            margin-left: 10px;
        }
        .btn-back {
            color: #333;
            background-color: #fff;
            border-color: #ccc;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/document/borrow-list" class="btn btn-back">返回借阅列表</a>
        
        <h2>借阅审批</h2>
        
        <c:if test="${not empty error}">
            <div style="color: red; margin-bottom: 15px;">${error}</div>
        </c:if>
        
        <!-- 档案信息 -->
        <div class="info-section document-info">
            <div class="info-title">档案信息</div>
            <div class="info-row">
                <div class="info-label">标题:</div>
                <div class="info-value">${borrow.documentTitle}</div>
            </div>
            <div class="info-row">
                <div class="info-label">编号:</div>
                <div class="info-value">${borrow.documentCode}</div>
            </div>
            <div class="info-row">
                <div class="info-label">分类:</div>
                <div class="info-value">${borrow.categoryName}</div>
            </div>
            <div class="info-row">
                <div class="info-label">密级:</div>
                <div class="info-value">${borrow.secretLevelName}</div>
            </div>
        </div>
        
        <!-- 借阅人信息 -->
        <div class="info-section user-info">
            <div class="info-title">借阅人信息</div>
            <div class="info-row">
                <div class="info-label">用户名:</div>
                <div class="info-value">${borrow.userName}</div>
            </div>
            <div class="info-row">
                <div class="info-label">真实姓名:</div>
                <div class="info-value">${borrow.userRealName}</div>
            </div>
        </div>
        
        <!-- 借阅信息 -->
        <div class="info-section borrow-info">
            <div class="info-title">借阅信息</div>
            <div class="info-row">
                <div class="info-label">申请时间:</div>
                <div class="info-value">
                    <c:if test="${not empty borrow.borrowTime}">
                        <c:catch var="parseException">
                            <fmt:parseDate value="${borrow.borrowTime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedBorrowTime" type="both" />
                        </c:catch>
                        <c:if test="${not empty parseException}">
                            <c:catch var="parseException2">
                                <fmt:parseDate value="${borrow.borrowTime}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedBorrowTime" type="both" />
                            </c:catch>
                        </c:if>
                        <c:if test="${not empty parseException2}">
                            <c:catch var="parseException3">
                                <fmt:parseDate value="${borrow.borrowTime}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedBorrowTime" type="both" />
                            </c:catch>
                        </c:if>
                        <fmt:formatDate value="${parsedBorrowTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </c:if>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">应还时间:</div>
                <div class="info-value">
                    <c:if test="${not empty borrow.dueTime}">
                        <c:catch var="parseException">
                            <fmt:parseDate value="${borrow.dueTime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDueTime" type="both" />
                        </c:catch>
                        <c:if test="${not empty parseException}">
                            <c:catch var="parseException2">
                                <fmt:parseDate value="${borrow.dueTime}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedDueTime" type="both" />
                            </c:catch>
                        </c:if>
                        <c:if test="${not empty parseException2}">
                            <c:catch var="parseException3">
                                <fmt:parseDate value="${borrow.dueTime}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDueTime" type="both" />
                            </c:catch>
                        </c:if>
                        <fmt:formatDate value="${parsedDueTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </c:if>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">借阅原因:</div>
                <div class="info-value">${borrow.remark}</div>
            </div>
        </div>
        
        <!-- 审批表单 -->
        <form action="${pageContext.request.contextPath}/document/approve-borrow" method="post" id="approveForm">
            <input type="hidden" name="borrowId" value="${borrow.id}">
            
            <div class="form-group">
                <label for="approveRemark">审批意见:</label>
                <textarea id="approveRemark" name="approveRemark" placeholder="请输入审批意见"></textarea>
            </div>
            
            <div class="btn-group">
                <button type="submit" name="action" value="approve" class="btn btn-approve">批准借阅</button>
                <button type="submit" name="action" value="reject" class="btn btn-reject">拒绝借阅</button>
            </div>
        </form>
    </div>
</body>
</html> 