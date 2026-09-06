<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm - Admin</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">DANH SÁCH SẢN PHẨM</h4>
            <p class="text-muted small mb-0">Quản lý tất cả sản phẩm trong cơ sở dữ liệu</p>
        </div>
        <a href="<c:url value='/admin/product/add'/>" class="btn btn-primary fw-semibold">
            Thêm sản phẩm mới
        </a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 50px;">ID</th>
                            <th style="width: 90px;">Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Đơn giá</th>
                            <th class="text-center">Số lượng</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center" style="width: 150px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${products}" var="p">
                            <tr>
                                <td class="text-center fw-bold text-muted">${p.productId}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.images and p.images.startsWith('http')}">
                                            <img src="${p.images}" class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="${p.productName}" />
                                        </c:when>
                                        <c:when test="${not empty p.images}">
                                            <img src="<c:url value='/image?fname=${p.images}'/>" class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="${p.productName}" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="<c:url value='/image?fname=avatar.png'/>" class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="${p.productName}" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="fw-bold text-dark">${p.productName}</div>
                                    <div class="text-muted small text-truncate" style="max-width: 250px;">${p.description}</div>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border">
                                        ${p.category != null ? p.category.categoryname : 'Chưa phân loại'}
                                    </span>
                                </td>
                                <td class="fw-bold text-danger">
                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" /> VND
                                </td>
                                <td class="text-center">${p.quantity}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.status == 1}">
                                            <span class="badge bg-success">Kinh doanh</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Tạm ngưng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-sm btn-outline-primary me-1">Sửa</a>
                                    <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty products}">
                            <tr>
                                <td colspan="8" class="text-center py-4 text-muted">Chưa có sản phẩm nào trong hệ thống.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
