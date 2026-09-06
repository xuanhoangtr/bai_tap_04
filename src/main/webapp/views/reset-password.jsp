<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu</title>
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
        .auth-card {
            width: 100%;
            max-width: 450px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
            background: #ffffff;
            padding: 30px;
        }
    </style>
</head>
<body>

<div class="auth-card">
    <div class="text-center mb-4">
        <h3 class="fw-bold text-primary mb-1">ĐẶT LẠI MẬT KHẨU</h3>
        <p class="text-muted small">Nhập mã OTP và thiết lập mật khẩu mới.</p>
    </div>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 small" role="alert">
            ${alert}
        </div>
    </c:if>

    <form action="<c:url value='/reset-password'/>" method="post" class="needs-validation" novalidate id="resetForm">
        <div class="mb-3">
            <label class="form-label fw-semibold small">Địa chỉ Email: <span class="text-danger">*</span></label>
            <input type="email" name="email" class="form-control" value="${not empty email ? email : sessionScope.reset_email}" required />
            <div class="invalid-feedback small">Vui lòng nhập email hợp lệ.</div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold small">Mã xác thực OTP (6 số): <span class="text-danger">*</span></label>
            <input type="text" name="otp" class="form-control text-center fw-bold" maxlength="6" pattern="^[0-9]{6}$" required placeholder="123456" />
            <div class="invalid-feedback small">Mã OTP phải gồm 6 chữ số.</div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold small">Mật khẩu mới: <span class="text-danger">*</span></label>
            <input type="password" name="newPassword" id="newPass" class="form-control" required minlength="6" placeholder="Tối thiểu 6 ký tự..." />
            <div class="invalid-feedback small">Mật khẩu mới phải có ít nhất 6 ký tự.</div>
        </div>

        <div class="mb-4">
            <label class="form-label fw-semibold small">Xác nhận mật khẩu mới: <span class="text-danger">*</span></label>
            <input type="password" name="confirmPassword" id="confirmPass" class="form-control" required minlength="6" placeholder="Nhập lại mật khẩu mới..." />
            <div class="invalid-feedback small" id="confirmError">Mật khẩu xác nhận không khớp.</div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">Cập nhật mật khẩu mới</button>
    </form>

    <div class="text-center small border-top pt-3 text-muted">
        <a href="<c:url value='/login'/>" class="fw-bold text-decoration-none">Quay về trang Đăng nhập</a>
    </div>
</div>

<script>
    (function () {
        'use strict'
        var form = document.getElementById('resetForm');
        var pass = document.getElementById('newPass');
        var conf = document.getElementById('confirmPass');

        form.addEventListener('submit', function (event) {
            if (pass.value !== conf.value) {
                conf.setCustomValidity('Passwords do not match');
            } else {
                conf.setCustomValidity('');
            }

            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }
            form.classList.add('was-validated')
        }, false);

        conf.addEventListener('input', function() {
            if (pass.value !== conf.value) {
                conf.setCustomValidity('Passwords do not match');
            } else {
                conf.setCustomValidity('');
            }
        });
    })()
</script>
</body>
</html>
