<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quan tri San pham</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f8f9fa; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        h2 { margin: 0; color: #333; }
        .btn { display: inline-block; padding: 8px 16px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 14px; }
        .btn-add { background-color: #28a745; color: white; }
        .btn-add:hover { background-color: #218838; }
        .btn-edit { background-color: #007bff; color: white; padding: 5px 10px; font-size: 12px; }
        .btn-delete { background-color: #dc3545; color: white; padding: 5px 10px; font-size: 12px; }
        .btn-nav { background-color: #6c757d; color: white; }
        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-radius: 4px; overflow: hidden; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #dee2e6; }
        th { background-color: #007bff; color: white; }
        tr:hover { background-color: #f1f5f9; }
        .prod-thumb { width: 60px; height: 60px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc; }
        .status-badge { padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .status-active { background-color: #d4edda; color: #155724; }
        .status-inactive { background-color: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

<div class="top-bar">
    <h2>DANH SACH SAN PHAM (JPA CRUD)</h2>
    <div>
        <a href="<c:url value='/home'/>" class="btn btn-nav">Trang chu</a>
        <a href="<c:url value='/admin/categories'/>" class="btn btn-nav">Quan tri Danh muc</a>
        <a href="<c:url value='/admin/product/add'/>" class="btn btn-add">Them San pham moi</a>
    </div>
</div>

<table>
    <thead>
        <tr>
            <th>STT</th>
            <th>Hinh anh</th>
            <th>Ten san pham</th>
            <th>Danh muc</th>
            <th>Gia ban</th>
            <th>So luong</th>
            <th>Trang thai</th>
            <th>Hanh dong</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="p" items="${products}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>
                    <c:choose>
                        <c:when test="${p.images.substring(0,5) == 'https'}">
                            <img src="${p.images}" class="prod-thumb" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${p.images}" var="imgUrl"/>
                            <img src="${imgUrl}" class="prod-thumb" />
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><b>${p.productName}</b></td>
                <td>${p.category != null ? p.category.categoryname : 'N/A'}</td>
                <td>${p.formattedPrice}</td>
                <td>${p.quantity}</td>
                <td>
                    <c:choose>
                        <c:when test="${p.status == 1}">
                            <span class="status-badge status-active">Hoat dong</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-inactive">Khoa</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-edit">Sua</a>
                    <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="btn btn-delete" onclick="return confirm('Ban co chac chan muon xoa san pham nay?');">Xoa</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
