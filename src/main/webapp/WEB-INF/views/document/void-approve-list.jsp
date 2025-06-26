<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>待处理作废审批</title>
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
        .status-badge { display: inline-block; padding: 5px 10px; border-radius: 4px; color: white; font-size: 12px; font-weight: bold; }
        .status-pending { background-color: #ff9800; } /* 待审批 */
        .status-approved { background-color: #4caf50; } /* 通过 */
        .status-rejected { background-color: #f44336; } /* 拒绝 */
        .btn { display: inline-block; padding: 6px 12px; margin-bottom: 0; font-size: 14px; font-weight: 400; text-align: center; white-space: nowrap; vertical-align: middle; cursor: pointer; border: 1px solid transparent; border-radius: 4px; color: #fff; text-decoration: none; }
        .btn-primary { background-color: #1976d2; }
        .btn-primary:hover { background-color: #1565c0; }
        .btn-warning { background-color: #ff9800; }
        .btn-warning:hover { background-color: #f57c00; }
        .btn-success { background-color: #4caf50; }
        .btn-success:hover { background-color: #388e3c; }
        .btn-danger { background-color: #f44336; }
        .btn-danger:hover { background-color: #d32f2f; }
        .action-links { display: flex; gap: 5px; flex-wrap: wrap; }
        .pagination { display: flex; justify-content: center; margin-top: 20px; }
        .pagination a { padding: 8px 12px; margin: 0 5px; border: 1px solid #e0e0e0; text-decoration: none; color: #1976d2; }
        .pagination a.active { background-color: #1976d2; color: white; }
        .pagination a:hover:not(.active) { background-color: #f1f1f1; }
        .empty-message { text-align: center; padding: 30px; color: #757575; font-style: italic; }
        .approve-form { display: inline; }
        .approve-form button { margin: 0 2px; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 50%; border-radius: 5px; }
        .modal-header { display: flex; justify-content: space-between; align-items: center; }
        .modal-header h3 { margin: 0; color: #1976d2; }
        .close { color: #aaa; font-size: 28px; font-weight: bold; cursor: pointer; }
        .close:hover { color: black; }
        .modal-body { padding: 10px 0; }
        .modal-footer { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
    </style>
    <script>
        function showApproveModal(id, action) {
            document.getElementById('approveId').value = id;
            document.getElementById('approveAction').value = action;
            document.getElementById('modalTitle').innerText = action === 'approve' ? '批准作废申请' : '拒绝作废申请';
            document.getElementById('approveModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('approveModal').style.display = 'none';
        }
        
        window.onclick = function(event) {
            var modal = document.getElementById('approveModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>待处理作废审批</h2>
    
    <table>
        <thead>
            <tr>
                <th>档案编号</th>
                <th>档案标题</th>
                <th>申请人</th>
                <th>申请时间</th>
                <th>作废原因</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${voidApproves}" var="approve">
                <tr>
                    <td>${approve.document_code}</td>
                    <td>${approve.ref_title}</td>
                    <td>${approve.applicant_name}</td>
                    <td>${approve.apply_time}</td>
                    <td>${approve.remark}</td>
                    <td>
                        <span class="status-badge status-pending">${approve.status_text}</span>
                    </td>
                    <td class="action-links">
                        <a href="${pageContext.request.contextPath}/document/view-void?id=${approve.id}" class="btn btn-primary">查看</a>
                        <button class="btn btn-success" onclick="showApproveModal('${approve.id}', 'approve')">通过</button>
                        <button class="btn btn-danger" onclick="showApproveModal('${approve.id}', 'reject')">拒绝</button>
                    </td>
                </tr>
            </c:forEach>
            
            <c:if test="${empty voidApproves}">
                <tr>
                    <td colspan="7" class="empty-message">暂无待处理的作废审批</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    
    <!-- 分页 -->
    <c:if test="${not empty voidApproves}">
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/document/void-approve-list?page=${currentPage - 1}">上一页</a>
            </c:if>
            
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="${pageContext.request.contextPath}/document/void-approve-list?page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
            </c:forEach>
            
            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/document/void-approve-list?page=${currentPage + 1}">下一页</a>
            </c:if>
        </div>
    </c:if>
    
    <div style="margin-top: 20px; display: flex; justify-content: center; gap: 15px;">
        <a href="${pageContext.request.contextPath}/document/approve-list" class="btn btn-primary">返回审批列表</a>
        <a href="${pageContext.request.contextPath}/" class="btn" style="background-color: #757575;">返回首页</a>
    </div>
    
    <!-- 审批确认模态框 -->
    <div id="approveModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">审批确认</h3>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/document/approve-void" method="post">
                    <input type="hidden" id="approveId" name="approveId">
                    <input type="hidden" id="approveAction" name="action">
                    
                    <div style="margin-bottom: 15px;">
                        <label for="approveRemark" style="display: block; margin-bottom: 5px; font-weight: bold;">审批意见:</label>
                        <textarea id="approveRemark" name="approveRemark" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; min-height: 100px;" required placeholder="请输入您的审批意见..."></textarea>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn" style="background-color: #757575;" onclick="closeModal()">取消</button>
                        <button type="submit" class="btn btn-primary">确认</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html> 