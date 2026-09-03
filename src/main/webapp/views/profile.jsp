<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - Quản lý tài khoản</title>
    <style>
        .profile-container {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 25px;
            margin-top: 10px;
        }
        @media (max-width: 768px) {
            .profile-container {
                grid-template-columns: 1fr;
            }
        }
        .card {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            border: 1px solid #e2e8f0;
            padding: 24px;
        }
        .user-card {
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .avatar-wrapper {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 18px;
            border-radius: 50%;
            overflow: hidden;
            box-shadow: 0 4px 14px rgba(0,0,0,0.12);
            border: 4px solid #0d6efd;
            background: #f8f9fa;
        }
        .avatar-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .user-card h3 {
            margin: 0 0 5px;
            color: #1e293b;
            font-size: 20px;
        }
        .user-card p {
            margin: 4px 0;
            color: #64748b;
            font-size: 14px;
        }
        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-top: 10px;
        }
        .badge-success {
            background-color: #dcfce7;
            color: #166534;
        }
        .badge-warning {
            background-color: #fef9c3;
            color: #854d0e;
        }
        .form-title {
            margin: 0 0 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid #0d6efd;
            color: #0f172a;
            font-size: 18px;
            font-weight: 700;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 14px;
            color: #334155;
        }
        .form-group label .required {
            color: #dc2626;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
            background-color: #ffffff;
        }
        .form-control:focus {
            outline: none;
            border-color: #0d6efd;
            box-shadow: 0 0 0 3px rgba(13,110,253,0.15);
        }
        .form-control[readonly] {
            background-color: #f1f5f9;
            color: #64748b;
            cursor: not-allowed;
        }
        .form-hint {
            font-size: 12px;
            color: #64748b;
            margin-top: 4px;
        }
        .file-upload-box {
            border: 2px dashed #cbd5e1;
            border-radius: 6px;
            padding: 15px;
            text-align: center;
            background: #f8fafc;
            margin-top: 6px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .file-upload-box:hover {
            border-color: #0d6efd;
            background: #f0f7ff;
        }
        .btn-container {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            padding: 10px 22px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            border: none;
            transition: background-color 0.2s, transform 0.1s;
        }
        .btn-primary {
            background-color: #0d6efd;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
        .btn-secondary {
            background-color: #64748b;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #475569;
        }
        .alert {
            padding: 12px 18px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            display: block;
        }
        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }
        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
    </style>
</head>
<body>

    <c:if test="${not empty message}">
        <div class="alert alert-success">
            ${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>

    <div class="profile-container">
        <!-- Cot thong tin Avatar & User Card -->
        <div class="card user-card">
            <div class="avatar-wrapper">
                <c:choose>
                    <c:when test="${not empty user.images and user.images.substring(0,4) == 'http'}">
                        <img id="avatarPreview" src="${user.images}" class="avatar-img" alt="User Avatar" />
                    </c:when>
                    <c:when test="${not empty user.images}">
                        <img id="avatarPreview" src="<c:url value='/image?fname=${user.images}'/>" class="avatar-img" alt="User Avatar" />
                    </c:when>
                    <c:otherwise>
                        <img id="avatarPreview" src="<c:url value='/image?fname=avatar.png'/>" class="avatar-img" alt="User Avatar" />
                    </c:otherwise>
                </c:choose>
            </div>
            <h3>${not empty user.fullname ? user.fullname : user.username}</h3>
            <p><strong>Username:</strong> @${user.username}</p>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Phone:</strong> ${not empty user.phone ? user.phone : 'Chưa cập nhật'}</p>
            <div>
                <c:choose>
                    <c:when test="${user.status == 1}">
                        <span class="badge badge-success">Tài khoản đã kích hoạt</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-warning">Chờ kích hoạt</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Cot Form cap nhat profile (JPA & Multipart Upload) -->
        <div class="card">
            <h2 class="form-title">CẬP NHẬT HỒ SƠ CÁ NHÂN (JPA & MULTIPART)</h2>
            <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data">
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div class="form-group">
                        <label>Tên đăng nhập (Username):</label>
                        <input type="text" class="form-control" value="${user.username}" readonly />
                        <div class="form-hint">Tên đăng nhập không thể thay đổi</div>
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ Email:</label>
                        <input type="text" class="form-control" value="${user.email}" readonly />
                        <div class="form-hint">Email xác thực tài khoản</div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Họ và tên (Fullname): <span class="required">*</span></label>
                    <input type="text" name="fullname" class="form-control" value="${user.fullname}" required placeholder="Nhập họ và tên đầy đủ..." />
                </div>

                <div class="form-group">
                    <label>Số điện thoại (Phone):</label>
                    <input type="text" name="phone" class="form-control" value="${user.phone}" placeholder="Nhập số điện thoại (ví dụ: 0987654321)..." />
                </div>

                <div class="form-group">
                    <label>Tải lên ảnh đại diện mới (Multipart File Upload):</label>
                    <div class="file-upload-box">
                        <input type="file" name="images1" id="fileUploadInput" accept="image/*" onchange="previewSelectedFile(this)" />
                        <div class="form-hint" style="margin-top: 6px;">Hỗ trợ: JPG, PNG, GIF, WebP (Tối đa 5MB)</div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Hoặc nhập URL hình ảnh online:</label>
                    <input type="text" name="images" id="imagesUrlInput" class="form-control" value="${user.images}" placeholder="https://example.com/avatar.jpg" oninput="previewUrlImage(this.value)" />
                </div>

                <div class="btn-container">
                    <button type="submit" class="btn btn-primary">Cập nhật hồ sơ</button>
                    <a href="<c:url value='/home'/>" class="btn btn-secondary">Quay lại trang chủ</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function previewSelectedFile(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var preview = document.getElementById('avatarPreview');
                    if (preview) {
                        preview.src = e.target.result;
                    }
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function previewUrlImage(url) {
            if (url && url.trim().length > 5 && url.startsWith('http')) {
                var preview = document.getElementById('avatarPreview');
                if (preview) {
                    preview.src = url.trim();
                }
            }
        }
    </script>
</body>
</html>
