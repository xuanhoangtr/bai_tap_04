<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Trang quản trị - Hệ thống bán hàng</sitemesh:write></title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #334155;
        }
        .admin-wrapper {
            display: flex;
            flex: 1;
        }
        .admin-sidebar {
            width: 250px;
            background-color: #1e293b;
            color: #cbd5e1;
            flex-shrink: 0;
            min-height: calc(100vh - 56px - 60px);
        }
        .admin-sidebar a {
            color: #94a3b8;
            text-decoration: none;
            padding: 12px 20px;
            display: block;
            font-size: 0.9rem;
            font-weight: 500;
            border-left: 3px solid transparent;
            transition: all 0.2s;
        }
        .admin-sidebar a:hover, .admin-sidebar a.active {
            background-color: #0f172a;
            color: #ffffff;
            border-left-color: #0d6efd;
        }
        .admin-sidebar .sidebar-heading {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #64748b;
            padding: 16px 20px 6px;
            font-weight: 700;
        }
        .admin-main {
            flex: 1;
            padding: 25px 30px;
            overflow-y: auto;
        }
        .footer {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 15px 0;
            margin-top: auto;
            font-size: 0.825rem;
        }
        .user-avatar-sm {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- Admin Top Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container-fluid px-3">
            <a class="navbar-brand fw-bold text-primary" href="<c:url value='/admin/products'/>">
                ADMIN PANEL - QUẢN TRỊ
            </a>
            <div class="ms-auto d-flex align-items-center gap-3">
                <a href="<c:url value='/home'/>" class="btn btn-outline-light btn-sm">Xem Website</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <span class="text-light small">
                            ${sessionScope.account.fullName != null ? sessionScope.account.fullName : sessionScope.account.userName}
                        </span>
                        <a href="<c:url value='/profile'/>" class="btn btn-sm btn-outline-primary">Hồ sơ</a>
                        <a href="<c:url value='/logout'/>" class="btn btn-sm btn-danger">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/login'/>" class="btn btn-sm btn-primary">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <div class="admin-wrapper">
        <!-- Sidebar Navigation -->
        <aside class="admin-sidebar shadow-sm">
            <div class="sidebar-heading">Quản lý nội dung</div>
            <a href="<c:url value='/admin/categories'/>">Danh mục sản phẩm</a>
            <a href="<c:url value='/admin/category/add'/>">Thêm danh mục mới</a>
            <a href="<c:url value='/admin/products'/>">Danh sách sản phẩm</a>
            <a href="<c:url value='/admin/product/add'/>">Thêm sản phẩm mới</a>

            <div class="sidebar-heading">Người dùng &amp; Tài khoản</div>
            <a href="<c:url value='/profile'/>">Hồ sơ cá nhân</a>
            <a href="<c:url value='/home'/>">Quay về trang chủ</a>
        </aside>

        <!-- Admin Main Content -->
        <main class="admin-main">
            <sitemesh:write property="body"/>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container-fluid">
            <span>Hệ thống quản lý bán hàng</span>
        </div>
    </footer>

    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
