<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới - Admin</title>
</head>
<body>

    <div class="mb-4">
        <h4 class="fw-bold mb-1">THÊM SẢN PHẨM MỚI</h4>
        <p class="text-muted small mb-0">Thêm sản phẩm mới vào hệ thống bán hàng</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Lỗi:</strong> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0" style="max-width: 800px;">
        <div class="card-body p-4">
            <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="row g-3 mb-3">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold small">Tên sản phẩm: <span class="text-danger">*</span></label>
                        <input type="text" name="productName" class="form-control" required minlength="2" placeholder="Nhập tên sản phẩm..." />
                        <div class="invalid-feedback small">Vui lòng nhập tên sản phẩm (tối thiểu 2 ký tự).</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Danh mục: <span class="text-danger">*</span></label>
                        <select name="categoryId" class="form-select" required>
                            <option value="" disabled selected>-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.categoryid}">${c.categoryname}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback small">Vui lòng chọn danh mục.</div>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Đơn giá (VND): <span class="text-danger">*</span></label>
                        <input type="number" step="1000" min="0" name="price" class="form-control" required placeholder="Ví dụ: 15000000" />
                        <div class="invalid-feedback small">Đơn giá phải là số dương hợp lệ.</div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Số lượng:</label>
                        <input type="number" min="0" name="quantity" class="form-control" value="10" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Trạng thái:</label>
                        <select name="status" class="form-select">
                            <option value="1" selected>Kinh doanh</option>
                            <option value="0">Tạm ngưng</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Mô tả sản phẩm:</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="Nhập thông tin chi tiết sản phẩm..."></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Tải lên ảnh sản phẩm (Multipart File):</label>
                    <input type="file" name="images1" class="form-control" accept="image/*" />
                    <div class="form-text small">Hỗ trợ: JPG, PNG, GIF, WebP.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold small">Hoặc nhập URL hình ảnh online:</label>
                    <input type="url" name="images" class="form-control" placeholder="https://example.com/product.jpg" />
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">Lưu sản phẩm</button>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">Hủy bỏ</a>
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
