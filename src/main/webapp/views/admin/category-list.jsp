<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục - Admin</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">DANH MỤC SẢN PHẨM</h4>
            <p class="text-muted small mb-0">Quản lý các danh mục sản phẩm trong hệ thống</p>
        </div>
        <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary fw-semibold">
            Thêm danh mục mới
        </a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 60px;">STT</th>
                            <th style="width: 100px;">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th class="text-center" style="width: 130px;">Trạng thái</th>
                            <th class="text-center" style="width: 160px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center fw-bold text-muted">${STT.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty cate.images and cate.images.startsWith('http')}">
                                            <img src="${cate.images}" class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="Category" />
                                        </c:when>
                                        <c:when test="${not empty cate.images}">
                                            <img src="<c:url value='/image?fname=${cate.images}'/>" class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="Category" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="<c:url value='/image?fname=avatar.png'/>" class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="Category" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="fw-bold">${cate.categoryname}</span>
                                    <div class="text-muted small">ID: #${cate.categoryid}</div>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${cate.status == 1}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Tạm khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-primary me-1">Sửa</a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listcate}">
                            <tr>
                                <td colspan="5" class="text-center py-4 text-muted">Chưa có danh mục nào trong hệ thống.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
