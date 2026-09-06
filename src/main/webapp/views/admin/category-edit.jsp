<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục - Admin</title>
</head>
<body>

    <div class="mb-4">
        <h4 class="fw-bold mb-1">CHỈNH SỬA DANH MỤC</h4>
        <p class="text-muted small mb-0">Cập nhật thông tin danh mục #${cate.categoryid}</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Lỗi:</strong> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0" style="max-width: 700px;">
        <div class="card-body p-4">
            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="categoryid" value="${cate.categoryid}" />

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Tên danh mục: <span class="text-danger">*</span></label>
                    <input type="text" name="categoryname" class="form-control" value="${cate.categoryname}" required minlength="2" placeholder="Nhập tên danh mục..." />
                    <div class="invalid-feedback small">Vui lòng nhập tên danh mục (tối thiểu 2 ký tự).</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Trạng thái hoạt động:</label>
                    <select name="status" class="form-select">
                        <option value="1" ${cate.status == 1 ? 'selected' : ''}>Hoạt động</option>
                        <option value="0" ${cate.status == 0 ? 'selected' : ''}>Tạm khóa</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Hình ảnh hiện tại:</label>
                    <div class="mb-2">
                        <c:choose>
                            <c:when test="${not empty cate.images and cate.images.startsWith('http')}">
                                <img src="${cate.images}" class="rounded border" style="width: 80px; height: 80px; object-fit: cover;" alt="Category" />
                            </c:when>
                            <c:when test="${not empty cate.images}">
                                <img src="<c:url value='/image?fname=${cate.images}'/>" class="rounded border" style="width: 80px; height: 80px; object-fit: cover;" alt="Category" />
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/image?fname=avatar.png'/>" class="rounded border" style="width: 80px; height: 80px; object-fit: cover;" alt="Category" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <input type="file" name="images1" class="form-control" accept="image/*" />
                    <div class="form-text small">Chọn file ảnh mới nếu muốn thay thế ảnh cũ.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold small">Hoặc cập nhật URL hình ảnh:</label>
                    <input type="url" name="images" class="form-control" value="${cate.images.startsWith('http') ? cate.images : ''}" placeholder="https://example.com/image.jpg" />
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">Cập nhật</button>
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
