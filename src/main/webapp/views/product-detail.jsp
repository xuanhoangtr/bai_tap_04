<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết: ${product.productName}</title>
</head>
<body>

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/product'/>" class="text-decoration-none">Sản phẩm</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <!-- Product Detail Card -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-4">
            <div class="row g-4">
                <!-- Product Image -->
                <div class="col-md-5 text-center">
                    <div class="border rounded p-3 bg-light d-flex align-items-center justify-content-center" style="min-height: 320px;">
                        <c:choose>
                            <c:when test="${not empty product.images and product.images.startsWith('http')}">
                                <img src="${product.images}" alt="${product.productName}" class="img-fluid rounded" style="max-height: 300px; object-fit: contain;" />
                            </c:when>
                            <c:when test="${not empty product.images}">
                                <img src="<c:url value='/image?fname=${product.images}'/>" alt="${product.productName}" class="img-fluid rounded" style="max-height: 300px; object-fit: contain;" />
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/image?fname=avatar.png'/>" alt="${product.productName}" class="img-fluid rounded" style="max-height: 300px; object-fit: contain;" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Product Info -->
                <div class="col-md-7">
                    <span class="badge bg-primary mb-2">
                        ${product.category != null ? product.category.categoryname : 'Chưa phân loại'}
                    </span>
                    <h3 class="fw-bold mb-2 text-dark">${product.productName}</h3>
                    
                    <div class="h3 text-danger fw-bold my-3">
                        ${product.formattedPrice}
                    </div>

                    <ul class="list-group list-group-flush mb-4 small">
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted">Mã sản phẩm:</span>
                            <span class="fw-semibold">#${product.productId}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted">Số lượng tồn kho:</span>
                            <span class="fw-semibold">${product.quantity} sản phẩm</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted">Trạng thái:</span>
                            <c:choose>
                                <c:when test="${product.status == 1}">
                                    <span class="badge bg-success">Đang kinh doanh</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Tạm ngưng</span>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </ul>

                    <div class="mb-4">
                        <h6 class="fw-bold text-dark mb-2">Mô tả sản phẩm:</h6>
                        <div class="p-3 bg-light rounded text-muted small">
                            ${not empty product.description ? product.description : 'Không có mô tả chi tiết cho sản phẩm này.'}
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <a href="<c:url value='/product'/>" class="btn btn-outline-secondary">
                            Quay lại danh sách
                        </a>
                        <a href="<c:url value='/admin/product/edit?id=${product.productId}'/>" class="btn btn-outline-primary">
                            Chỉnh sửa sản phẩm (Admin)
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
