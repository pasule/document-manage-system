<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>作废详情</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .container { width: 90%; max-width: 800px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; }
        .info-section { margin-bottom: 30px; }
        .info-title { color: #1976d2; font-weight: bold; margin-bottom: 15px; font-size: 18px; }
        .info-row { display: flex; margin-bottom: 10px; border-bottom: 1px solid #e0e0e0; padding-bottom: 10px; }
        .info-label { width: 35%; font-weight: bold; color: #555; }
        .info-value { width: 65%; }
        .status-badge { display: inline-block; padding: 5px 10px; border-radius: 4px; color: white; font-size: 14px; font-weight: bold; }
        .status-0 { background-color: #ff9800; } /* 待审批 */
        .status-1 { background-color: #4caf50; } /* 通过 */
        .status-2 { background-color: #f44336; } /* 拒绝 */
        .action-buttons { display: flex; justify-content: center; gap: 15px; margin-top: 30px; }
        .btn { padding: 10px 20px; border-radius: 5px; text-decoration: none; color: white; font-weight: bold; cursor: pointer; border: none; }
        .btn-primary { background-color: #1976d2; }
        .btn-primary:hover { background-color: #1565c0; }
        .btn-secondary { background-color: #757575; }
        .btn-secondary:hover { background-color: #616161; }
        .btn-success { background-color: #4caf50; }
        .btn-success:hover { background-color: #388e3c; }
        .btn-warning { background-color: #ff9800; }
        .btn-warning:hover { background-color: #f57c00; }
        .debug-info { background-color: #f5f5f5; padding: 10px; margin-top: 20px; border: 1px solid #ddd; font-family: monospace; font-size: 12px; display: none; }
        .status-summary { text-align: center; margin-bottom: 20px; }
        .status-summary .status-badge { font-size: 16px; padding: 8px 16px; }
    </style>
</head>
<body>
<div class="container">
    <h2>作废详情</h2>
    
    <!-- 状态摘要 -->
    <div class="status-summary">
        <span class="status-badge status-${approve.status}">
            <c:choose>
                <c:when test="${approve.status == 0}">待审批</c:when>
                <c:when test="${approve.status == 1}">已通过</c:when>
                <c:when test="${approve.status == 2}">已拒绝</c:when>
                <c:otherwise>未知状态</c:otherwise>
            </c:choose>
        </span>
    </div>
    
    <!-- 调试信息 -->
    <div class="debug-info">
        <p>请求参数: ${param.id}</p>
        <p>审批ID: ${approve.id}</p>
        <p>审批类型: ${approve.type}</p>
        <p>档案ID: ${document.id}</p>
    </div>
    
    <!-- 档案信息 -->
    <div class="info-section">
        <div class="info-title">档案信息</div>
        <div class="info-row">
            <div class="info-label">档案编号:</div>
            <div class="info-value">${document.code}</div>
        </div>
        <div class="info-row">
            <div class="info-label">档案标题:</div>
            <div class="info-value">${document.title}</div>
        </div>
        <div class="info-row">
            <div class="info-label">档案状态:</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${document.status == 0}"><span class="status-badge" style="background-color: #9e9e9e;">回收站</span></c:when>
                    <c:when test="${document.status == 1}"><span class="status-badge" style="background-color: #4caf50;">正常</span></c:when>
                    <c:when test="${document.status == 2}"><span class="status-badge" style="background-color: #f44336;">已作废</span></c:when>
                    <c:otherwise><span class="status-badge" style="background-color: #9e9e9e;">未知</span></c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="info-row">
            <div class="info-label">创建时间:</div>
            <div class="info-value">${document.createTime}</div>
        </div>
    </div>
    
    <!-- 作废申请信息 -->
    <div class="info-section">
        <div class="info-title">作废申请信息</div>
        <div class="info-row">
            <div class="info-label">申请人:</div>
            <div class="info-value">${approve.applicantName}</div>
        </div>
        <div class="info-row">
            <div class="info-label">申请时间:</div>
            <div class="info-value">${approve.applyTime}</div>
        </div>
        <div class="info-row">
            <div class="info-label">审批人:</div>
            <div class="info-value">${approve.approverName}</div>
        </div>
        <div class="info-row">
            <div class="info-label">审批状态:</div>
            <div class="info-value">
                <span class="status-badge status-${approve.status}">
                    <c:choose>
                        <c:when test="${approve.status == 0}">待审批</c:when>
                        <c:when test="${approve.status == 1}">已通过</c:when>
                        <c:when test="${approve.status == 2}">已拒绝</c:when>
                        <c:otherwise>未知</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
        <div class="info-row">
            <div class="info-label">作废原因:</div>
            <div class="info-value">${approve.remark}</div>
        </div>
        <c:if test="${approve.approveTime != null}">
            <div class="info-row">
                <div class="info-label">审批时间:</div>
                <div class="info-value">${approve.approveTime}</div>
            </div>
        </c:if>
    </div>
    
    <!-- 操作按钮 -->
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/document/view?id=${document.id}" class="btn btn-primary">查看档案详情</a>
        
        <!-- 如果是待审批状态且当前用户是审批人，显示审批按钮 -->
        <c:if test="${approve.status == 0 && sessionScope.userId == approve.approverId}">
            <a href="${pageContext.request.contextPath}/document/approve-void?id=${approve.id}" class="btn btn-warning">审批作废</a>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/document/void-approve-list" class="btn btn-secondary">返回作废审批列表</a>
        <a href="${pageContext.request.contextPath}/document/approve-list" class="btn btn-secondary">返回审批列表</a>
    </div>
</div>
</body>
</html> 