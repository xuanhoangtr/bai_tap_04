<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm - Phân trang 6sp/trang</title>
</head>
<body>

    <!-- Header & Info -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h4 class="fw-bold text-dark border-start border-4 border-primary ps-3 mb-1">
                TẤT CẢ SẢN PHẨM
            </h4>
            <p class="text-muted small mb-0 ps-3">
                Trang ${currentPage} / ${totalPages} &mdash; Tổng cộng ${totalCount} sản phẩm
            </p>
        </div>
        <div>
            <a href="<c:url value='/admin/product/add'/>" class="btn btn-outline-primary btn-sm fw-semibold">
                Thêm sản phẩm mới (Admin)
            </a>
        </div>
    </div>

    <!-- Product Grid (6 items per page) -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-5">
        <c:forEach var="p" items="${products}">
            <div class="col">
                <div class="card h-100 shadow-sm border-0 product-card">
                    <c:choose>
                        <c:when test="${not empty p.images and p.images.startsWith('http')}">
                            <img src="${p.images}" alt="${p.productName}" class="card-img-top p-3" style="height: 200px; object-fit: contain;" />
                        </c:when>
                        <c:when test="${not empty p.images}">
                            <img src="<c:url value='/image?fname=${p.images}'/>" alt="${p.productName}" class="card-img-top p-3" style="height: 200px; object-fit: contain;" />
                        </c:when>
                        <c:otherwise>
                            <img src="<c:url value='/image?fname=avatar.png'/>" alt="${p.productName}" class="card-img-top p-3" style="height: 200px; object-fit: contain;" />
                        </c:otherwise>
                    </c:choose>

                    <div class="card-body d-flex flex-column p-3">
                        <span class="badge bg-light text-muted border text-start mb-2" style="width: fit-content;">
                            ${p.category != null ? p.category.categoryname : 'Chưa phân loại'}
                        </span>
                        <h5 class="card-title fw-bold text-truncate mb-2" title="${p.productName}">
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-decoration-none text-dark">
                                ${p.productName}
                            </a>
                        </h5>
                        <p class="card-text text-muted small text-truncate mb-3">${p.description}</p>
                        
                        <div class="mt-auto pt-2 border-top d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-danger fs-5">${p.formattedPrice}</span>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-primary btn-sm">
                                Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty products}">
            <div class="col-12 text-center py-5 text-muted">
                Không có sản phẩm nào trong danh sách.
            </div>
        </c:if>
    </div>

    <!-- Bootstrap 5 Pagination -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="d-flex justify-content-center mb-4">
            <ul class="pagination">
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage - 1}'/>">Trang trước</a>
                </li>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>

                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage + 1}'/>">Trang sau</a>
                </li>
            </ul>
        </nav>
    </c:if>

</body>
</html>
