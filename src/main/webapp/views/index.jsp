<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chu - He thong quan ly</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; }
        .header { background-color: #007bff; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; font-size: 20px; }
        .header .nav a { color: white; text-decoration: none; margin-left: 15px; font-size: 14px; font-weight: bold; }
        .container { max-width: 1100px; margin: 25px auto; padding: 0 15px; }
        .quick-nav { background: white; padding: 15px 20px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 25px; display: flex; gap: 15px; flex-wrap: wrap; }
        .quick-nav a { display: inline-block; padding: 8px 16px; background-color: #e9ecef; color: #495057; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 14px; }
        .quick-nav a:hover { background-color: #007bff; color: white; }
        .section-title { font-size: 18px; margin-bottom: 15px; padding-bottom: 8px; border-bottom: 2px solid #007bff; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 18px; }
        .product-card { background: white; border: 1px solid #e0e0e0; border-radius: 6px; padding: 12px; text-decoration: none; color: inherit; display: flex; flex-direction: column; transition: transform 0.2s, box-shadow 0.2s; }
        .product-card:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.12); }
        .product-img { width: 100%; height: 140px; object-fit: contain; background: #fdfdfd; border-radius: 4px; margin-bottom: 10px; }
        .product-name { font-weight: bold; font-size: 14px; margin-bottom: 6px; line-height: 1.3; height: 36px; overflow: hidden; }
        .product-category { font-size: 12px; color: #6c757d; margin-bottom: 6px; }
        .product-price { font-size: 15px; color: #dc3545; font-weight: bold; margin-top: auto; }
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
        <a href="<c:url value='/home'/>" style="background-color: #007bff; color: white;">Trang chu</a>
        <a href="<c:url value='/product'/>">Xem tat ca san pham</a>
        <a href="<c:url value='/admin/categories'/>">Quan tri Danh muc</a>
        <a href="<c:url value='/admin/products'/>">Quan tri San pham</a>
    </div>

    <h2 class="section-title">TOP 10 SAN PHAM MOI NHAT</h2>

    <div class="product-grid">
        <c:forEach var="p" items="${top10Products}">
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
</div>

</body>
</html>
