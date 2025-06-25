<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>上传档案</title>
    <style>
        body { background: #f4f4f4; font-family: Arial, sans-serif; }
        .upload-card { width: 600px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #90caf9; padding: 32px 36px; }
        h2 { text-align: center; color: #1976d2; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: bold; color: #1976d2; }
        .form-group input[type="text"], 
        .form-group input[type="file"],
        .form-group select,
        .form-group textarea { 
            width: 100%; 
            padding: 8px; 
            border: 1px solid #bdbdbd; 
            border-radius: 4px; 
            box-sizing: border-box; 
        }
        .form-group textarea { 
            height: 100px; 
            resize: vertical; 
        }
        .form-group input[type="submit"] { 
            width: 100%; 
            background: #1976d2; 
            color: #fff; 
            border: none; 
            border-radius: 4px; 
            padding: 12px; 
            font-size: 16px; 
            cursor: pointer; 
            transition: background 0.2s; 
        }
        .form-group input[type="submit"]:hover { 
            background: #1565c0; 
        }
        .tag-container { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 10px; 
            margin-top: 10px; 
        }
        .tag-option {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 15px;
            color: white;
            cursor: pointer;
        }
        .tag-option input[type="checkbox"] {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<c:if test="${not empty error}">
    <div style="color:red;text-align:center;margin-bottom:10px;">${error}</div>
</c:if>
<div class="upload-card">
    <h2>上传档案</h2>
    <form action="${pageContext.request.contextPath}/document/upload" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>标题:</label>
            <input type="text" name="title" required>
        </div>
        
        <div class="form-group">
            <label>分类:</label>
            <select name="categoryId" required>
                <option value="">请选择分类</option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.id}">${category.name}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="form-group">
            <label>密级:</label>
            <select name="secretLevelId" required>
                <option value="">请选择密级</option>
                <c:forEach items="${secretLevels}" var="level">
                    <option value="${level.id}">${level.name}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="form-group">
            <label>标签:</label>
            <div class="tag-container">
                <c:forEach items="${tags}" var="tag">
                    <label class="tag-option" style="background-color: ${tag.color}">
                        <input type="checkbox" name="tagIds" value="${tag.id}"> ${tag.name}
                    </label>
                </c:forEach>
            </div>
        </div>
        
        <div class="form-group">
            <label>档案描述:</label>
            <textarea name="description" placeholder="请输入档案描述信息"></textarea>
        </div>
        
        <div class="form-group">
            <label>文件:</label>
            <input type="file" name="file" required>
        </div>
        
        <div class="form-group">
            <input type="submit" value="上传">
        </div>
    </form>
</div>
</body>
</html>