<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f1f5f9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-card {
            width: 100%;
            max-width: 420px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
            background: #ffffff;
            padding: 30px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="text-center mb-4">
        <h3 class="fw-bold text-primary mb-1">ĐĂNG NHẬP</h3>
        <p class="text-muted small">Hệ thống quản lý bán hàng &amp; hồ sơ</p>
    </div>

    <c:if test="${not empty successAlert}">
        <div class="alert alert-success py-2 small" role="alert">
            ${successAlert}
        </div>
    </c:if>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 small" role="alert">
            ${alert}
        </div>
    </c:if>

    <form action="<c:url value='/login'/>" method="post" class="needs-validation" novalidate>
        <div class="mb-3">
            <label class="form-label fw-semibold small">Tên đăng nhập:</label>
            <input type="text" name="username" class="form-control" 
                   value="${not empty username ? username : (not empty rememberUser ? rememberUser : '')}" 
                   required placeholder="Nhập tên đăng nhập..." />
            <div class="invalid-feedback small">Vui lòng nhập tên đăng nhập.</div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold small">Mật khẩu:</label>
            <input type="password" name="password" class="form-control" required placeholder="Nhập mật khẩu..." />
            <div class="invalid-feedback small">Vui lòng nhập mật khẩu.</div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4 small">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="remember" ${not empty rememberUser ? 'checked' : ''} />
                <label class="form-check-label text-muted" for="rememberMe">Ghi nhớ đăng nhập</label>
            </div>
            <a href="<c:url value='/forgot-password'/>" class="text-decoration-none">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">Đăng nhập</button>
    </form>

    <div class="text-center small border-top pt-3 text-muted">
        Chưa có tài khoản? <a href="<c:url value='/register'/>" class="fw-bold text-decoration-none">Đăng ký ngay</a>
        <div class="mt-2">
            <a href="<c:url value='/home'/>" class="text-secondary text-decoration-none">Quay lại trang chủ</a>
        </div>
    </div>
</div>

<script>
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>
