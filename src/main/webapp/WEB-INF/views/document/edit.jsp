<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>编辑档案</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .edit-card { width: 480px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 8px; color: #1976d2; font-weight: bold; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #e0e0e0; border-radius: 4px; box-sizing: border-box; }
        .form-control:focus { border-color: #1976d2; outline: none; }
        textarea.form-control { min-height: 100px; }
        .btn-submit { width: 100%; background: #1976d2; color: white; border: none; padding: 12px; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn-submit:hover { background: #1565c0; }
        .error-message { color: #d32f2f; margin-top: 20px; text-align: center; }
        .back-link { display: block; text-align: center; margin-top: 24px; color: #1976d2; text-decoration: underline; }
        .back-link:hover { color: #1565c0; }
    </style>
</head>
<body>
<div class="edit-card">
    <h2>编辑档案</h2>
    
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/document/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${document.id}">
        
        <div class="form-group">
            <label>档案编号:</label>
            <input type="text" class="form-control" value="${document.code}" readonly>
        </div>
        
        <div class="form-group">
            <label>档案标题: <span style="color: #f44336;">*</span></label>
            <input type="text" name="title" class="form-control" value="${document.title}" required>
        </div>
        
        <div class="form-group">
            <label>分类:</label>
            <select name="categoryId" class="form-control">
                <option value="">-- 选择分类 --</option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.id}" ${document.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="form-group">
            <label>密级:</label>
            <select name="secretLevelId" class="form-control">
                <option value="">-- 选择密级 --</option>
                <c:forEach items="${secretLevels}" var="level">
                    <option value="${level.id}" ${document.secretLevelId == level.id ? 'selected' : ''}>${level.name}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="form-group">
            <label>页数:</label>
            <input type="number" name="pageCount" class="form-control" value="${document.pageCount}" min="0">
        </div>
        
        <div class="form-group">
            <label>描述:</label>
            <textarea name="description" class="form-control">${document.description}</textarea>
        </div>
        
        <div class="form-group">
            <label>更新附件:</label>
            <input type="file" name="file" class="form-control">
            <small style="color: #757575; display: block; margin-top: 5px;">当前文件: ${document.fileUrl != null ? document.fileUrl.substring(document.fileUrl.lastIndexOf('/') + 1) : '无'}</small>
        </div>
        
        <button type="submit" class="btn-submit">保存修改</button>
    </form>
    
    <a href="${pageContext.request.contextPath}/document/view?id=${document.id}" class="back-link">返回档案详情</a>
</div>
</body>
</html> 