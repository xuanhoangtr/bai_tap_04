<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiet san pham: ${product.productName}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; }
        .header { background-color: #007bff; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; font-size: 20px; }
        .header .nav a { color: white; text-decoration: none; margin-left: 15px; font-size: 14px; font-weight: bold; }
        .container { max-width: 900px; margin: 30px auto; padding: 0 15px; }
        .breadcrumb { margin-bottom: 20px; font-size: 14px; color: #6c757d; }
        .breadcrumb a { color: #007bff; text-decoration: none; }
        .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); display: flex; gap: 30px; }
        .img-col { flex: 0 0 320px; text-align: center; }
        .img-col img { width: 100%; max-height: 320px; object-fit: contain; border-radius: 6px; border: 1px solid #eee; }
        .info-col { flex: 1; display: flex; flex-direction: column; }
        .info-col h2 { margin-top: 0; margin-bottom: 10px; font-size: 24px; color: #222; }
        .category-badge { display: inline-block; background-color: #e9ecef; color: #495057; padding: 4px 10px; border-radius: 12px; font-size: 12px; margin-bottom: 15px; font-weight: bold; }
        .price { font-size: 24px; color: #dc3545; font-weight: bold; margin-bottom: 15px; }
        .meta-info { font-size: 14px; color: #555; margin-bottom: 15px; line-height: 1.6; }
        .desc-box { background: #fdfdfd; padding: 15px; border-radius: 4px; border: 1px solid #eee; margin-top: 15px; font-size: 14px; line-height: 1.6; color: #444; }
        .back-btn { display: inline-block; padding: 10px 20px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 4px; margin-top: 20px; align-self: flex-start; font-weight: bold; }
        .back-btn:hover { background-color: #5a6268; }
    </style>
</head>
<body>

<div class="header">
    <h1>HE THONG QUAN LY BAN HANG</h1>
    <div class="nav">
        <a href="<c:url value='/home'/>">Trang chu</a>
        <a href="<c:url value='/product'/>">Tat ca san pham</a>
    </div>
</div>

<div class="container">
    <div class="breadcrumb">
        <a href="<c:url value='/home'/>">Trang chu</a> /
        <a href="<c:url value='/product'/>">San pham</a> /
        <span>${product.productName}</span>
    </div>

    <div class="card">
        <div class="img-col">
            <c:choose>
                <c:when test="${product.images.substring(0,5) == 'https'}">
                    <img src="${product.images}" alt="${product.productName}" />
                </c:when>
                <c:otherwise>
                    <c:url value="/image?fname=${product.images}" var="imgUrl"/>
                    <img src="${imgUrl}" alt="${product.productName}" />
                </c:otherwise>
            </c:choose>
        </div>
        <div class="info-col">
            <h2>${product.productName}</h2>
            <div>
                <span class="category-badge">Danh muc: ${product.category != null ? product.category.categoryname : 'Chua phan loai'}</span>
            </div>
            <div class="price">
                ${product.formattedPrice}
            </div>
            <div class="meta-info">
                <div><b>Ma san pham:</b> #${product.productId}</div>
                <div><b>So luong con lai:</b> ${product.quantity}</div>
                <div><b>Trang thai:</b> ${product.status == 1 ? 'Dang kinh doanh' : 'Ngung kinh doanh'}</div>
            </div>
            <div>
                <b>Mo ta san pham:</b>
                <div class="desc-box">
                    ${not empty product.description ? product.description : 'Khong co mo ta chi tiet.'}
                </div>
            </div>
            <a href="<c:url value='/product'/>" class="back-btn">Quay lai danh sach san pham</a>
        </div>
    </div>
</div>

</body>
</html>
