<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dat lai mat khau</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; margin: 0; padding: 40px; }
        .card { max-width: 400px; margin: 0 auto; background: #fff; padding: 25px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        input[type="text"], input[type="password"], input[type="email"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        input[name="otp"] { font-size: 18px; letter-spacing: 4px; text-align: center; }
        .btn-submit { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background-color: #0056b3; }
        .alert { padding: 10px; margin-bottom: 15px; border-radius: 4px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; font-size: 14px; }
        .footer-links { margin-top: 15px; text-align: center; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Dat lai mat khau moi</h2>
    <c:if test="${not empty alert}">
        <div class="alert">${alert}</div>
    </c:if>
    <form action="<c:url value='/reset-password'/>" method="post">
        <div class="form-group">
            <label>Email xac nhan:</label>
            <input type="email" name="email" value="${not empty email ? email : sessionScope.reset_email}" required />
        </div>
        <div class="form-group">
            <label>Ma OTP 6 so (kiem tra email):</label>
            <input type="text" name="otp" maxlength="6" required placeholder="123456" />
        </div>
        <div class="form-group">
            <label>Mat khau moi:</label>
            <input type="password" name="newPassword" required placeholder="Nhap mat khau moi" />
        </div>
        <div class="form-group">
            <label>Xac nhan mat khau moi:</label>
            <input type="password" name="confirmPassword" required placeholder="Nhap lai mat khau moi" />
        </div>
        <button type="submit" class="btn-submit">Cap nhat mat khau moi</button>
    </form>
    <div class="footer-links">
        <a href="<c:url value='/login'/>">Quay ve trang Dang nhap</a>
    </div>
</div>
</body>
</html>
