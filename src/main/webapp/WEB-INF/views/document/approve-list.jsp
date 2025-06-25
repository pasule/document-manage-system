<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>审批记录列表</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .container { width: 90%; max-width: 1200px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; }
        .filter-section { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .filter-group { display: flex; align-items: center; }
        .filter-group label { margin-right: 10px; color: #1976d2; }
        .filter-control { padding: 8px; border: 1px solid #e0e0e0; border-radius: 4px; }
        .btn-filter { background: #1976d2; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; }
        .btn-filter:hover { background: #1565c0; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #e0e0e0; }
        th { background-color: #f5f5f5; color: #1976d2; font-weight: bold; }
        tr:hover { background-color: #f9f9f9; }
        .status-0 { color: #ff9800; } /* 待审批 */
        .status-1 { color: #4caf50; } /* 通过 */
        .status-2 { color: #f44336; } /* 拒绝 */
        .type-borrow { background-color: #e3f2fd; } /* 借阅审批 */
        .type-void { background-color: #fce4ec; } /* 作废审批 */
        .action-links { display: flex; gap: 10px; }
        .action-link { color: #1976d2; text-decoration: none; }
        .action-link:hover { text-decoration: underline; }
        .back-link { display: block; text-align: center; margin-top: 24px; color: #1976d2; text-decoration: underline; }
        .back-link:hover { color: #1565c0; }
        .pagination { display: flex; justify-content: center; margin-top: 20px; }
        .pagination a { padding: 8px 12px; margin: 0 5px; border: 1px solid #e0e0e0; text-decoration: none; color: #1976d2; }
        .pagination a.active { background-color: #1976d2; color: white; }
        .pagination a:hover:not(.active) { background-color: #f1f1f1; }
    </style>
</head>
<body>
<div class="container">
    <h2>审批记录列表</h2>
    
    <div class="filter-section">
        <div class="filter-group">
            <form action="${pageContext.request.contextPath}/document/approve-list" method="get">
                <label for="type">类型:</label>
                <select id="type" name="type" class="filter-control">
                    <option value="">全部</option>
                    <option value="borrow" ${param.type == 'borrow' ? 'selected' : ''}>借阅审批</option>
                    <option value="void" ${param.type == 'void' ? 'selected' : ''}>作废审批</option>
                </select>
                
                <label for="status" style="margin-left: 15px;">状态:</label>
                <select id="status" name="status" class="filter-control">
                    <option value="">全部</option>
                    <option value="0" ${param.status == '0' ? 'selected' : ''}>待审批</option>
                    <option value="1" ${param.status == '1' ? 'selected' : ''}>已通过</option>
                    <option value="2" ${param.status == '2' ? 'selected' : ''}>已拒绝</option>
                </select>
                
                <button type="submit" class="btn-filter">筛选</button>
            </form>
        </div>
        
        <div class="filter-group">
            <a href="${pageContext.request.contextPath}/document/approve-list?mine=true" class="btn-filter">我的申请</a>
            <a href="${pageContext.request.contextPath}/document/approve-list?pending=true" class="btn-filter" style="margin-left: 10px;">待我审批</a>
        </div>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>审批类型</th>
                <th>关联业务</th>
                <th>申请人</th>
                <th>审批人</th>
                <th>申请时间</th>
                <th>审批时间</th>
                <th>状态</th>
                <th>备注</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${approves}" var="approve">
                <tr class="type-${approve.type}">
                    <td>
                        <c:choose>
                            <c:when test="${approve.type == 'borrow'}">借阅审批</c:when>
                            <c:when test="${approve.type == 'void'}">作废审批</c:when>
                            <c:otherwise>${approve.type}</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${approve.refTitle}</td>
                    <td>${approve.applicantName}</td>
                    <td>${approve.approverName}</td>
                    <td>${approve.applyTime}</td>
                    <td>${approve.approveTime != null ? approve.approveTime : '-'}</td>
                    <td>
                        <span class="status-${approve.status}">
                            <c:choose>
                                <c:when test="${approve.status == 0}">待审批</c:when>
                                <c:when test="${approve.status == 1}">已通过</c:when>
                                <c:when test="${approve.status == 2}">已拒绝</c:when>
                                <c:otherwise>未知</c:otherwise>
                            </c:choose>
                        </span>
                    </td>
                    <td>${approve.remark != null ? approve.remark : '-'}</td>
                    <td class="action-links">
                        <c:choose>
                            <c:when test="${approve.type == 'borrow'}">
                                <a href="${pageContext.request.contextPath}/document/view-borrow?id=${approve.refId}" class="action-link">查看借阅</a>
                            </c:when>
                            <c:when test="${approve.type == 'void'}">
                                <a href="${pageContext.request.contextPath}/document/view?id=${approve.refId}" class="action-link">查看档案</a>
                            </c:when>
                        </c:choose>
                        
                        <c:if test="${approve.status == 0 && currentUserId == approve.approverId}">
                            <a href="${pageContext.request.contextPath}/document/process-approve?id=${approve.id}" class="action-link">处理</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            
            <c:if test="${empty approves}">
                <tr>
                    <td colspan="9" style="text-align: center; padding: 20px;">暂无审批记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    
    <!-- 分页 -->
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/document/approve-list?page=${currentPage - 1}&type=${param.type}&status=${param.status}&mine=${param.mine}&pending=${param.pending}">上一页</a>
        </c:if>
        
        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="${pageContext.request.contextPath}/document/approve-list?page=${i}&type=${param.type}&status=${param.status}&mine=${param.mine}&pending=${param.pending}" class="${currentPage == i ? 'active' : ''}">${i}</a>
        </c:forEach>
        
        <c:if test="${currentPage < totalPages}">
            <a href="${pageContext.request.contextPath}/document/approve-list?page=${currentPage + 1}&type=${param.type}&status=${param.status}&mine=${param.mine}&pending=${param.pending}">下一页</a>
        </c:if>
    </div>
    
    <a href="${pageContext.request.contextPath}/" class="back-link">返回首页</a>
</div>
</body>
</html> 