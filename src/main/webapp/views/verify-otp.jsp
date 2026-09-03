<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xac thuc OTP - Kich hoat tai khoan</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; margin: 0; padding: 40px; }
        .card { max-width: 400px; margin: 0 auto; background: #fff; padding: 25px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        h2 { color: #333; margin-bottom: 10px; }
        p { color: #666; font-size: 14px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; text-align: left; }
        label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        input[type="text"], input[type="email"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        input[name="otp"] { font-size: 20px; letter-spacing: 5px; text-align: center; }
        .btn-submit { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background-color: #218838; }
        .alert { padding: 10px; margin-bottom: 15px; border-radius: 4px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; font-size: 14px; }
        .footer-links { margin-top: 15px; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Xac thuc OTP</h2>
    <p>Vui long kiem tra email cua ban de lay ma OTP 6 chu so kich hoat tai khoan.</p>
    <c:if test="${not empty alert}">
        <div class="alert">${alert}</div>
    </c:if>
    <form action="<c:url value='/verify-otp'/>" method="post">
        <div class="form-group">
            <label>Email hoac Ten dang nhap:</label>
            <input type="text" name="email" value="${not empty email ? email : sessionScope.verify_email}" required />
        </div>
        <div class="form-group">
            <label>Nhap ma OTP (6 so):</label>
            <input type="text" name="otp" maxlength="6" required placeholder="123456" />
        </div>
        <button type="submit" class="btn-submit">Xac nhan & Kich hoat</button>
    </form>
    <div class="footer-links">
        <a href="<c:url value='/login'/>">Quay ve trang Dang nhap</a>
    </div>
</div>
</body>
</html>
