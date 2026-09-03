<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dang ky tai khoan</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; margin: 0; padding: 40px; }
        .card { max-width: 420px; margin: 0 auto; background: #fff; padding: 25px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        input[type="text"], input[type="password"], input[type="email"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background-color: #0056b3; }
        .alert { padding: 10px; margin-bottom: 15px; border-radius: 4px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; font-size: 14px; }
        .footer-links { margin-top: 15px; text-align: center; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Dang ky tai khoan</h2>
    <c:if test="${not empty alert}">
        <div class="alert">${alert}</div>
    </c:if>
    <form action="<c:url value='/register'/>" method="post">
        <div class="form-group">
            <label>Ten dang nhap:</label>
            <input type="text" name="username" required placeholder="Nhap ten dang nhap" />
        </div>
        <div class="form-group">
            <label>Ho va ten:</label>
            <input type="text" name="fullname" required placeholder="Nhap ho va ten" />
        </div>
        <div class="form-group">
            <label>Email (nhan ma OTP):</label>
            <input type="email" name="email" required placeholder="example@gmail.com" />
        </div>
        <div class="form-group">
            <label>Mat khau:</label>
            <input type="password" name="password" required placeholder="Nhap mat khau" />
        </div>
        <button type="submit" class="btn-submit">Dang ky & Nhan ma OTP</button>
    </form>
    <div class="footer-links">
        Da co tai khoan? <a href="<c:url value='/login'/>">Dang nhap ngay</a>
    </div>
</div>
</body>
</html>
