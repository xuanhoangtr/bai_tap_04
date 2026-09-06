<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - Quản lý tài khoản</title>
    <style>
        .profile-avatar-lg {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #0d6efd;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        }
    </style>
</head>
<body>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>Thành công!</strong> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Lỗi:</strong> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Cột thông tin Avatar & User Info Card -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0 text-center p-4">
                <div class="mb-3">
                    <c:choose>
                        <c:when test="${not empty user.images and user.images.startsWith('http')}">
                            <img id="avatarPreview" src="${user.images}" class="profile-avatar-lg" alt="User Avatar" />
                        </c:when>
                        <c:when test="${not empty user.images}">
                            <img id="avatarPreview" src="<c:url value='/image?fname=${user.images}'/>" class="profile-avatar-lg" alt="User Avatar" />
                        </c:when>
                        <c:otherwise>
                            <img id="avatarPreview" src="<c:url value='/image?fname=avatar.png'/>" class="profile-avatar-lg" alt="User Avatar" />
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <h4 class="fw-bold mb-1">${not empty user.fullname ? user.fullname : user.username}</h4>
                <p class="text-muted small mb-3">@${user.username}</p>
                
                <ul class="list-group list-group-flush text-start small">
                    <li class="list-group-item d-flex justify-content-between px-0">
                        <span class="text-muted">Email:</span>
                        <span class="fw-semibold">${user.email}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between px-0">
                        <span class="text-muted">Số điện thoại:</span>
                        <span class="fw-semibold">${not empty user.phone ? user.phone : 'Chưa cập nhật'}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between px-0">
                        <span class="text-muted">Trạng thái:</span>
                        <c:choose>
                            <c:when test="${user.status == 1}">
                                <span class="badge bg-success">Đã kích hoạt</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning text-dark">Chờ kích hoạt</span>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Cột Form cập nhật profile (JPA & Multipart Upload) -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 p-4">
                <h5 class="fw-bold text-primary border-bottom pb-2 mb-4">
                    CẬP NHẬT HỒ SƠ CÁ NHÂN (JPA &amp; MULTIPART)
                </h5>

                <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="profileForm">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Tên đăng nhập (Username):</label>
                            <input type="text" class="form-control bg-light" value="${user.username}" readonly />
                            <div class="form-text small">Tên đăng nhập không thể thay đổi.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Địa chỉ Email:</label>
                            <input type="text" class="form-control bg-light" value="${user.email}" readonly />
                            <div class="form-text small">Email xác thực tài khoản.</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Họ và tên (Fullname): <span class="text-danger">*</span></label>
                        <input type="text" name="fullname" class="form-control" value="${user.fullname}" required minlength="2" placeholder="Nhập họ và tên đầy đủ..." />
                        <div class="invalid-feedback small">Vui lòng nhập họ và tên (tối thiểu 2 ký tự).</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Số điện thoại (Phone):</label>
                        <input type="tel" name="phone" class="form-control" value="${user.phone}" pattern="^0[0-9]{9}$" placeholder="0987654321 (10 chữ số)" />
                        <div class="invalid-feedback small">Số điện thoại phải gồm 10 chữ số (bắt đầu bằng 0).</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Tải lên ảnh đại diện mới (Multipart File):</label>
                        <input type="file" name="images1" id="fileUploadInput" class="form-control" accept="image/*" onchange="previewSelectedFile(this)" />
                        <div class="form-text small">Hỗ trợ các định dạng: JPG, PNG, GIF, WebP (Dung lượng tối đa: 5MB).</div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small">Hoặc nhập URL hình ảnh online:</label>
                        <input type="url" name="images" id="imagesUrlInput" class="form-control" value="${user.images}" placeholder="https://example.com/avatar.jpg" oninput="previewUrlImage(this.value)" />
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4 fw-semibold">Cập nhật hồ sơ</button>
                        <a href="<c:url value='/home'/>" class="btn btn-outline-secondary">Quay lại trang chủ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Preview file upload
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

        // Preview image URL
        function previewUrlImage(url) {
            if (url && url.trim().length > 5 && (url.startsWith('http://') || url.startsWith('https://'))) {
                var preview = document.getElementById('avatarPreview');
                if (preview) {
                    preview.src = url.trim();
                }
            }
        }

        // Bootstrap Client Validation
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
