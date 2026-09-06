<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới - Admin</title>
</head>
<body>

    <div class="mb-4">
        <h4 class="fw-bold mb-1">THÊM DANH MỤC SẢN PHẨM</h4>
        <p class="text-muted small mb-0">Tạo danh mục mới trong cơ sở dữ liệu</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Lỗi:</strong> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0" style="max-width: 700px;">
        <div class="card-body p-4">
            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Tên danh mục: <span class="text-danger">*</span></label>
                    <input type="text" name="categoryname" class="form-control" required minlength="2" placeholder="Nhập tên danh mục (ví dụ: Điện thoại, Laptop)..." />
                    <div class="invalid-feedback small">Vui lòng nhập tên danh mục (tối thiểu 2 ký tự).</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Trạng thái hoạt động:</label>
                    <select name="status" class="form-select">
                        <option value="1" selected>Hoạt động</option>
                        <option value="0">Tạm khóa</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Tải lên hình ảnh (Multipart File):</label>
                    <input type="file" name="images1" class="form-control" accept="image/*" />
                    <div class="form-text small">Hỗ trợ: JPG, PNG, GIF, WebP.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold small">Hoặc nhập URL hình ảnh online:</label>
                    <input type="url" name="images" class="form-control" placeholder="https://example.com/image.jpg" />
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">Lưu danh mục</button>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">Hủy bỏ</a>
                </div>
            </form>
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
