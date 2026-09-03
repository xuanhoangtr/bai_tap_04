<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dang nhap</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; margin: 0; padding: 40px; }
        .card { max-width: 380px; margin: 0 auto; background: #fff; padding: 25px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .remember-group { display: flex; align-items: center; justify-content: space-between; margin-bottom: 15px; font-size: 14px; }
        .btn-submit { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background-color: #0056b3; }
        .alert { padding: 10px; margin-bottom: 15px; border-radius: 4px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; font-size: 14px; }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .footer-links { margin-top: 15px; text-align: center; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; margin: 0 5px; }
    </style>
</head>
<body>
<div class="card">
    <h2>Dang nhap he thong</h2>

    <c:if test="${not empty successAlert}">
        <div class="alert alert-success">${successAlert}</div>
    </c:if>
    <c:if test="${not empty alert}">
        <div class="alert">${alert}</div>
    </c:if>

    <form action="<c:url value='/login'/>" method="post">
        <div class="form-group">
            <label>Ten dang nhap:</label>
            <input type="text" name="username" value="${not empty rememberUser ? rememberUser : ''}" required placeholder="Nhap username" />
        </div>
        <div class="form-group">
            <label>Mat khau:</label>
            <input type="password" name="password" required placeholder="Nhap mat khau" />
        </div>
        <div class="remember-group">
            <label style="font-weight: normal; margin-bottom: 0; display: flex; align-items: center;">
                <input type="checkbox" name="remember" ${not empty rememberUser ? 'checked' : ''} style="margin-right: 5px;" />
                Remember me
            </label>
            <a href="<c:url value='/forgot-password'/>" style="color: #6c757d; text-decoration: none;">Quen mat khau?</a>
        </div>
        <button type="submit" class="btn-submit">Dang nhap</button>
    </form>

    <div class="footer-links">
        Chua co tai khoan? <a href="<c:url value='/register'/>"><b>Dang ky ngay</b></a>
        <br/><br/>
        <a href="<c:url value='/home'/>">Ve trang chu</a>
    </div>
</div>
</body>
</html>
