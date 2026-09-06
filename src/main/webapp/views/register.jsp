<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f1f5f9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }
        .register-card {
            width: 100%;
            max-width: 480px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
            background: #ffffff;
            padding: 30px;
        }
    </style>
</head>
<body>

<div class="register-card">
    <div class="text-center mb-4">
        <h3 class="fw-bold text-primary mb-1">ĐĂNG KÝ TÀI KHOẢN</h3>
        <p class="text-muted small">Tạo tài khoản mới để truy cập hệ thống</p>
    </div>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 small" role="alert">
            ${alert}
        </div>
    </c:if>

    <form action="<c:url value='/register'/>" method="post" class="needs-validation" novalidate id="registerForm">
        <div class="mb-3">
            <label class="form-label fw-semibold small">Tên đăng nhập (Username): <span class="text-danger">*</span></label>
            <input type="text" name="username" class="form-control" 
                   value="${username}" required pattern="^[a-zA-Z0-9_]{3,30}$" 
                   placeholder="Từ 3-30 ký tự, không dấu..." />
            <div class="invalid-feedback small">Tên đăng nhập từ 3-30 ký tự (chữ, số, gạch dưới).</div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold small">Họ và tên (Fullname): <span class="text-danger">*</span></label>
            <input type="text" name="fullname" class="form-control" 
                   value="${fullname}" required minlength="2" 
                   placeholder="Nhập họ và tên đầy đủ..." />
            <div class="invalid-feedback small">Vui lòng nhập họ và tên (tối thiểu 2 ký tự).</div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold small">Địa chỉ Email (Nhận OTP): <span class="text-danger">*</span></label>
            <input type="email" name="email" class="form-control" 
                   value="${email}" required 
                   placeholder="example@gmail.com" />
            <div class="invalid-feedback small">Vui lòng nhập địa chỉ email hợp lệ.</div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold small">Số điện thoại (Phone):</label>
            <input type="tel" name="phone" class="form-control" 
                   value="${phone}" pattern="^0[0-9]{9}$" 
                   placeholder="0987654321 (10 chữ số)" />
            <div class="invalid-feedback small">Số điện thoại phải gồm 10 chữ số (bắt đầu bằng 0).</div>
        </div>

        <div class="row g-2 mb-4">
            <div class="col-md-6">
                <label class="form-label fw-semibold small">Mật khẩu: <span class="text-danger">*</span></label>
                <input type="password" name="password" id="passwordInput" class="form-control" 
                       required minlength="6" placeholder="Tối thiểu 6 ký tự..." />
                <div class="invalid-feedback small">Mật khẩu ít nhất 6 ký tự.</div>
            </div>
            <div class="col-md-6">
                <label class="form-label fw-semibold small">Xác nhận mật khẩu: <span class="text-danger">*</span></label>
                <input type="password" name="confirmPassword" id="confirmPasswordInput" class="form-control" 
                       required minlength="6" placeholder="Nhập lại mật khẩu..." />
                <div class="invalid-feedback small" id="confirmFeedback">Mật khẩu xác nhận không khớp.</div>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">Đăng ký &amp; Nhận mã OTP</button>
    </form>

    <div class="text-center small border-top pt-3 text-muted">
        Đã có tài khoản? <a href="<c:url value='/login'/>" class="fw-bold text-decoration-none">Đăng nhập ngay</a>
        <div class="mt-2">
            <a href="<c:url value='/home'/>" class="text-secondary text-decoration-none">Quay lại trang chủ</a>
        </div>
    </div>
</div>

<script>
    (function () {
        'use strict'
        var form = document.getElementById('registerForm');
        var password = document.getElementById('passwordInput');
        var confirm = document.getElementById('confirmPasswordInput');

        form.addEventListener('submit', function (event) {
            if (password.value !== confirm.value) {
                confirm.setCustomValidity('Passwords do not match');
            } else {
                confirm.setCustomValidity('');
            }

            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }
            form.classList.add('was-validated')
        }, false);

        confirm.addEventListener('input', function() {
            if (password.value !== confirm.value) {
                confirm.setCustomValidity('Passwords do not match');
            } else {
                confirm.setCustomValidity('');
            }
        });
    })()
</script>
</body>
</html>
