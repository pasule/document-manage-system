<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>档案详情</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .view-card { width: 480px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; }
        .detail-table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        .detail-table td { padding: 10px 8px; border-bottom: 1px solid #e0e0e0; }
        .detail-table tr:last-child td { border-bottom: none; }
        .detail-table td:first-child { color: #1976d2; font-weight: bold; width: 100px; }
        .back-link { display: block; text-align: center; margin-top: 24px; color: #1976d2; text-decoration: underline; }
        .back-link:hover { color: #1565c0; }
        .action-buttons { display: flex; gap: 10px; margin-top: 20px; }
        .btn { flex: 1; padding: 10px; border-radius: 4px; text-align: center; text-decoration: none; font-weight: bold; }
        .btn-primary { background-color: #1976d2; color: white; }
        .btn-primary:hover { background-color: #1565c0; }
        .btn-danger { background-color: #f44336; color: white; }
        .btn-danger:hover { background-color: #d32f2f; }
        .btn-secondary { background-color: #757575; color: white; }
        .btn-secondary:hover { background-color: #616161; }
        .related-section { margin-top: 30px; border-top: 1px solid #e0e0e0; padding-top: 20px; }
        .related-section h3 { color: #1976d2; margin-bottom: 15px; }
        .related-list { list-style: none; padding: 0; }
        .related-list li { padding: 8px 0; border-bottom: 1px dashed #e0e0e0; }
        .related-list li:last-child { border-bottom: none; }
        .related-list .status-0 { color: #ff9800; } /* 申请中 */
        .related-list .status-1 { color: #4caf50; } /* 已借出/已通过 */
        .related-list .status-2 { color: #2196f3; } /* 已归还/已拒绝 */
        .related-list .status-3 { color: #f44336; } /* 逾期 */
    </style>
</head>
<body>
<div class="view-card">
    <h2>档案详情</h2>
    <table class="detail-table">
        <tr><td>编号:</td><td>${document.code}</td></tr>
        <tr><td>标题:</td><td>${document.title}</td></tr>
        <tr><td>分类:</td><td>${document.categoryName}</td></tr>
        <tr><td>密级:</td><td>${document.secretLevelName}</td></tr>
        <tr><td>状态:</td><td>
            <c:choose>
                <c:when test="${document.status == 1}">正常</c:when>
                <c:when test="${document.status == 0}">回收站</c:when>
                <c:when test="${document.status == 2}">作废</c:when>
                <c:otherwise>未知</c:otherwise>
            </c:choose>
        </td></tr>
        <tr><td>页数:</td><td>${document.pageCount}</td></tr>
        <tr><td>大小:</td><td>${document.size} 字节</td></tr>
        <tr><td>所属人:</td><td>${document.ownerName}</td></tr>
        <tr><td>创建人:</td><td>${document.createUserName}</td></tr>
        <tr><td>创建时间:</td><td>${document.createTime}</td></tr>
        <tr><td>描述:</td><td>${document.description}</td></tr>
        <c:if test="${not empty document.fileUrl}">
            <tr><td>附件:</td><td>
                <a href="${pageContext.request.contextPath}/document/download?id=${document.id}" style="color:#1976d2;">下载附件</a>
            </td></tr>
            <tr><td>文件名:</td><td>${document.fileUrl.substring(document.fileUrl.lastIndexOf('/') + 1)}</td></tr>
        </c:if>
    </table>
    
    <!-- 操作按钮 -->
    <div class="action-buttons">
        <c:if test="${document.status == 1}">
            <a href="${pageContext.request.contextPath}/document/borrow?id=${document.id}" class="btn btn-primary">借阅申请</a>
            <a href="${pageContext.request.contextPath}/document/edit?id=${document.id}" class="btn btn-secondary">编辑</a>
            <a href="${pageContext.request.contextPath}/document/void?id=${document.id}" class="btn btn-danger">申请作废</a>
        </c:if>
        <c:if test="${document.status == 0}">
            <a href="${pageContext.request.contextPath}/document/restore?id=${document.id}" class="btn btn-primary">恢复</a>
            <a href="${pageContext.request.contextPath}/document/delete-permanently?id=${document.id}" class="btn btn-danger" onclick="return confirm('确定要永久删除此档案吗？此操作不可恢复！')">永久删除</a>
        </c:if>
    </div>
    
    <!-- 相关借阅记录 -->
    <c:if test="${not empty borrowRecords}">
        <div class="related-section">
            <h3>借阅记录</h3>
            <ul class="related-list">
                <c:forEach items="${borrowRecords}" var="borrow">
                    <li>
                        ${borrow.userName} - ${borrow.borrowTime}
                        <span class="status-${borrow.status}">
                            <c:choose>
                                <c:when test="${borrow.status == 0}">申请中</c:when>
                                <c:when test="${borrow.status == 1}">已借出</c:when>
                                <c:when test="${borrow.status == 2}">已归还</c:when>
                                <c:when test="${borrow.status == 3}">逾期</c:when>
                                <c:otherwise>未知</c:otherwise>
                            </c:choose>
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
    
    <!-- 相关审批记录 -->
    <c:if test="${not empty approveRecords}">
        <div class="related-section">
            <h3>审批记录</h3>
            <ul class="related-list">
                <c:forEach items="${approveRecords}" var="approve">
                    <li>
                        ${approve.type == 'borrow' ? '借阅审批' : '作废审批'} - ${approve.applyTime}
                        <span class="status-${approve.status}">
                            <c:choose>
                                <c:when test="${approve.status == 0}">待审批</c:when>
                                <c:when test="${approve.status == 1}">已通过</c:when>
                                <c:when test="${approve.status == 2}">已拒绝</c:when>
                                <c:otherwise>未知</c:otherwise>
                            </c:choose>
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
    
    <a href="${pageContext.request.contextPath}/document/list" class="back-link">返回列表</a>
</div>
</body>
</html>