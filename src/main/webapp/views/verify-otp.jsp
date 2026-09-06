<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP - Kích hoạt tài khoản</title>
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
        .auth-card {
            width: 100%;
            max-width: 420px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
            background: #ffffff;
            padding: 30px;
        }
        .otp-input {
            letter-spacing: 6px;
            font-size: 1.25rem;
            text-align: center;
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="auth-card">
    <div class="text-center mb-4">
        <h3 class="fw-bold text-success mb-1">XÁC THỰC OTP</h3>
        <p class="text-muted small">Nhập mã OTP 6 chữ số đã được gửi qua email của bạn.</p>
    </div>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 small" role="alert">
            ${alert}
        </div>
    </c:if>

    <form action="<c:url value='/verify-otp'/>" method="post" class="needs-validation" novalidate>
        <div class="mb-3">
            <label class="form-label fw-semibold small">Email hoặc Tên đăng nhập: <span class="text-danger">*</span></label>
            <input type="text" name="email" class="form-control" value="${not empty email ? email : sessionScope.verify_email}" required />
            <div class="invalid-feedback small">Vui lòng nhập email hoặc tên đăng nhập.</div>
        </div>

        <div class="mb-4">
            <label class="form-label fw-semibold small">Mã xác thực OTP (6 số): <span class="text-danger">*</span></label>
            <input type="text" name="otp" class="form-control otp-input" maxlength="6" pattern="^[0-9]{6}$" required placeholder="123456" />
            <div class="invalid-feedback small">Mã OTP phải gồm 6 chữ số.</div>
        </div>

        <button type="submit" class="btn btn-success w-100 py-2 fw-semibold mb-3">Xác nhận &amp; Kích hoạt</button>
    </form>

    <div class="text-center small border-top pt-3 text-muted">
        <a href="<c:url value='/login'/>" class="fw-bold text-decoration-none">Quay về trang Đăng nhập</a>
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
