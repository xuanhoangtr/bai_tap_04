<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Hệ thống quản lý bán hàng</sitemesh:write></title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #212529;
        }
        .main-content {
            flex: 1;
            padding-top: 25px;
            padding-bottom: 40px;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        .user-avatar-sm {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
            border: 1.5px solid #fff;
        }
        .footer {
            background-color: #212529;
            color: #adb5bd;
            padding: 20px 0;
            margin-top: auto;
            font-size: 0.875rem;
        }
        .footer a {
            color: #0d6efd;
            text-decoration: none;
        }
        .subnav-bar {
            background-color: #ffffff;
            border-bottom: 1px solid #dee2e6;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/home'/>">
                HỆ THỐNG QUẢN LÝ BÁN HÀNG
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarMain">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="<c:url value='/home'/>">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="<c:url value='/product'/>">Tất cả sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="<c:url value='/admin/categories'/>">Quản trị Danh mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="<c:url value='/admin/products'/>">Quản trị Sản phẩm</a>
                    </li>
                </ul>

                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center text-white" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.account.images and sessionScope.account.images.startsWith('http')}">
                                            <img src="${sessionScope.account.images}" class="user-avatar-sm me-2" alt="Avatar">
                                        </c:when>
                                        <c:when test="${not empty sessionScope.account.images}">
                                            <img src="<c:url value='/image?fname=${sessionScope.account.images}'/>" class="user-avatar-sm me-2" alt="Avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="<c:url value='/image?fname=avatar.png'/>" class="user-avatar-sm me-2" alt="Avatar">
                                        </c:otherwise>
                                    </c:choose>
                                    <span>${not empty sessionScope.account.fullName ? sessionScope.account.fullName : sessionScope.account.userName}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <li><a class="dropdown-item" href="<c:url value='/profile'/>">Hồ sơ cá nhân (Profile)</a></li>
                                    <li><a class="dropdown-item" href="<c:url value='/admin/products'/>">Khu vực Quản trị</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item me-2">
                                <a class="btn btn-outline-light btn-sm" href="<c:url value='/login'/>">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-light btn-sm text-primary fw-bold" href="<c:url value='/register'/>">Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content Area Decorated by SiteMesh 3 -->
    <main class="main-content">
        <div class="container">
            <sitemesh:write property="body"/>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container">
            <p class="mb-0 text-muted">Hệ thống quản lý bán hàng &amp; hồ sơ người dùng</p>
        </div>
    </footer>

    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
