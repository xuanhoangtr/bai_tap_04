<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Them san pham moi</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 20px; }
        .form-container { max-width: 600px; margin: 0 auto; background: white; padding: 25px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        input[type="text"], input[type="number"], select, textarea { width: 100%; padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        textarea { height: 80px; resize: vertical; }
        .radio-group { display: flex; gap: 20px; align-items: center; }
        .btn-submit { padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn-back { padding: 10px 20px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 4px; font-size: 16px; display: inline-block; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>THEM SAN PHAM MOI</h2>
    <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Ten san pham:</label>
            <input type="text" name="productName" required placeholder="Nhap ten san pham" />
        </div>
        <div class="form-group">
            <label>Danh muc thuoc ve (Quan he 1-N):</label>
            <select name="categoryId" required>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.categoryid}">${c.categoryname}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Gia ban (VND):</label>
            <input type="number" name="price" step="1000" min="0" required placeholder="500000" />
        </div>
        <div class="form-group">
            <label>So luong kho:</label>
            <input type="number" name="quantity" min="0" value="10" required />
        </div>
        <div class="form-group">
            <label>Hinh anh (Upload file Multipart):</label>
            <input type="file" name="images1" />
        </div>
        <div class="form-group">
            <label>Hoac nhap duong link anh (URL online):</label>
            <input type="text" name="images" placeholder="https://example.com/image.jpg" />
        </div>
        <div class="form-group">
            <label>Mo ta san pham:</label>
            <textarea name="description" placeholder="Nhap mo ta chi tiet san pham..."></textarea>
        </div>
        <div class="form-group">
            <label>Trang thai:</label>
            <div class="radio-group">
                <label><input type="radio" name="status" value="1" checked /> Hoat dong</label>
                <label><input type="radio" name="status" value="0" /> Khoa / Ngung ban</label>
            </div>
        </div>
        <div style="display: flex; justify-content: space-between; margin-top: 20px;">
            <a href="<c:url value='/admin/products'/>" class="btn-back">Quay lai</a>
            <button type="submit" class="btn-submit">Them san pham</button>
        </div>
    </form>
</div>

</body>
</html>
