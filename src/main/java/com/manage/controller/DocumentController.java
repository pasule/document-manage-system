package com.manage.controller;

import com.manage.entity.Document;
import com.manage.entity.User;
import com.manage.entity.Borrow;
import com.manage.entity.Approve;
import com.manage.entity.Tag;
import com.manage.service.DocumentService;
import com.manage.service.UserService;
import com.manage.service.CategoryService;
import com.manage.service.TagService;
import com.manage.service.BorrowService;
import com.manage.service.ApproveService;
import jakarta.servlet.annotation.MultipartConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.StringUtils;
import java.io.File;
import java.io.IOException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import jakarta.servlet.ServletOutputStream;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

@Controller
@RequestMapping("/document")
public class DocumentController {
    @Autowired
    private DocumentService documentService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private TagService tagService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private BorrowService borrowService;

    @Autowired
    private ApproveService approveService;

    private static final String UPLOAD_DIR = "uploads";

    // 修改为webapp下的uploads目录，使用正确的路径分隔符
    private static final String FIXED_UPLOAD_PATH = "F:" + File.separator + "code" + File.separator + "JavaEE_Homework" + File.separator + "document-manage-system" + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "uploads";

    @GetMapping("/list")
    public String list(
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "categoryId", required = false) Long categoryId,
            @RequestParam(value = "secretLevelId", required = false) Long secretLevelId,
            @RequestParam(value = "tagId", required = false) Long tagId,
            @RequestParam(value = "status", required = false) String statusParam,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            Model model) {
        
        // 处理状态参数
        Integer status = null;
        if (statusParam != null) {
            if (statusParam.equals("-1")) {
                // 全部状态
                status = null;
            } else {
                try {
                    status = Integer.parseInt(statusParam);
                } catch (NumberFormatException e) {
                    // 默认为正常状态
                    status = 1;
                }
            }
        } else {
            // 默认为正常状态
            status = 1;
        }
        
        // 获取筛选后的档案列表
        List<Document> docs = documentService.getDocumentsByFilter(title, categoryId, secretLevelId, tagId, status);
        
        // 加载分类列表、密级列表和标签列表供筛选使用
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("secretLevels", categoryService.getAllSecretLevels());
        model.addAttribute("tags", tagService.getAllTags());
        
        // 分页处理（简单实现，实际项目可能需要更复杂的分页）
        int total = docs.size();
        int totalPages = (int) Math.ceil((double) total / pageSize);
        
        // 确保页码在有效范围内
        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;
        
        // 计算当前页的数据
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, total);
        
        List<Document> pagedDocs = fromIndex < toIndex ? docs.subList(fromIndex, toIndex) : new ArrayList<>();
        
        // 设置模型属性
        model.addAttribute("docs", pagedDocs);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        
        return "document/list";
    }

    @GetMapping("/my")
    public String myDocs(Model model, HttpSession session) {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            // 未登录，跳转到登录页
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        List<Document> docs = documentService.getDocumentsByUser(userId);
        model.addAttribute("docs", docs);
        return "document/my";
    }

    @GetMapping("/secret")
    public String secretDocs(Model model, @RequestParam("secretLevelId") Long secretLevelId) {
        List<Document> docs = documentService.getDocumentsBySecretLevel(secretLevelId);
        model.addAttribute("docs", docs);
        return "document/secret";
    }

    @GetMapping("/recycle")
    public String recycleBin(Model model) {
        List<Document> docs = documentService.getRecycleBin();
        model.addAttribute("docs", docs);
        return "document/recycle";
    }

    @GetMapping("/upload")
    public String uploadPage(Model model) {
        // 加载分类列表
        List<Map<String, Object>> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        
        // 加载密级列表
        List<Map<String, Object>> secretLevels = categoryService.getAllSecretLevels();
        model.addAttribute("secretLevels", secretLevels);
        
        // 加载标签列表
        List<Tag> tags = tagService.getAllTags();
        model.addAttribute("tags", tags);
        
        return "document/upload";
    }

    @PostMapping("/upload")
    public String upload(@ModelAttribute Document document,
                         @RequestParam("file") MultipartFile file,
                         @RequestParam(value = "tagIds", required = false) List<Long> tagIds,
                         HttpSession session,
                         Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            model.addAttribute("error", "请先登录！");
            return "login";
        }
        Long userId = (Long) userIdObj;

        // 必填校验
        if (document.getTitle() == null || document.getTitle().trim().isEmpty()) {
            model.addAttribute("error", "标题不能为空！");
            return "document/upload";
        }

        // 文件校验
        if (file == null || file.isEmpty()) {
            model.addAttribute("error", "请上传文件！");
            return "document/upload";
        }

        try {
            // 1. 设置文档基本信息
            document.setCode(java.util.UUID.randomUUID().toString().replace("-", ""));
            document.setCreateUser(userId);
            document.setOwnerId(userId);
            document.setCreateTime(java.time.LocalDateTime.now());
            document.setStatus(1);
            document.setSize(file.getSize());

            // 获取所有可能的目录路径
            String realPath = session.getServletContext().getRealPath("/");
            String userDir = System.getProperty("user.dir");

            System.out.println("[DEBUG] 应用根目录: " + realPath);
            System.out.println("[DEBUG] 工作目录: " + userDir);

            // 生成唯一文件名
            String originalFilename = org.springframework.util.StringUtils.cleanPath(file.getOriginalFilename());
            String newFilename = System.currentTimeMillis() + "_" + originalFilename;

            // 2. 尝试在多个位置保存文件
            boolean saveSuccess = false;
            byte[] fileBytes = file.getBytes(); // 获取文件字节，避免多次读取

            // 位置1: 固定路径
            File uploadDir1 = new File(FIXED_UPLOAD_PATH);
            if (!uploadDir1.exists()) {
                boolean created = uploadDir1.mkdirs();
                System.out.println("[DEBUG] 创建固定上传目录: " + uploadDir1.getAbsolutePath() + ", 成功: " + created);
            }

            File destFile1 = new File(uploadDir1, newFilename);
            try {
                Files.write(destFile1.toPath(), fileBytes);
                saveSuccess = true;
                System.out.println("[DEBUG] 文件已保存到固定路径: " + destFile1.getAbsolutePath());
                System.out.println("[DEBUG] 文件存在: " + destFile1.exists() + ", 大小: " + destFile1.length());
            } catch (Exception e) {
                System.out.println("[ERROR] 保存到固定路径失败: " + e.getMessage());
            }

            // 位置2: webapp/uploads
            File uploadDir2 = new File(realPath + "uploads");
            if (!uploadDir2.exists()) {
                boolean created = uploadDir2.mkdirs();
                System.out.println("[DEBUG] 创建webapp上传目录: " + uploadDir2.getAbsolutePath() + ", 成功: " + created);
            }

            File destFile2 = new File(uploadDir2, newFilename);
            try {
                Files.write(destFile2.toPath(), fileBytes);
                System.out.println("[DEBUG] 文件已保存到webapp路径: " + destFile2.getAbsolutePath());
                System.out.println("[DEBUG] 文件存在: " + destFile2.exists() + ", 大小: " + destFile2.length());
                if (!saveSuccess) {
                    saveSuccess = true;
                }
            } catch (Exception e) {
                System.out.println("[ERROR] 保存到webapp路径失败: " + e.getMessage());
            }

            // 位置3: 工作目录/uploads
            File uploadDir3 = new File(userDir, "uploads");
            if (!uploadDir3.exists()) {
                boolean created = uploadDir3.mkdirs();
                System.out.println("[DEBUG] 创建工作目录上传目录: " + uploadDir3.getAbsolutePath() + ", 成功: " + created);
            }

            File destFile3 = new File(uploadDir3, newFilename);
            try {
                Files.write(destFile3.toPath(), fileBytes);
                System.out.println("[DEBUG] 文件已保存到工作目录路径: " + destFile3.getAbsolutePath());
                System.out.println("[DEBUG] 文件存在: " + destFile3.exists() + ", 大小: " + destFile3.length());
                if (!saveSuccess) {
                    saveSuccess = true;
                }
            } catch (Exception e) {
                System.out.println("[ERROR] 保存到工作目录路径失败: " + e.getMessage());
            }

            // 设置文件URL - 使用相对路径，方便前端访问
            document.setFileUrl("/uploads/" + newFilename);
            System.out.println("[DEBUG] 文件URL设置为: " + document.getFileUrl());

            // 3. 保存文档信息到数据库
            Long documentId = documentService.addDocument(document);

            // 4. 处理标签关联（这里假设有一个方法可以保存文档和标签的关联关系）
            if (tagIds != null && !tagIds.isEmpty()) {
                // 这里可以添加保存文档标签关联的代码
                // tagService.saveDocumentTags(documentId, tagIds);
                System.out.println("[DEBUG] 文档标签: " + tagIds);
            }

            if (!saveSuccess) {
                model.addAttribute("error", "文件保存失败，但数据库记录已创建。请重试或联系管理员。");
                return "document/upload";
            }

            return "redirect:/document/list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "文件上传失败: " + e.getMessage());
            return "document/upload";
        }
    }

    @GetMapping("/view")
    public String viewDocument(@RequestParam(value = "id", required = false) Long id, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        
        // 检查ID参数
        if (id == null) {
            model.addAttribute("error", "档案ID不能为空");
            return "redirect:/document/list?error=档案ID不能为空";
        }
        
        Document document = documentService.getDocumentById(id);
        if (document == null) {
            model.addAttribute("error", "档案不存在");
            return "redirect:/document/list?error=档案不存在或已被删除";
        }
        
        // 获取相关借阅记录
        List<Map<String, Object>> borrowRecords = borrowService.getBorrowsByDocumentId(id);
        model.addAttribute("borrowRecords", borrowRecords);
        
        // 获取相关审批记录
        List<Map<String, Object>> approveRecords = approveService.getApprovesByDocumentId(id);
        model.addAttribute("approveRecords", approveRecords);
        
        model.addAttribute("document", document);
        return "document/view";
    }

    @GetMapping("/delete")
    public String deleteDocument(@RequestParam("id") Long id) {
        // 将档案状态更改为"回收站"(0)而不是真正删除
        documentService.moveToRecycleBin(id);
        return "redirect:/document/list";
    }

    @GetMapping("/restore")
    public String restoreDocument(@RequestParam("id") Long id) {
        // 将档案从回收站恢复为正常状态(1)
        documentService.restoreFromRecycleBin(id);
        return "redirect:/document/recycle";
    }

    @GetMapping("/permanent-delete")
    public String permanentDeleteDocument(@RequestParam("id") Long id) {
        // 永久删除档案
        documentService.deleteDocument(id);
        return "redirect:/document/recycle";
    }

    @GetMapping("/file/{filename:.+}")
    public ResponseEntity<byte[]> serveFile(@PathVariable String filename, HttpSession session) {
        try {
            // 从会话中获取文件的实际物理路径
            String filePath = (String) session.getAttribute("file_" + filename);

            // 如果会话中没有找到路径，尝试从用户主目录下查找
            if (filePath == null) {
                String userHome = System.getProperty("user.home");
                String uploadDir = userHome + File.separator + "document_uploads";
                filePath = uploadDir + File.separator + filename;
            }

            System.out.println("[DEBUG] 访问文件: " + filePath);

            File file = new File(filePath);
            if (!file.exists() || !file.canRead()) {
                System.out.println("[ERROR] 文件不存在或无法读取: " + filePath);
                return ResponseEntity.notFound().build();
            }

            // 读取文件内容
            byte[] data = Files.readAllBytes(file.toPath());

            // 设置响应头
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", filename);

            // 返回文件
            return ResponseEntity.ok().headers(headers).body(data);
        } catch (Exception e) {
            System.out.println("[ERROR] 访问文件时出错: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/download")
    public ResponseEntity<byte[]> download(@RequestParam("id") Long id,
                                           HttpSession session) {
        try {
            Document document = documentService.getDocumentById(id);
            if (document == null || document.getFileUrl() == null) {
                System.out.println("[ERROR] 文档不存在或文件URL为空");
                return ResponseEntity.notFound().build();
            }

            // 获取文件URL
            String fileUrl = document.getFileUrl();
            System.out.println("[DEBUG] 文件URL: " + fileUrl);

            // 从URL提取文件名
            String fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
            System.out.println("[DEBUG] 文件名: " + fileName);

            // 优先使用固定路径
            File file = new File(FIXED_UPLOAD_PATH, fileName);
            System.out.println("[DEBUG] 尝试从固定路径获取文件: " + file.getAbsolutePath());

            if (!file.exists() || !file.canRead()) {
                System.out.println("[WARN] 固定路径文件不存在或不可读，尝试使用直接控制器方法");
                return downloadDirectController(fileName, session);
            }

            // 读取文件内容
            byte[] data = Files.readAllBytes(file.toPath());
            System.out.println("[DEBUG] 读取文件成功, 大小: " + data.length + " 字节");

            // 设置响应头
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", fileName);

            // 返回文件数据
            return ResponseEntity.ok()
                    .headers(headers)
                    .contentLength(file.length())
                    .body(data);

        } catch (Exception e) {
            System.out.println("[ERROR] 下载文件出错: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/download-direct-controller")
    public ResponseEntity<byte[]> downloadDirectController(@RequestParam("filename") String fileName,
                                                           HttpSession session) {
        try {
            if (fileName == null || fileName.trim().isEmpty()) {
                System.out.println("[ERROR] 文件名为空");
                return ResponseEntity.badRequest().build();
            }

            System.out.println("[DEBUG] 直接通过控制器下载文件: " + fileName);

            // 尝试不同的文件位置
            File file = null;
            List<String> possibleLocations = new ArrayList<>();

            // 位置1: 固定路径
            possibleLocations.add(FIXED_UPLOAD_PATH + File.separator + fileName);

            // 位置2: webapp路径
            String realPath = session.getServletContext().getRealPath("/");
            possibleLocations.add(realPath + "uploads" + File.separator + fileName);

            // 位置3: 工作目录
            String userDir = System.getProperty("user.dir");
            possibleLocations.add(userDir + File.separator + "uploads" + File.separator + fileName);

            // 位置4: 工作目录下的target
            possibleLocations.add(userDir + File.separator + "target" + File.separator + "uploads" + File.separator + fileName);

            // 检查每个位置
            for (String location : possibleLocations) {
                File tempFile = new File(location);
                System.out.println("[DEBUG] 检查位置: " + tempFile.getAbsolutePath() + ", 存在: " + tempFile.exists());
                if (tempFile.exists() && tempFile.canRead()) {
                    file = tempFile;
                    System.out.println("[DEBUG] 找到可用文件: " + file.getAbsolutePath());
                    break;
                }
            }

            if (file == null || !file.exists() || !file.canRead()) {
                // 尝试创建测试文件
                File testFile = new File(FIXED_UPLOAD_PATH, "test-fallback-" + System.currentTimeMillis() + ".txt");
                try {
                    Files.write(testFile.toPath(), "这是一个测试文件，原始文件未找到".getBytes());
                    System.out.println("[DEBUG] 创建测试文件: " + testFile.getAbsolutePath());

                    // 返回测试文件
                    byte[] testData = Files.readAllBytes(testFile.toPath());
                    HttpHeaders testHeaders = new HttpHeaders();
                    testHeaders.setContentType(MediaType.TEXT_PLAIN);
                    testHeaders.setContentDispositionFormData("attachment", testFile.getName());

                    return ResponseEntity.ok()
                            .headers(testHeaders)
                            .contentLength(testFile.length())
                            .body(testData);
                } catch (Exception e) {
                    System.out.println("[ERROR] 创建测试文件失败: " + e.getMessage());
                }

                System.out.println("[ERROR] 所有位置均未找到文件");
                return ResponseEntity.notFound().build();
            }

            // 读取文件内容
            byte[] data = Files.readAllBytes(file.toPath());
            System.out.println("[DEBUG] 读取文件成功, 大小: " + data.length + " 字节");

            // 设置响应头
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", fileName);

            // 返回文件数据
            return ResponseEntity.ok()
                    .headers(headers)
                    .contentLength(file.length())
                    .body(data);

        } catch (Exception e) {
            System.out.println("[ERROR] 通过控制器下载文件出错: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/test-download")
    public String testDownloadPage() {
        return "document/test";
    }

    @GetMapping("/download-test-file")
    public ResponseEntity<byte[]> downloadTestFile(HttpSession session) {
        try {
            // 获取test.txt文件
            String realPath = session.getServletContext().getRealPath("/");
            File file = new File(realPath + "uploads/test.txt");

            System.out.println("[DEBUG] 测试文件路径: " + file.getAbsolutePath());
            System.out.println("[DEBUG] 测试文件存在: " + file.exists());

            if (!file.exists()) {
                return ResponseEntity.notFound().build();
            }

            // 读取文件内容
            byte[] data = Files.readAllBytes(file.toPath());

            // 设置响应头
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_PLAIN);
            headers.setContentDispositionFormData("attachment", "test.txt");

            // 返回文件
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(data);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/test-files")
    public String testFiles(HttpSession session, Model model) {
        String baseDir = session.getServletContext().getRealPath("/");
        String uploadsDir = baseDir + "uploads";

        System.out.println("[DEBUG] 测试uploads目录: " + uploadsDir);

        File dir = new File(uploadsDir);
        StringBuilder result = new StringBuilder();

        result.append("应用根目录: ").append(baseDir).append("<br/>");
        result.append("上传目录: ").append(uploadsDir).append("<br/>");
        result.append("目录是否存在: ").append(dir.exists()).append("<br/>");
        result.append("是否为目录: ").append(dir.isDirectory()).append("<br/>");
        result.append("目录是否可读: ").append(dir.canRead()).append("<br/>");
        result.append("目录是否可写: ").append(dir.canWrite()).append("<br/>");

        if (dir.exists() && dir.isDirectory()) {
            result.append("目录内容:<br/>");
            File[] files = dir.listFiles();

            if (files != null && files.length > 0) {
                for (File file : files) {
                    result.append("- ").append(file.getName())
                            .append(" (").append(file.length()).append(" 字节)")
                            .append(" 可读: ").append(file.canRead())
                            .append(" 可写: ").append(file.canWrite())
                            .append(" 最后修改: ").append(new java.util.Date(file.lastModified()))
                            .append("<br/>");

                    // 尝试直接读取文件
                    try {
                        long fileSize = Files.size(file.toPath());
                        result.append("  读取成功，大小: ").append(fileSize).append(" 字节<br/>");
                    } catch (Exception e) {
                        result.append("  读取失败: ").append(e.getMessage()).append("<br/>");
                    }
                }
            } else {
                result.append("目录为空或无法列出文件<br/>");
            }
        }

        model.addAttribute("fileInfo", result.toString());
        return "document/test";
    }

    // 借阅申请页面
    @GetMapping("/borrow")
    public String borrowForm(@RequestParam("id") Long id, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        
        // 获取档案信息
        Document document = documentService.getDocumentById(id);
        if (document == null) {
            return "redirect:/document/list";
        }
        
        // 检查档案状态
        if (document.getStatus() != 1) { // 1表示正常状态
            model.addAttribute("error", "该档案当前不可借阅");
            return "document/view?id=" + id;
        }
        
        model.addAttribute("document", document);
        return "document/borrow";
    }
    
    // 提交借阅申请
    @PostMapping("/borrow")
    public String submitBorrow(@RequestParam("documentId") Long documentId,
                              @RequestParam("dueDate") String dueDateStr,
                              @RequestParam(value = "remark", required = false) String remark,
                              HttpSession session,
                              Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        try {
            // 获取档案信息
            Document document = documentService.getDocumentById(documentId);
            if (document == null) {
                model.addAttribute("error", "档案不存在");
                return "document/borrow";
            }
            
            // 检查档案状态
            if (document.getStatus() != 1) {
                model.addAttribute("error", "该档案当前不可借阅");
                return "document/borrow";
            }
            
            // 检查是否已有未完成的借阅
            if (borrowService.hasActiveBorrow(documentId, userId)) {
                model.addAttribute("error", "您已有该档案的借阅记录，请勿重复申请");
                model.addAttribute("document", document);
                return "document/borrow";
            }
            
            // 转换日期
            java.time.LocalDate dueDate = java.time.LocalDate.parse(dueDateStr);
            java.time.LocalDateTime dueDateTime = dueDate.atTime(23, 59, 59);
            
            // 检查归还日期是否合法（不能早于今天）
            if (dueDate.isBefore(java.time.LocalDate.now())) {
                model.addAttribute("error", "预计归还日期不能早于今天");
                model.addAttribute("document", document);
                return "document/borrow";
            }
            
            // 创建借阅记录
            Borrow borrow = new Borrow();
            borrow.setDocumentId(documentId);
            borrow.setUserId(userId);
            borrow.setBorrowTime(java.time.LocalDateTime.now());
            borrow.setDueTime(dueDateTime);
            borrow.setStatus(0); // 0表示申请中
            borrow.setRemark(remark);
            
            // 保存借阅记录
            Long borrowId = borrowService.addBorrow(borrow);
            
            // 创建审批记录
            Approve approve = new Approve();
            approve.setType("borrow");
            approve.setRefId(borrowId);
            approve.setApplicantId(userId);
            approve.setApproverId(getAdminUserId()); // 获取管理员ID
            approve.setStatus(0); // 0表示待审批
            approve.setApplyTime(java.time.LocalDateTime.now());
            
            // 保存审批记录
            Long approveId = approveService.addApprove(approve);
            
            // 更新借阅记录的审批ID
            borrowService.updateApproveId(borrowId, approveId);
            
            return "redirect:/document/borrow-list?mine=true";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "申请借阅失败: " + e.getMessage());
            Document document = documentService.getDocumentById(documentId);
            model.addAttribute("document", document);
            return "document/borrow";
        }
    }
    
    // 借阅记录列表
    @GetMapping("/borrow-list")
    public String borrowList(@RequestParam(value = "page", defaultValue = "1") int page,
                           @RequestParam(value = "status", required = false) Integer status,
                           @RequestParam(value = "documentTitle", required = false) String documentTitle,
                           @RequestParam(value = "mine", required = false) Boolean mine,
                           HttpSession session,
                           Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 直接从会话中获取管理员标识
        boolean isAdmin = Boolean.TRUE.equals(session.getAttribute("isAdmin"));
        model.addAttribute("isAdmin", isAdmin);
        model.addAttribute("currentUserId", userId);
        
        // 分页参数
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        
        // 查询条件
        Map<String, Object> params = new HashMap<>();
        if (status != null) {
            params.put("status", status);
        }
        if (documentTitle != null && !documentTitle.trim().isEmpty()) {
            params.put("documentTitle", documentTitle);
        }
        if (Boolean.TRUE.equals(mine)) {
            params.put("userId", userId);
        }
        
        // 查询借阅记录
        List<Map<String, Object>> borrows = borrowService.getBorrowList(params, offset, pageSize);
        int total = borrowService.countBorrows(params);
        
        // 计算总页数
        int totalPages = (int) Math.ceil((double) total / pageSize);
        
        model.addAttribute("borrows", borrows);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages > 0 ? totalPages : 1);
        
        return "document/borrow-list";
    }
    
    // 借阅审批页面
    @GetMapping("/approve-borrow")
    public String approveBorrowForm(@RequestParam("id") Long borrowId, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 检查是否是管理员
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (!Boolean.TRUE.equals(isAdmin)) {
            model.addAttribute("error", "您没有权限进行此操作");
            return "error";
        }
        
        // 获取借阅记录详情
        Map<String, Object> borrowDetail = borrowService.getBorrowDetail(borrowId);
        if (borrowDetail == null) {
            model.addAttribute("error", "借阅记录不存在");
            return "error";
        }
        
        model.addAttribute("borrow", borrowDetail);
        return "document/approve-borrow";
    }
    
    // 提交借阅审批
    @PostMapping("/approve-borrow")
    public String submitApproveBorrow(@RequestParam("borrowId") Long borrowId,
                                     @RequestParam("action") String action,
                                     @RequestParam(value = "approveRemark", required = false) String approveRemark,
                                     HttpSession session,
                                     Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 检查是否是管理员
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (!Boolean.TRUE.equals(isAdmin)) {
            model.addAttribute("error", "您没有权限进行此操作");
            return "error";
        }
        
        // 获取借阅记录
        Borrow borrow = borrowService.getBorrowById(borrowId);
        if (borrow == null) {
            model.addAttribute("error", "借阅记录不存在");
            return "error";
        }
        
        // 获取审批记录
        Approve approve = approveService.getApproveById(borrow.getApproveId());
        if (approve == null) {
            model.addAttribute("error", "审批记录不存在");
            return "error";
        }
        
        // 更新审批状态
        int approveStatus = "approve".equals(action) ? 1 : 2; // 1表示通过，2表示拒绝
        approve.setStatus(approveStatus);
        approve.setApproveTime(java.time.LocalDateTime.now());
        approve.setRemark(approveRemark);
        
        approveService.updateApprove(approve);
        
        // 更新借阅状态
        int borrowStatus = "approve".equals(action) ? 1 : 4; // 批准则设为已借出(1)，拒绝则设置为已拒绝(4)
        borrow.setStatus(borrowStatus);
        borrowService.updateBorrow(borrow);
        
        return "redirect:/document/borrow-list";
    }
    
    // 归还档案
    @GetMapping("/return")
    public String returnDocument(@RequestParam("id") Long borrowId, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        try {
            // 获取借阅记录
            Borrow borrow = borrowService.getBorrowById(borrowId);
            if (borrow == null) {
                return "redirect:/document/borrow-list";
            }
            
            // 检查权限（借阅人或管理员可以归还）
            boolean isAdmin = userService.isAdmin(userId);
            if (!isAdmin && !borrow.getUserId().equals(userId)) {
                return "redirect:/document/borrow-list";
            }
            
            // 检查状态
            Integer status = borrow.getStatus();
            if (status == null || (status != 1 && status != 3)) { // 1表示已借出，3表示逾期
                return "redirect:/document/borrow-list";
            }
            
            // 直接更新借阅状态为已归还(2)
            borrowService.directUpdateBorrowStatus(borrowId, 2, null);
            
            return "redirect:/document/borrow-list";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/document/borrow-list";
        }
    }
    
    // 查看借阅详情
    @GetMapping("/view-borrow")
    public String viewBorrow(@RequestParam(value = "id", required = false) Long borrowId, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        
        // 检查ID参数
        if (borrowId == null) {
            model.addAttribute("error", "借阅ID不能为空");
            return "redirect:/document/borrow-list";
        }
        
        // 获取借阅记录
        Map<String, Object> borrow = borrowService.getBorrowDetail(borrowId);
        if (borrow == null) {
            model.addAttribute("error", "借阅记录不存在");
            return "redirect:/document/borrow-list";
        }
        
        model.addAttribute("borrow", borrow);
        return "document/view-borrow";
    }
    
    // 获取管理员用户ID（实际应用中应该从配置或数据库获取）
    private Long getAdminUserId() {
        // 这里简化处理，假设ID为1的用户是管理员
        return 1L;
    }

    // 档案编辑页面
    @GetMapping("/edit")
    public String editForm(@RequestParam("id") Long id, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        
        Document document = documentService.getDocumentById(id);
        if (document == null) {
            return "redirect:/document/list";
        }
        
        // 检查档案状态
        if (document.getStatus() != 1) { // 1表示正常状态
            model.addAttribute("error", "该档案当前不可编辑");
            return "redirect:/document/view?id=" + id;
        }
        
        // 获取分类列表
        List<Map<String, Object>> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        
        // 获取密级列表
        List<Map<String, Object>> secretLevels = categoryService.getAllSecretLevels();
        model.addAttribute("secretLevels", secretLevels);
        
        model.addAttribute("document", document);
        return "document/edit";
    }
    
    // 提交档案编辑
    @PostMapping("/edit")
    public String submitEdit(@ModelAttribute Document document,
                           @RequestParam(value = "file", required = false) MultipartFile file,
                           HttpSession session,
                           Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        
        try {
            // 获取原档案信息
            Document originalDoc = documentService.getDocumentById(document.getId());
            if (originalDoc == null) {
                return "redirect:/document/list";
            }
            
            // 检查档案状态
            if (originalDoc.getStatus() != 1) {
                model.addAttribute("error", "该档案当前不可编辑");
                return "redirect:/document/view?id=" + document.getId();
            }
            
            // 保留原始信息
            document.setCode(originalDoc.getCode());
            document.setCreateUser(originalDoc.getCreateUser());
            document.setCreateTime(originalDoc.getCreateTime());
            document.setOwnerId(originalDoc.getOwnerId());
            document.setStatus(originalDoc.getStatus());
            document.setUpdateTime(java.time.LocalDateTime.now());
            
            // 如果上传了新文件
            if (file != null && !file.isEmpty()) {
                // 生成唯一文件名
                String originalFilename = org.springframework.util.StringUtils.cleanPath(file.getOriginalFilename());
                String newFilename = System.currentTimeMillis() + "_" + originalFilename;
                
                // 保存文件
                File uploadDir = new File(FIXED_UPLOAD_PATH);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                File destFile = new File(uploadDir, newFilename);
                file.transferTo(destFile);
                
                // 更新文件信息
                document.setFileUrl("/uploads/" + newFilename);
                document.setSize(file.getSize());
            } else {
                // 保留原文件信息
                document.setFileUrl(originalDoc.getFileUrl());
                document.setSize(originalDoc.getSize());
            }
            
            // 更新档案
            documentService.updateDocument(document);
            
            return "redirect:/document/view?id=" + document.getId();
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "更新档案失败: " + e.getMessage());
            
            // 获取分类列表
            List<Map<String, Object>> categories = categoryService.getAllCategories();
            model.addAttribute("categories", categories);
            
            // 获取密级列表
            List<Map<String, Object>> secretLevels = categoryService.getAllSecretLevels();
            model.addAttribute("secretLevels", secretLevels);
            
            model.addAttribute("document", document);
            return "document/edit";
        }
    }
    
    // 档案作废申请页面
    @GetMapping("/void")
    public String voidForm(@RequestParam("id") Long id, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        
        Document document = documentService.getDocumentById(id);
        if (document == null) {
            return "redirect:/document/list";
        }
        
        // 检查档案状态
        if (document.getStatus() != 1) { // 1表示正常状态
            model.addAttribute("error", "该档案当前不可作废");
            return "redirect:/document/view?id=" + id;
        }
        
        model.addAttribute("document", document);
        return "document/void";
    }
    
    // 提交档案作废申请
    @PostMapping("/void")
    public String submitVoid(@RequestParam("documentId") Long documentId,
                           @RequestParam("reason") String reason,
                           @RequestParam(value = "remark", required = false) String remark,
                           HttpSession session,
                           Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        try {
            // 获取档案信息
            Document document = documentService.getDocumentById(documentId);
            if (document == null) {
                return "redirect:/document/list";
            }
            
            // 检查档案状态
            if (document.getStatus() != 1) {
                model.addAttribute("error", "该档案当前不可作废");
                model.addAttribute("document", document);
                return "document/void";
            }
            
            // 创建审批记录
            Approve approve = new Approve();
            approve.setType("void");
            approve.setRefId(documentId);
            approve.setApplicantId(userId);
            approve.setApproverId(getAdminUserId());
            approve.setStatus(0); // 0表示待审批
            approve.setApplyTime(java.time.LocalDateTime.now());
            approve.setRemark(reason + (remark != null ? "\n备注: " + remark : ""));
            
            // 保存审批记录
            approveService.addApprove(approve);
            
            return "redirect:/document/approve-list?mine=true";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "申请作废失败: " + e.getMessage());
            Document document = documentService.getDocumentById(documentId);
            model.addAttribute("document", document);
            return "document/void";
        }
    }
    
    // 审批记录列表
    @GetMapping("/approve-list")
    public String approveList(@RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "type", required = false) String type,
                            @RequestParam(value = "status", required = false) Integer status,
                            @RequestParam(value = "mine", required = false) Boolean mine,
                            @RequestParam(value = "pending", required = false) Boolean pending,
                            HttpSession session,
                            Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 分页参数
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        
        // 查询条件
        Map<String, Object> params = new HashMap<>();
        if (type != null && !type.trim().isEmpty()) {
            params.put("type", type);
        }
        if (status != null) {
            params.put("status", status);
        }
        if (Boolean.TRUE.equals(mine)) {
            params.put("applicantId", userId);
        }
        if (Boolean.TRUE.equals(pending)) {
            params.put("approverId", userId);
            params.put("status", 0); // 待审批
        }
        
        // 查询审批记录
        List<Map<String, Object>> approves = approveService.getApproveList(params, offset, pageSize);
        int total = approveService.countApproves(params);
        
        // 计算总页数
        int totalPages = (int) Math.ceil((double) total / pageSize);
        
        model.addAttribute("approves", approves);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages > 0 ? totalPages : 1);
        model.addAttribute("currentUserId", userId);
        
        return "document/approve-list";
    }
    
    // 处理审批页面
    @GetMapping("/process-approve")
    public String processApproveForm(@RequestParam("id") Long approveId, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 获取审批记录
        Approve approve = approveService.getApproveById(approveId);
        if (approve == null) {
            return "redirect:/document/approve-list";
        }
        
        // 检查权限
        if (!approve.getApproverId().equals(userId)) {
            return "redirect:/document/approve-list";
        }
        
        // 检查状态
        if (approve.getStatus() != 0) { // 0表示待审批
            model.addAttribute("error", "该审批已处理");
            return "redirect:/document/approve-list";
        }
        
        // 获取关联业务信息
        Map<String, Object> approveDetail = approveService.getApproveDetail(approveId);
        model.addAttribute("approve", approveDetail);
        
        // 根据类型返回不同的审批页面
        if ("borrow".equals(approve.getType())) {
            return "document/approve-borrow";
        } else if ("void".equals(approve.getType())) {
            return "document/approve-void";
        } else {
            return "document/approve-generic";
        }
    }
    
    // 作废审批页面 - 专门处理
    @GetMapping("/approve-void")
    public String approveVoidForm(@RequestParam("id") Long approveId, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 检查是否是管理员
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (!Boolean.TRUE.equals(isAdmin)) {
            model.addAttribute("error", "您没有权限进行此操作");
            return "error";
        }
        
        // 获取审批记录
        Approve approve = approveService.getApproveById(approveId);
        if (approve == null) {
            model.addAttribute("error", "审批记录不存在");
            return "error";
        }
        
        // 检查类型
        if (!"void".equals(approve.getType())) {
            model.addAttribute("error", "非作废审批类型");
            return "error";
        }
        
        // 获取关联业务信息
        Map<String, Object> approveDetail = approveService.getApproveDetail(approveId);
        model.addAttribute("approve", approveDetail);
        
        return "document/approve-void";
    }
    
    // 提交作废审批
    @PostMapping("/approve-void")
    public String submitApproveVoid(@RequestParam("approveId") Long approveId,
                                  @RequestParam("action") String action,
                                  @RequestParam("approveRemark") String approveRemark,
                                  HttpSession session,
                                  Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 检查是否是管理员
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (!Boolean.TRUE.equals(isAdmin)) {
            model.addAttribute("error", "您没有权限进行此操作");
            return "error";
        }
        
        try {
            // 获取审批记录
            Approve approve = approveService.getApproveById(approveId);
            if (approve == null) {
                model.addAttribute("error", "审批记录不存在");
                return "error";
            }
            
            // 检查类型
            if (!"void".equals(approve.getType())) {
                model.addAttribute("error", "非作废审批类型");
                return "error";
            }
            
            // 更新审批状态
            int approveStatus = "approve".equals(action) ? 1 : 2; // 1表示通过，2表示拒绝
            approve.setStatus(approveStatus);
            approve.setApproveTime(java.time.LocalDateTime.now());
            approve.setRemark(approveRemark);
            
            approveService.updateApprove(approve);
            
            // 如果批准，则更新档案状态为作废(2)
            if (approveStatus == 1) {
                documentService.voidDocument(approve.getRefId());
            }
            
            return "redirect:/document/approve-list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "处理审批失败: " + e.getMessage());
            return "error";
        }
    }
    
    // 提交作废审批
    @PostMapping("/process-approve")
    public String submitProcessApprove(@RequestParam("approveId") Long approveId,
                                     @RequestParam("action") String action,
                                     @RequestParam("approveRemark") String approveRemark,
                                     HttpSession session,
                                     Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        try {
            // 获取审批记录
            Approve approve = approveService.getApproveById(approveId);
            if (approve == null) {
                return "redirect:/document/approve-list";
            }
            
            // 检查权限
            if (!approve.getApproverId().equals(userId)) {
                return "redirect:/document/approve-list";
            }
            
            // 检查状态
            if (approve.getStatus() != 0) {
                model.addAttribute("error", "该审批已处理");
                return "redirect:/document/approve-list";
            }
            
            // 更新审批状态
            int approveStatus = "approve".equals(action) ? 1 : 2; // 1表示通过，2表示拒绝
            approve.setStatus(approveStatus);
            approve.setApproveTime(java.time.LocalDateTime.now());
            approve.setRemark(approveRemark);
            approveService.updateApprove(approve);
            
            // 根据审批类型处理相关业务
            if ("void".equals(approve.getType()) && approveStatus == 1) {
                // 如果是作废审批且通过，则更新档案状态为作废(2)
                documentService.voidDocument(approve.getRefId());
            } else if ("borrow".equals(approve.getType())) {
                // 借阅审批在专门的方法中处理
                return "redirect:/document/approve-borrow?id=" + approve.getRefId();
            }
            
            return "redirect:/document/approve-list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "处理审批失败: " + e.getMessage());
            return "redirect:/document/approve-list";
        }
    }

    // 诊断当前用户信息
    @GetMapping("/diagnose-user")
    public String diagnoseUser(Model model, HttpSession session) {
        // 获取会话中的用户信息
        Object userIdObj = session.getAttribute("userId");
        Object isAdminObj = session.getAttribute("isAdmin");
        Object usernameObj = session.getAttribute("username");
        Object realNameObj = session.getAttribute("realName");
        
        // 构建诊断信息
        StringBuilder info = new StringBuilder();
        info.append("当前用户ID: ").append(userIdObj).append("<br>");
        info.append("是否管理员: ").append(isAdminObj).append("<br>");
        info.append("用户名: ").append(usernameObj).append("<br>");
        info.append("真实姓名: ").append(realNameObj).append("<br>");
        
        // 获取待处理的审批
        if (userIdObj != null) {
            Long userId = (Long) userIdObj;
            Map<String, Object> params = new HashMap<>();
            params.put("approverId", userId);
            params.put("status", 0); // 待审批
            
            List<Map<String, Object>> pendingApproves = approveService.getApproveList(params, 0, 100);
            
            info.append("<br><h3>待处理审批记录:</h3>");
            if (pendingApproves.isEmpty()) {
                info.append("无待处理审批<br>");
            } else {
                info.append("<table border='1'>");
                info.append("<tr><th>ID</th><th>类型</th><th>申请人</th><th>审批人</th><th>审批人ID</th></tr>");
                
                for (Map<String, Object> approve : pendingApproves) {
                    info.append("<tr>");
                    info.append("<td>").append(approve.get("id")).append("</td>");
                    info.append("<td>").append(approve.get("type")).append("</td>");
                    info.append("<td>").append(approve.get("applicantName")).append("</td>");
                    info.append("<td>").append(approve.get("approverName")).append("</td>");
                    info.append("<td>").append(approve.get("approverId")).append("</td>");
                    info.append("</tr>");
                }
                
                info.append("</table>");
            }
        } else {
            info.append("<br>用户未登录，无法获取审批信息");
        }
        
        model.addAttribute("diagnosticInfo", info.toString());
        return "document/diagnostic";
    }

    // 待处理作废审批列表
    @GetMapping("/void-approve-list")
    public String voidApproveList(@RequestParam(value = "page", defaultValue = "1") int page,
                                 HttpSession session,
                                 Model model) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        Long userId = (Long) userIdObj;
        
        // 检查是否是管理员
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (!Boolean.TRUE.equals(isAdmin)) {
            model.addAttribute("error", "您没有权限访问此页面");
            return "error";
        }
        
        // 分页参数
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        
        // 查询条件：只查询待审批的作废申请
        Map<String, Object> params = new HashMap<>();
        params.put("type", "void");
        params.put("status", 0); // 待审批
        
        // 查询作废审批记录
        List<Map<String, Object>> voidApproves = approveService.getApproveList(params, offset, pageSize);
        int total = approveService.countApproves(params);
        
        // 计算总页数
        int totalPages = (int) Math.ceil((double) total / pageSize);
        
        model.addAttribute("voidApproves", voidApproves);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages > 0 ? totalPages : 1);
        
        return "document/void-approve-list";
    }
    
    // 查看作废详情
    @GetMapping("/view-void")
    public String viewVoid(@RequestParam(value = "id", required = false) Long approveId, Model model, HttpSession session) {
        // 检查登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        
        // 调试信息
        System.out.println("[DEBUG] 查看作废详情，审批ID: " + approveId);
        System.out.println("[DEBUG] 请求参数: " + approveId);
        
        try {
            // 检查ID参数
            if (approveId == null) {
                System.out.println("[ERROR] 审批ID为空");
                model.addAttribute("error", "审批ID不能为空");
                return "redirect:/document/approve-list?error=审批ID不能为空";
            }
            
            // 获取审批记录
            Map<String, Object> approve = approveService.getApproveDetail(approveId);
            System.out.println("[DEBUG] 获取到的审批记录: " + approve);
            
            if (approve == null) {
                System.out.println("[ERROR] 审批记录不存在");
                model.addAttribute("error", "审批记录不存在");
                return "redirect:/document/approve-list?error=审批记录不存在";
            }
            
            // 检查是否是作废类型审批
            String approveType = (String) approve.get("type");
            System.out.println("[DEBUG] 审批类型: " + approveType);
            
            if (!"void".equals(approveType)) {
                System.out.println("[ERROR] 非作废类型审批: " + approveType);
                model.addAttribute("error", "非作废类型审批");
                return "redirect:/document/approve-list?error=非作废类型审批";
            }
            
            // 获取关联的档案信息
            Long documentId = (Long) approve.get("ref_id");
            System.out.println("[DEBUG] 关联的档案ID: " + documentId);
            
            Document document = documentService.getDocumentById(documentId);
            if (document == null) {
                System.out.println("[ERROR] 关联档案不存在");
                model.addAttribute("error", "关联档案不存在");
                return "redirect:/document/approve-list?error=关联档案不存在";
            }
            
            System.out.println("[DEBUG] 档案信息: " + document);
            
            // 将 Document 对象转换为 Map，以便在 JSP 中可以正确访问属性
            Map<String, Object> documentMap = new HashMap<>();
            documentMap.put("id", document.getId());
            documentMap.put("code", document.getCode());
            documentMap.put("title", document.getTitle());
            documentMap.put("status", document.getStatus());
            documentMap.put("createTime", document.getCreateTime());
            
            System.out.println("[DEBUG] 转换后的档案Map: " + documentMap);
            
            model.addAttribute("approve", approve);
            model.addAttribute("document", documentMap);
            
            System.out.println("[DEBUG] 准备返回视图: document/view-void");
            
            return "document/view-void";
        } catch (Exception e) {
            System.out.println("[ERROR] 查看作废详情异常: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "查看作废详情失败: " + e.getMessage());
            return "redirect:/document/approve-list?error=系统错误";
        }
    }

    // 添加测试作废审批记录（用于测试）
    @GetMapping("/test-add-void-approve")
    @ResponseBody
    public String testAddVoidApprove(HttpSession session) {
        try {
            // 检查登录
            Object userIdObj = session.getAttribute("userId");
            if (userIdObj == null) {
                return "请先登录";
            }
            Long userId = (Long) userIdObj;
            
            // 获取一个存在的档案ID
            List<Document> docs = documentService.getDocumentsByStatus(1); // 获取正常状态的档案
            if (docs == null || docs.isEmpty()) {
                return "没有可用的档案";
            }
            
            Document document = docs.get(0);
            Long documentId = document.getId();
            
            // 创建作废审批记录
            Approve approve = new Approve();
            approve.setType("void");
            approve.setRefId(documentId);
            approve.setApplicantId(userId);
            approve.setApproverId(userId); // 自己审批自己（测试用）
            approve.setStatus(0); // 0表示待审批
            approve.setApplyTime(java.time.LocalDateTime.now());
            approve.setRemark("测试作废申请");
            
            // 保存审批记录
            Long approveId = approveService.addApprove(approve);
            
            return "成功添加测试作废审批记录，ID: " + approveId + ", 档案ID: " + documentId;
        } catch (Exception e) {
            e.printStackTrace();
            return "添加测试作废审批记录失败: " + e.getMessage();
        }
    }
}
