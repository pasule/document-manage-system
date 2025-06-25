<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>借阅记录列表</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 90%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }
        h2 {
            color: #333;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: 400;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            border: 1px solid transparent;
            border-radius: 4px;
            text-decoration: none;
        }
        .btn-primary {
            color: #fff;
            background-color: #337ab7;
            border-color: #2e6da4;
        }
        .btn-success {
            color: #fff;
            background-color: #5cb85c;
            border-color: #4cae4c;
        }
        .btn-danger {
            color: #fff;
            background-color: #d9534f;
            border-color: #d43f3a;
        }
        .btn-warning {
            color: #fff;
            background-color: #f0ad4e;
            border-color: #eea236;
        }
        .filter-form {
            margin: 20px 0;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .filter-form input, .filter-form select {
            padding: 6px 10px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .status-badge {
            display: inline-block;
            padding: 3px 7px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-pending {
            background-color: #f0ad4e;
            color: white;
        }
        .status-approved {
            background-color: #5cb85c;
            color: white;
        }
        .status-returned {
            background-color: #5bc0de;
            color: white;
        }
        .status-rejected {
            background-color: #d9534f;
            color: white;
        }
        .status-overdue {
            background-color: #d9534f;
            color: white;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination a {
            color: #337ab7;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 4px;
        }
        .pagination a.active {
            background-color: #337ab7;
            color: white;
            border: 1px solid #337ab7;
        }
        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
        .admin-actions {
            margin-top: 5px;
        }
        .admin-actions .btn {
            margin-right: 5px;
            padding: 3px 8px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>借阅记录列表</h2>
        
        <c:if test="${not empty error}">
            <div style="color: red; margin-bottom: 15px;">${error}</div>
        </c:if>
        
        <div class="filter-form">
            <form action="${pageContext.request.contextPath}/document/borrow-list" method="get">
                <label for="status">状态:</label>
                <select name="status" id="status">
                    <option value="">全部</option>
                    <option value="0" ${param.status == '0' ? 'selected' : ''}>申请中</option>
                    <option value="1" ${param.status == '1' ? 'selected' : ''}>已借出</option>
                    <option value="2" ${param.status == '2' ? 'selected' : ''}>已归还</option>
                    <option value="3" ${param.status == '3' ? 'selected' : ''}>逾期</option>
                    <option value="4" ${param.status == '4' ? 'selected' : ''}>已拒绝</option>
                </select>
                
                <label for="documentTitle">档案标题:</label>
                <input type="text" name="documentTitle" id="documentTitle" value="${param.documentTitle}">
                
                <c:if test="${isAdmin}">
                    <input type="hidden" name="mine" value="${param.mine}">
                </c:if>
                
                <c:if test="${!isAdmin}">
                    <input type="hidden" name="mine" value="true">
                </c:if>
                
                <button type="submit" class="btn btn-primary">筛选</button>
                
                <c:if test="${isAdmin}">
                    <a href="${pageContext.request.contextPath}/document/borrow-list?status=0" class="btn btn-warning">查看待审批</a>
                </c:if>
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>档案标题</th>
                    <th>借阅人</th>
                    <th>借阅时间</th>
                    <th>应还时间</th>
                    <th>实际归还时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="borrow" items="${borrows}">
                    <tr>
                        <td>${borrow.id}</td>
                        <td>${borrow.document_title}</td>
                        <td>${borrow.user_name}</td>
                        <td>
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
                        </td>
                        <td>
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
                        </td>
                        <td>
                            <c:if test="${not empty borrow.returnTime}">
                                <c:catch var="parseException">
                                    <fmt:parseDate value="${borrow.returnTime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedReturnTime" type="both" />
                                </c:catch>
                                <c:if test="${not empty parseException}">
                                    <c:catch var="parseException2">
                                        <fmt:parseDate value="${borrow.returnTime}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedReturnTime" type="both" />
                                    </c:catch>
                                </c:if>
                                <c:if test="${not empty parseException2}">
                                    <c:catch var="parseException3">
                                        <fmt:parseDate value="${borrow.returnTime}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedReturnTime" type="both" />
                                    </c:catch>
                                </c:if>
                                <fmt:formatDate value="${parsedReturnTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${borrow.status == 0}">
                                    <span class="status-badge status-pending">申请中</span>
                                </c:when>
                                <c:when test="${borrow.status == 1}">
                                    <span class="status-badge status-approved">已借出</span>
                                </c:when>
                                <c:when test="${borrow.status == 2}">
                                    <span class="status-badge status-returned">已归还</span>
                                </c:when>
                                <c:when test="${borrow.status == 3}">
                                    <span class="status-badge status-overdue">逾期</span>
                                </c:when>
                                <c:when test="${borrow.status == 4}">
                                    <span class="status-badge status-rejected">已拒绝</span>
                                </c:when>
                                <c:otherwise>
                                    未知状态
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty borrow.document_id}">
                                    <a href="${pageContext.request.contextPath}/document/view?id=${borrow.document_id}" class="btn btn-primary">查看档案</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="btn btn-primary" style="opacity: 0.5; cursor: not-allowed;">查看档案</span>
                                </c:otherwise>
                            </c:choose>
                            
                            <c:if test="${(borrow.status == 1 || borrow.status == 3) && (borrow.userId == currentUserId || sessionScope.isAdmin)}">
                                <a href="${pageContext.request.contextPath}/document/return?id=${borrow.id}" class="btn btn-success" onclick="return confirm('确认归还此档案吗？')">归还</a>
                            </c:if>
                            
                            <c:if test="${sessionScope.isAdmin == true && borrow.status == 0}">
                                <div class="admin-actions">
                                    <button class="btn btn-warning" 
                                           onclick="window.location.href='${pageContext.request.contextPath}/document/approve-borrow?id=${borrow.id}'; return false;">
                                        审批
                                    </button>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty borrows}">
                    <tr>
                        <td colspan="8" style="text-align: center;">没有找到符合条件的借阅记录</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/document/borrow-list?page=${currentPage - 1}&status=${param.status}&documentTitle=${param.documentTitle}&mine=${param.mine}">上一页</a>
            </c:if>
            
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${currentPage == i}">
                        <a class="active" href="#">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/document/borrow-list?page=${i}&status=${param.status}&documentTitle=${param.documentTitle}&mine=${param.mine}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/document/borrow-list?page=${currentPage + 1}&status=${param.status}&documentTitle=${param.documentTitle}&mine=${param.mine}">下一页</a>
            </c:if>
        </div>
    </div>
</body>
</html> 