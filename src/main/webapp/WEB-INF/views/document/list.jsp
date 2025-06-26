<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>档案管理</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .container { width: 90%; margin: 30px auto; }
        .filter-section { display: flex; flex-wrap: wrap; gap: 15px; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px #e0e0e0; margin-bottom: 20px; }
        .filter-group { display: flex; align-items: center; }
        .filter-group label { margin-right: 10px; color: #1976d2; font-weight: bold; }
        .filter-control { padding: 8px; border: 1px solid #e0e0e0; border-radius: 4px; }
        .btn-filter { background: #1976d2; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; }
        .btn-filter:hover { background: #1565c0; }
        .btn-reset { background: #757575; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; margin-left: 10px; }
        .btn-reset:hover { background: #616161; }
        .btn-add { background: #4caf50; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn-add:hover { background: #388e3c; }
        .doc-table { width: 100%; border-collapse: collapse; background: #fff; box-shadow: 0 2px 8px #e0e0e0; border-radius: 8px; overflow: hidden; }
        .doc-table th, .doc-table td { padding: 14px 12px; text-align: center; }
        .doc-table th { background: #1976d2; color: #fff; font-size: 16px; }
        .doc-table tr:nth-child(even) { background: #f5faff; }
        .doc-table tr:hover { background: #e3f2fd; }
        .action-btn { background: #1976d2; color: #fff; border: none; border-radius: 4px; padding: 6px 16px; margin: 0 4px; cursor: pointer; transition: background 0.2s; text-decoration: none; display: inline-block; }
        .action-btn:hover { background: #1565c0; }
        .action-btn.delete { background: #e53935; }
        .action-btn.delete:hover { background: #c62828; }
        .action-btn.edit { background: #ff9800; }
        .action-btn.edit:hover { background: #f57c00; }
        .tag-list { display: flex; flex-wrap: wrap; gap: 5px; }
        .tag { padding: 2px 8px; border-radius: 12px; font-size: 12px; color: white; background: #2196f3; }
        .pagination { display: flex; justify-content: center; margin-top: 20px; }
        .pagination a { padding: 8px 12px; margin: 0 5px; border: 1px solid #e0e0e0; text-decoration: none; color: #1976d2; }
        .pagination a.active { background-color: #1976d2; color: white; }
        .pagination a:hover:not(.active) { background-color: #f1f1f1; }
        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .status-badge { display: inline-block; padding: 3px 8px; border-radius: 12px; font-size: 12px; }
        .status-1 { background: #4caf50; color: white; } /* 正常 */
        .status-0 { background: #ff9800; color: white; } /* 回收站 */
        .status-2 { background: #f44336; color: white; } /* 作废 */
    </style>
</head>
<body>
<div class="container">
    <div class="header-actions">
        <h2 style="color:#1976d2; margin:0;">档案管理</h2>
        <div>
            <a href="${pageContext.request.contextPath}/document/upload" class="btn-add">上传新档案</a>
        </div>
    </div>
    
    <c:if test="${not empty param.error}">
        <div style="background-color: #ffebee; border: 1px solid #ef9a9a; color: #c62828; padding: 10px; margin-bottom: 20px; border-radius: 4px;">
            ${param.error}
        </div>
    </c:if>
    
    <div class="filter-section">
        <form action="${pageContext.request.contextPath}/document/list" method="get" style="width: 100%;">
            <div style="display: flex; flex-wrap: wrap; gap: 15px; margin-bottom: 15px;">
                <div class="filter-group">
                    <label for="title">标题:</label>
                    <input type="text" id="title" name="title" value="${param.title}" class="filter-control">
                </div>
                
                <div class="filter-group">
                    <label for="categoryId">分类:</label>
                    <select id="categoryId" name="categoryId" class="filter-control">
                        <option value="">全部</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="secretLevelId">密级:</label>
                    <select id="secretLevelId" name="secretLevelId" class="filter-control">
                        <option value="">全部</option>
                        <c:forEach items="${secretLevels}" var="level">
                            <option value="${level.id}" ${param.secretLevelId == level.id ? 'selected' : ''}>${level.name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="tagId">标签:</label>
                    <select id="tagId" name="tagId" class="filter-control">
                        <option value="">全部</option>
                        <c:forEach items="${tags}" var="tag">
                            <option value="${tag.id}" ${param.tagId == tag.id ? 'selected' : ''}>${tag.name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="status">状态:</label>
                    <select id="status" name="status" class="filter-control">
                        <option value="1" ${empty param.status || param.status == '1' ? 'selected' : ''}>正常</option>
                        <option value="0" ${param.status == '0' ? 'selected' : ''}>回收站</option>
                        <option value="2" ${param.status == '2' ? 'selected' : ''}>作废</option>
                        <option value="-1" ${param.status == '-1' ? 'selected' : ''}>全部</option>
                    </select>
                </div>
            </div>
            
            <div style="display: flex; justify-content: flex-end;">
                <button type="submit" class="btn-filter">筛选</button>
                <a href="${pageContext.request.contextPath}/document/list" class="btn-reset">重置</a>
            </div>
        </form>
    </div>
    
    <table class="doc-table">
        <tr>
            <th>编号</th>
            <th>标题</th>
            <th>分类</th>
            <th>密级</th>
            <th>标签</th>
            <th>状态</th>
            <th>创建时间</th>
            <th>操作</th>
        </tr>
        <c:forEach var="doc" items="${docs}">
            <tr>
                <td>${doc.code}</td>
                <td>${doc.title}</td>
                <td>${doc.categoryName}</td>
                <td>${doc.secretLevelName}</td>
                <td>
                    <div class="tag-list">
                        <span class="tag" style="background-color: #888888">暂无标签</span>
                    </div>
                </td>
                <td>
                    <span class="status-badge status-${doc.status}">
                        <c:choose>
                            <c:when test="${doc.status == 1}">正常</c:when>
                            <c:when test="${doc.status == 0}">回收站</c:when>
                            <c:when test="${doc.status == 2}">作废</c:when>
                            <c:otherwise>未知</c:otherwise>
                        </c:choose>
                    </span>
                </td>
                <td>${doc.createTime}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/document/view?id=${doc.id}" class="action-btn">查看</a>
                    
                    <c:if test="${doc.status == 1}">
                        <a href="${pageContext.request.contextPath}/document/edit?id=${doc.id}" class="action-btn edit">编辑</a>
                        <a href="${pageContext.request.contextPath}/document/delete?id=${doc.id}" onclick="return confirm('确定要将此档案移入回收站吗？')" class="action-btn delete">删除</a>
                    </c:if>
                    
                    <c:if test="${doc.status == 0}">
                        <a href="${pageContext.request.contextPath}/document/restore?id=${doc.id}" class="action-btn">恢复</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        
        <c:if test="${empty docs}">
            <tr>
                <td colspan="8" style="text-align: center; padding: 20px;">暂无档案</td>
            </tr>
        </c:if>
    </table>
    
    <!-- 分页 -->
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/document/list?page=${currentPage - 1}&title=${param.title}&categoryId=${param.categoryId}&secretLevelId=${param.secretLevelId}&tagId=${param.tagId}&status=${param.status}">上一页</a>
        </c:if>
        
        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="${pageContext.request.contextPath}/document/list?page=${i}&title=${param.title}&categoryId=${param.categoryId}&secretLevelId=${param.secretLevelId}&tagId=${param.tagId}&status=${param.status}" class="${currentPage == i ? 'active' : ''}">${i}</a>
        </c:forEach>
        
        <c:if test="${currentPage < totalPages}">
            <a href="${pageContext.request.contextPath}/document/list?page=${currentPage + 1}&title=${param.title}&categoryId=${param.categoryId}&secretLevelId=${param.secretLevelId}&tagId=${param.tagId}&status=${param.status}">下一页</a>
        </c:if>
    </div>
</div>
</body>
</html>