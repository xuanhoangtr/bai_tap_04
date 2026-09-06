<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sản phẩm - Admin</title>
</head>
<body>

    <div class="mb-4">
        <h4 class="fw-bold mb-1">CHỈNH SỬA SẢN PHẨM</h4>
        <p class="text-muted small mb-0">Cập nhật thông tin sản phẩm #${product.productId}</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Lỗi:</strong> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0" style="max-width: 800px;">
        <div class="card-body p-4">
            <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="productId" value="${product.productId}" />

                <div class="row g-3 mb-3">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold small">Tên sản phẩm: <span class="text-danger">*</span></label>
                        <input type="text" name="productName" class="form-control" value="${product.productName}" required minlength="2" placeholder="Nhập tên sản phẩm..." />
                        <div class="invalid-feedback small">Vui lòng nhập tên sản phẩm (tối thiểu 2 ký tự).</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Danh mục: <span class="text-danger">*</span></label>
                        <select name="categoryId" class="form-select" required>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.categoryid}" ${product.category != null && product.category.categoryid == c.categoryid ? 'selected' : ''}>
                                    ${c.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback small">Vui lòng chọn danh mục.</div>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Đơn giá (VND): <span class="text-danger">*</span></label>
                        <input type="number" step="1000" min="0" name="price" class="form-control" value="${product.price}" required placeholder="Ví dụ: 15000000" />
                        <div class="invalid-feedback small">Đơn giá phải là số dương hợp lệ.</div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Số lượng:</label>
                        <input type="number" min="0" name="quantity" class="form-control" value="${product.quantity}" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Trạng thái:</label>
                        <select name="status" class="form-select">
                            <option value="1" ${product.status == 1 ? 'selected' : ''}>Kinh doanh</option>
                            <option value="0" ${product.status == 0 ? 'selected' : ''}>Tạm ngưng</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Mô tả sản phẩm:</label>
                    <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small">Hình ảnh hiện tại:</label>
                    <div class="mb-2">
                        <c:choose>
                            <c:when test="${not empty product.images and product.images.startsWith('http')}">
                                <img src="${product.images}" class="rounded border" style="width: 80px; height: 80px; object-fit: cover;" alt="${product.productName}" />
                            </c:when>
                            <c:when test="${not empty product.images}">
                                <img src="<c:url value='/image?fname=${product.images}'/>" class="rounded border" style="width: 80px; height: 80px; object-fit: cover;" alt="${product.productName}" />
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/image?fname=avatar.png'/>" class="rounded border" style="width: 80px; height: 80px; object-fit: cover;" alt="${product.productName}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <input type="file" name="images1" class="form-control" accept="image/*" />
                    <div class="form-text small">Chọn file nếu muốn thay thế ảnh cũ.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold small">Hoặc cập nhật URL hình ảnh:</label>
                    <input type="url" name="images" class="form-control" value="${product.images.startsWith('http') ? product.images : ''}" placeholder="https://example.com/product.jpg" />
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">Cập nhật sản phẩm</button>
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
