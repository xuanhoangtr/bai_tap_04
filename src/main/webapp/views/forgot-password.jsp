<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quen mat khau</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; margin: 0; padding: 40px; }
        .card { max-width: 400px; margin: 0 auto; background: #fff; padding: 25px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 10px; }
        p { color: #666; font-size: 14px; margin-bottom: 20px; text-align: center; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        input[type="email"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { width: 100%; padding: 10px; background-color: #ffc107; color: #212529; font-weight: bold; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background-color: #e0a800; }
        .alert { padding: 10px; margin-bottom: 15px; border-radius: 4px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; font-size: 14px; }
        .footer-links { margin-top: 15px; text-align: center; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Quen mat khau</h2>
    <p>Nhap dia chi email da dang ky cua ban de nhan ma OTP dat lai mat khau.</p>
    <c:if test="${not empty alert}">
        <div class="alert">${alert}</div>
    </c:if>
    <form action="<c:url value='/forgot-password'/>" method="post">
        <div class="form-group">
            <label>Email cua ban:</label>
            <input type="email" name="email" required placeholder="example@gmail.com" />
        </div>
        <button type="submit" class="btn-submit">Gui ma OTP qua Email</button>
    </form>
    <div class="footer-links">
        <a href="<c:url value='/login'/>">Quay ve trang Dang nhap</a>
    </div>
</div>
</body>
</html>
