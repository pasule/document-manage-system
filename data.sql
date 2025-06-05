-- 档案目录表（document）
CREATE TABLE document (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '档案ID',
    code VARCHAR(50) NOT NULL UNIQUE COMMENT '档案编号',
    title VARCHAR(200) NOT NULL COMMENT '档案标题',
    category_id BIGINT COMMENT '分类ID',
    secret_level_id BIGINT COMMENT '密级ID',
    status TINYINT DEFAULT 1 COMMENT '状态（1正常 0回收站 2作废）',
    file_url VARCHAR(255) COMMENT '文件存储路径',
    page_count INT DEFAULT 0 COMMENT '页数',
    size BIGINT DEFAULT 0 COMMENT '文件大小（字节）',
    owner_id BIGINT COMMENT '所属人ID',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    description VARCHAR(500) COMMENT '档案描述',
    INDEX idx_category_id (category_id),
    INDEX idx_secret_level_id (secret_level_id),
    INDEX idx_owner_id (owner_id),
    INDEX idx_create_user (create_user),
    FOREIGN KEY (category_id) REFERENCES archive_category(id),
    FOREIGN KEY (secret_level_id) REFERENCES secret_level(id),
    FOREIGN KEY (owner_id) REFERENCES user(id),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

-- 借阅记录表（borrow）
CREATE TABLE borrow (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '借阅记录ID',
    document_id BIGINT NOT NULL COMMENT '档案ID',
    user_id BIGINT NOT NULL COMMENT '借阅人ID',
    borrow_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '借阅时间',
    return_time DATETIME COMMENT '归还时间',
    due_time DATETIME COMMENT '应还时间',
    status TINYINT DEFAULT 0 COMMENT '状态（0申请中 1已借出 2已归还 3逾期）',
    approve_id BIGINT COMMENT '审批记录ID',
    remark VARCHAR(200) COMMENT '备注',
    INDEX idx_document_id (document_id),
    INDEX idx_user_id (user_id),
    INDEX idx_approve_id (approve_id),
    FOREIGN KEY (document_id) REFERENCES document(id),
    FOREIGN KEY (user_id) REFERENCES user(id)
    -- approve_id 可选外键，后面approve表定义后可加
);

-- 审批记录表（approve）
CREATE TABLE approve (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '审批ID',
    type VARCHAR(20) NOT NULL COMMENT '审批类型（借阅/入库/出库/作废等）',
    ref_id BIGINT NOT NULL COMMENT '关联业务ID',
    applicant_id BIGINT NOT NULL COMMENT '申请人ID',
    approver_id BIGINT NOT NULL COMMENT '审批人ID',
    status TINYINT DEFAULT 0 COMMENT '状态（0待审批 1通过 2拒绝）',
    apply_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    approve_time DATETIME COMMENT '审批时间',
    remark VARCHAR(200) COMMENT '备注',
    INDEX idx_ref_id (ref_id),
    INDEX idx_applicant_id (applicant_id),
    INDEX idx_approver_id (approver_id),
    FOREIGN KEY (applicant_id) REFERENCES user(id),
    FOREIGN KEY (approver_id) REFERENCES user(id)
);

-- 补充 borrow.approve_id 外键
ALTER TABLE borrow ADD CONSTRAINT fk_borrow_approve_id FOREIGN KEY (approve_id) REFERENCES approve(id);

-- 档案分类表（category）
CREATE TABLE category (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
    name VARCHAR(100) NOT NULL COMMENT '分类名称',
    code VARCHAR(50) NOT NULL UNIQUE COMMENT '分类编码',
    parent_id BIGINT DEFAULT NULL COMMENT '上级分类ID',
    level INT DEFAULT 1 COMMENT '分类层级',
    path VARCHAR(500) DEFAULT NULL COMMENT '分类路径',
    description VARCHAR(500) DEFAULT NULL COMMENT '分类描述',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_parent_id (parent_id),
    INDEX idx_create_user (create_user),
    FOREIGN KEY (parent_id) REFERENCES category(id),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

-- 标签管理表（tag）
CREATE TABLE tag (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '标签ID',
    name VARCHAR(100) NOT NULL UNIQUE COMMENT '标签名称',
    color VARCHAR(20) DEFAULT NULL COMMENT '标签颜色',
    description VARCHAR(500) DEFAULT NULL COMMENT '标签描述',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_create_user (create_user),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

-- 编号规则表（rule）
CREATE TABLE rule (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '规则ID',
    name VARCHAR(100) NOT NULL COMMENT '规则名称',
    code VARCHAR(50) NOT NULL UNIQUE COMMENT '规则编码',
    pattern VARCHAR(200) NOT NULL COMMENT '编号生成规则表达式',
    example VARCHAR(100) DEFAULT NULL COMMENT '编号示例',
    description VARCHAR(500) DEFAULT NULL COMMENT '规则描述',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_create_user (create_user),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

-- 清单导出模板表（export_template）
CREATE TABLE export_template (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '模板ID',
    name VARCHAR(100) NOT NULL COMMENT '模板名称',
    type VARCHAR(50) NOT NULL COMMENT '模板类型（如档案清单、借阅统计等）',
    file_path VARCHAR(255) NOT NULL COMMENT '模板文件存储路径',
    file_type VARCHAR(20) DEFAULT 'xlsx' COMMENT '模板文件类型',
    description VARCHAR(500) DEFAULT NULL COMMENT '模板描述',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_type (type),
    INDEX idx_create_user (create_user),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

-- 条码模板表（barcode_template）
CREATE TABLE barcode_template (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '条码模板ID',
    name VARCHAR(100) NOT NULL COMMENT '模板名称',
    code VARCHAR(50) NOT NULL UNIQUE COMMENT '模板编码',
    format VARCHAR(50) NOT NULL COMMENT '条码格式（如CODE128、QR等）',
    width INT DEFAULT 200 COMMENT '条码宽度（像素）',
    height INT DEFAULT 80 COMMENT '条码高度（像素）',
    dpi INT DEFAULT 300 COMMENT '分辨率DPI',
    content_rule VARCHAR(200) NOT NULL COMMENT '条码内容生成规则',
    preview_url VARCHAR(255) DEFAULT NULL COMMENT '模板预览图片路径',
    description VARCHAR(500) DEFAULT NULL COMMENT '模板描述',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_code (code),
    INDEX idx_format (format),
    INDEX idx_create_user (create_user),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

-- 热门访问排行表（hot_ranking）
CREATE TABLE hot_ranking (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '排行ID',
    document_id BIGINT NOT NULL COMMENT '档案ID',
    access_count INT DEFAULT 0 COMMENT '访问次数',
    unique_user_count INT DEFAULT 0 COMMENT '独立访问用户数',
    last_access_time DATETIME COMMENT '最近访问时间',
    ranking_date DATE COMMENT '统计日期',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_document_id (document_id),
    INDEX idx_ranking_date (ranking_date),
    FOREIGN KEY (document_id) REFERENCES document(id)
);

-- 借阅统计表（borrow_stats）
CREATE TABLE borrow_stats (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '统计ID',
    document_id BIGINT COMMENT '档案ID',
    user_id BIGINT COMMENT '用户ID',
    borrow_count INT DEFAULT 0 COMMENT '借阅次数',
    last_borrow_time DATETIME COMMENT '最近借阅时间',
    total_borrow_days INT DEFAULT 0 COMMENT '累计借阅天数',
    stats_date DATE COMMENT '统计日期',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_document_id (document_id),
    INDEX idx_user_id (user_id),
    INDEX idx_stats_date (stats_date),
    FOREIGN KEY (document_id) REFERENCES document(id),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- 系统通知表（notice）
CREATE TABLE notice (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '通知ID',
    title VARCHAR(200) NOT NULL COMMENT '通知标题',
    content TEXT NOT NULL COMMENT '通知内容',
    type VARCHAR(50) DEFAULT 'system' COMMENT '通知类型（system/approval/borrow/other）',
    priority TINYINT DEFAULT 1 COMMENT '优先级（1普通 2重要 3紧急）',
    status TINYINT DEFAULT 0 COMMENT '状态（0未读 1已读 2归档）',
    sender_id BIGINT COMMENT '发送人ID',
    receiver_id BIGINT COMMENT '接收人ID',
    send_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    read_time DATETIME COMMENT '阅读时间',
    archive_time DATETIME COMMENT '归档时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_type (type),
    INDEX idx_status (status),
    INDEX idx_sender_id (sender_id),
    INDEX idx_receiver_id (receiver_id),
    FOREIGN KEY (sender_id) REFERENCES user(id),
    FOREIGN KEY (receiver_id) REFERENCES user(id)
);

-- 审批提醒表（approval_alert）
CREATE TABLE approval_alert (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '审批提醒ID',
    approval_id BIGINT NOT NULL COMMENT '关联审批ID',
    receiver_id BIGINT NOT NULL COMMENT '接收人ID',
    alert_type VARCHAR(50) DEFAULT 'pending' COMMENT '提醒类型（pending/approved/rejected/other）',
    content VARCHAR(500) NOT NULL COMMENT '提醒内容',
    status TINYINT DEFAULT 0 COMMENT '状态（0未读 1已读 2处理完毕）',
    send_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    read_time DATETIME COMMENT '阅读时间',
    handle_time DATETIME COMMENT '处理时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_approval_id (approval_id),
    INDEX idx_receiver_id (receiver_id),
    FOREIGN KEY (approval_id) REFERENCES approve(id),
    FOREIGN KEY (receiver_id) REFERENCES user(id)
);

-- 密级配置表（secrecy_level）
CREATE TABLE secrecy_level (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '密级ID',
    name VARCHAR(50) NOT NULL UNIQUE COMMENT '密级名称',
    code VARCHAR(20) NOT NULL UNIQUE COMMENT '密级编码',
    description VARCHAR(200) DEFAULT NULL COMMENT '密级描述',
    level_order INT DEFAULT 1 COMMENT '密级排序（数值越大密级越高）',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_code (code),
    INDEX idx_create_user (create_user),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

-- 生命周期配置表（lifecycle_setting）
CREATE TABLE lifecycle_setting (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '生命周期ID',
    name VARCHAR(100) NOT NULL COMMENT '生命周期名称',
    code VARCHAR(50) NOT NULL UNIQUE COMMENT '生命周期编码',
    description VARCHAR(200) DEFAULT NULL COMMENT '生命周期描述',
    retention_years INT DEFAULT 10 COMMENT '保管年限',
    warning_days INT DEFAULT 30 COMMENT '到期预警天数',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_user BIGINT COMMENT '创建人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_code (code),
    INDEX idx_create_user (create_user),
    FOREIGN KEY (create_user) REFERENCES user(id)
);

CREATE TABLE archive_category (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
    name VARCHAR(100) NOT NULL COMMENT '分类名称'
    -- 其他字段可根据需要补充
);

CREATE TABLE secret_level (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '密级ID',
    name VARCHAR(50) NOT NULL COMMENT '密级名称'
    -- 其他字段可根据需要补充
);

CREATE TABLE user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(100) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    real_name VARCHAR(100) COMMENT '真实姓名',
    status TINYINT DEFAULT 1 COMMENT '状态（1启用 0停用）',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
);