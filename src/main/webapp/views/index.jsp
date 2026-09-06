<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Hệ thống bán hàng</title>
</head>
<body>

    <!-- Hero / Banner Section -->
    <div class="p-4 p-md-5 mb-4 rounded text-bg-primary shadow-sm">
        <div class="col-md-8 px-0">
            <h1 class="display-6 fw-bold">CHÀO MỪNG ĐẾN VỚI HỆ THỐNG BÁN HÀNG</h1>
            <p class="lead my-3">Nền tảng thương mại điện tử tích hợp JPA Hibernate, Jakarta EE và SiteMesh 3 Decorator với giao diện Bootstrap 5.</p>
            <a href="<c:url value='/product'/>" class="btn btn-light btn-lg fw-bold text-primary">Khám phá tất cả sản phẩm</a>
        </div>
    </div>

    <!-- Section Title -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold text-dark border-start border-4 border-primary ps-3 mb-0">TOP 10 SẢN PHẨM MỚI NHẤT</h4>
        <a href="<c:url value='/product'/>" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
    </div>

    <!-- Products Grid -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-3 mb-4">
        <c:forEach var="p" items="${top10Products}">
            <div class="col">
                <div class="card h-100 shadow-sm border-0 product-card">
                    <c:choose>
                        <c:when test="${not empty p.images and p.images.startsWith('http')}">
                            <img src="${p.images}" alt="${p.productName}" class="card-img-top p-2" style="height: 160px; object-fit: contain;" />
                        </c:when>
                        <c:when test="${not empty p.images}">
                            <img src="<c:url value='/image?fname=${p.images}'/>" alt="${p.productName}" class="card-img-top p-2" style="height: 160px; object-fit: contain;" />
                        </c:when>
                        <c:otherwise>
                            <img src="<c:url value='/image?fname=avatar.png'/>" alt="${p.productName}" class="card-img-top p-2" style="height: 160px; object-fit: contain;" />
                        </c:otherwise>
                    </c:choose>
                    <div class="card-body d-flex flex-column p-3">
                        <span class="badge bg-light text-muted border text-start mb-2" style="width: fit-content;">
                            ${p.category != null ? p.category.categoryname : 'Chưa phân loại'}
                        </span>
                        <h6 class="card-title fw-bold text-truncate mb-1" title="${p.productName}">
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-decoration-none text-dark">
                                ${p.productName}
                            </a>
                        </h6>
                        <div class="mt-auto pt-2">
                            <div class="fw-bold text-danger fs-6">${p.formattedPrice}</div>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary btn-sm w-100 mt-2">
                                Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty top10Products}">
            <div class="col-12 text-center py-5 text-muted">
                Chưa có sản phẩm nào trong hệ thống.
            </div>
        </c:if>
    </div>

</body>
</html>
