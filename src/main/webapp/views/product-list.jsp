<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sach san pham - Phan trang 6sp/trang</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; }
        .header { background-color: #007bff; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; font-size: 20px; }
        .header .nav a { color: white; text-decoration: none; margin-left: 15px; font-size: 14px; font-weight: bold; }
        .container { max-width: 1100px; margin: 25px auto; padding: 0 15px; }
        .quick-nav { background: white; padding: 15px 20px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 25px; display: flex; gap: 15px; flex-wrap: wrap; }
        .quick-nav a { display: inline-block; padding: 8px 16px; background-color: #e9ecef; color: #495057; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 14px; }
        .quick-nav a:hover { background-color: #007bff; color: white; }
        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; padding-bottom: 8px; border-bottom: 2px solid #007bff; }
        .section-header h2 { margin: 0; font-size: 18px; }
        .product-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .product-card { background: white; border: 1px solid #e0e0e0; border-radius: 6px; padding: 16px; text-decoration: none; color: inherit; display: flex; flex-direction: column; transition: transform 0.2s, box-shadow 0.2s; }
        .product-card:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.12); }
        .product-img { width: 100%; height: 180px; object-fit: contain; background: #fdfdfd; border-radius: 4px; margin-bottom: 12px; }
        .product-name { font-weight: bold; font-size: 16px; margin-bottom: 8px; }
        .product-category { font-size: 13px; color: #6c757d; margin-bottom: 8px; }
        .product-price { font-size: 16px; color: #dc3545; font-weight: bold; margin-top: auto; }
        .pagination { display: flex; justify-content: center; align-items: center; margin-top: 30px; gap: 6px; }
        .pagination a, .pagination span { display: inline-block; padding: 8px 14px; border: 1px solid #dee2e6; border-radius: 4px; color: #007bff; text-decoration: none; font-size: 14px; font-weight: bold; }
        .pagination a:hover { background-color: #e9ecef; }
        .pagination .active { background-color: #007bff; color: white; border-color: #007bff; }
        .pagination .disabled { color: #6c757d; pointer-events: none; background-color: #f8f9fa; }
    </style>
</head>
<body>

<div class="header">
    <h1>HE THONG QUAN LY BAN HANG</h1>
    <div class="nav">
        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <span>Xin chao, ${sessionScope.account.fullName}</span> |
                <a href="<c:url value='/logout'/>">Dang xuat</a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/login'/>">Dang nhap</a>
                <a href="<c:url value='/register'/>">Dang ky</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="container">
    <div class="quick-nav">
        <a href="<c:url value='/home'/>">Trang chu</a>
        <a href="<c:url value='/product'/>" style="background-color: #007bff; color: white;">Xem tat ca san pham</a>
        <a href="<c:url value='/admin/categories'/>">Quan tri Danh muc</a>
        <a href="<c:url value='/admin/products'/>">Quan tri San pham</a>
    </div>

    <div class="section-header">
        <h2>TAT CA SAN PHAM (Trang ${currentPage} / ${totalPages} - Tong: ${totalCount} san pham)</h2>
    </div>

    <div class="product-grid">
        <c:forEach var="p" items="${products}">
            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="product-card">
                <c:choose>
                    <c:when test="${p.images.substring(0,5) == 'https'}">
                        <img src="${p.images}" alt="${p.productName}" class="product-img" />
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${p.images}" var="imgUrl"/>
                        <img src="${imgUrl}" alt="${p.productName}" class="product-img" />
                    </c:otherwise>
                </c:choose>
                <div class="product-name">${p.productName}</div>
                <div class="product-category">Danh muc: ${p.category != null ? p.category.categoryname : 'Chua phan loai'}</div>
                <div class="product-price">${p.formattedPrice}</div>
            </a>
        </c:forEach>
    </div>

    <!-- Thanh phan trang (6 san pham / trang) -->
    <div class="pagination">
        <c:choose>
            <c:when test="${currentPage > 1}">
                <a href="<c:url value='/product?page=${currentPage - 1}'/>">Trang truoc</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">Trang truoc</span>
            </c:otherwise>
        </c:choose>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="active">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/product?page=${i}'/>">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="<c:url value='/product?page=${currentPage + 1}'/>">Trang sau</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">Trang sau</span>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>
