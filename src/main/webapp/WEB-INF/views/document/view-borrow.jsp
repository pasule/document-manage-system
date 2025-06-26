<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>借阅详情</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .container { width: 90%; max-width: 800px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; }
        .info-section { margin-bottom: 30px; }
        .info-title { color: #1976d2; font-weight: bold; margin-bottom: 15px; font-size: 18px; }
        .info-row { display: flex; margin-bottom: 10px; border-bottom: 1px solid #e0e0e0; padding-bottom: 10px; }
        .info-label { width: 35%; font-weight: bold; color: #555; }
        .info-value { width: 65%; }
        .status-0 { color: #ff9800; } /* 申请中 */
        .status-1 { color: #4caf50; } /* 已借出 */
        .status-2 { color: #2196f3; } /* 已归还 */
        .status-3 { color: #f44336; } /* 逾期 */
        .status-4 { color: #9e9e9e; } /* 已拒绝 */
        .action-btn { background: #1976d2; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .action-btn:hover { background: #1565c0; }
        .action-btn.return { background: #4caf50; }
        .action-btn.return:hover { background: #388e3c; }
        .buttons { display: flex; justify-content: center; gap: 20px; margin-top: 30px; }
        .back-btn { background: #757575; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 16px; }
        .back-btn:hover { background: #616161; }
    </style>
</head>
<body>
<div class="container">
    <h2>借阅详情</h2>
    
    <div class="info-section">
        <div class="info-title">档案信息</div>
        <div class="info-row">
            <div class="info-label">档案标题</div>
            <div class="info-value">${borrow.documentTitle}</div>
        </div>
        <div class="info-row">
            <div class="info-label">档案编号</div>
            <div class="info-value">${borrow.documentCode}</div>
        </div>
        <div class="info-row">
            <div class="info-label">档案分类</div>
            <div class="info-value">${borrow.categoryName}</div>
        </div>
        <div class="info-row">
            <div class="info-label">密级</div>
            <div class="info-value">${borrow.secretLevelName}</div>
        </div>
    </div>
    
    <div class="info-section">
        <div class="info-title">借阅信息</div>
        <div class="info-row">
            <div class="info-label">借阅人</div>
            <div class="info-value">${borrow.userName}</div>
        </div>
        <div class="info-row">
            <div class="info-label">借阅时间</div>
            <div class="info-value">${borrow.borrowTime}</div>
        </div>
        <div class="info-row">
            <div class="info-label">应还时间</div>
            <div class="info-value">${borrow.dueTime}</div>
        </div>
        <div class="info-row">
            <div class="info-label">归还时间</div>
            <div class="info-value">${borrow.returnTime != null ? borrow.returnTime : '未归还'}</div>
        </div>
        <div class="info-row">
            <div class="info-label">借阅状态</div>
            <div class="info-value">
                <span class="status-${borrow.status}">
                    <c:choose>
                        <c:when test="${borrow.status == 0}">申请中</c:when>
                        <c:when test="${borrow.status == 1}">已借出</c:when>
                        <c:when test="${borrow.status == 2}">已归还</c:when>
                        <c:when test="${borrow.status == 3}">逾期</c:when>
                        <c:when test="${borrow.status == 4}">已拒绝</c:when>
                        <c:otherwise>未知</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
        <div class="info-row">
            <div class="info-label">备注</div>
            <div class="info-value">${borrow.remark != null ? borrow.remark : '无'}</div>
        </div>
    </div>
    
    <div class="buttons">
        <c:if test="${(borrow.status == 1 || borrow.status == 3) && (borrow.userId == sessionScope.userId || sessionScope.isAdmin)}">
            <a href="${pageContext.request.contextPath}/document/return?id=${borrow.id}" class="action-btn return">归还档案</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/document/view?id=${borrow.documentId}" class="action-btn">查看档案</a>
        <a href="${pageContext.request.contextPath}/document/approve-list" class="back-btn">返回列表</a>
    </div>
</div>
</body>
</html> 