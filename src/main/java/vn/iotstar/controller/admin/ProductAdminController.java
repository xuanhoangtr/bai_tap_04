package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.CategoryServiceImpl;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.ProductServiceImpl;
import vn.iotstar.util.constants;

@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/add",
    "/admin/product/insert",
    "/admin/product/edit",
    "/admin/product/update",
    "/admin/product/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5 * 5
)
public class ProductAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("products", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").include(req, resp);
        } else if (url.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").include(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productService.findById(id);
                if (product != null) {
                    List<Category> categories = categoryService.findAll();
                    req.setAttribute("product", product);
                    req.setAttribute("categories", categories);
                    req.getRequestDispatcher("/views/admin/product-edit.jsp").include(req, resp);
                    return;
                }
            } catch (Exception ignored) {}
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if (url.contains("/admin/product/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/product/insert")) {
            String name = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceParam = req.getParameter("price");
            String quantityParam = req.getParameter("quantity");
            String statusParam = req.getParameter("status");
            String categoryIdParam = req.getParameter("categoryId");
            String imageUrl = req.getParameter("images");

            // Server-side validation
            if (name == null || name.trim().isEmpty() || name.trim().length() < 2) {
                req.setAttribute("error", "Tên sản phẩm không được để trống và phải có ít nhất 2 ký tự.");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").include(req, resp);
                return;
            }

            double price = 0;
            try {
                price = Double.parseDouble(priceParam);
                if (price < 0) throw new NumberFormatException();
            } catch (Exception e) {
                req.setAttribute("error", "Đơn giá phải là số dương hợp lệ.");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").include(req, resp);
                return;
            }

            int categoryId = 0;
            try {
                categoryId = Integer.parseInt(categoryIdParam);
            } catch (Exception e) {
                req.setAttribute("error", "Vui lòng chọn danh mục hợp lệ.");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").include(req, resp);
                return;
            }

            int quantity = 0;
            try {
                if (quantityParam != null) quantity = Integer.parseInt(quantityParam);
            } catch (NumberFormatException ignored) {}

            int status = 1;
            try {
                if (statusParam != null) status = Integer.parseInt(statusParam);
            } catch (NumberFormatException ignored) {}

            Product product = new Product();
            product.setProductName(name.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Upload file ảnh Multipart
            String uploadPath = constants.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String contentType = req.getContentType();
            if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
                try {
                    Part part = req.getPart("images1");
                    if (part != null && part.getSize() > 0) {
                        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        int index = filename.lastIndexOf(".");
                        String ext = index > 0 ? filename.substring(index + 1) : "png";
                        String fname = System.currentTimeMillis() + "." + ext;
                        part.write(uploadPath + File.separator + fname);
                        product.setImages(fname);
                    } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                        product.setImages(imageUrl.trim());
                    } else {
                        product.setImages("product_default.png");
                    }
                } catch (Exception e) {
                    product.setImages("product_default.png");
                }
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                product.setImages(imageUrl.trim());
            } else {
                product.setImages("product_default.png");
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        if (url.contains("/admin/product/update")) {
            String idParam = req.getParameter("productId");
            String name = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceParam = req.getParameter("price");
            String quantityParam = req.getParameter("quantity");
            String statusParam = req.getParameter("status");
            String categoryIdParam = req.getParameter("categoryId");
            String imageUrl = req.getParameter("images");

            if (idParam == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            int id = Integer.parseInt(idParam);
            Product product = productService.findById(id);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            // Server-side validation
            if (name == null || name.trim().isEmpty() || name.trim().length() < 2) {
                req.setAttribute("error", "Tên sản phẩm không được để trống và phải có ít nhất 2 ký tự.");
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").include(req, resp);
                return;
            }

            double price = product.getPrice();
            try {
                price = Double.parseDouble(priceParam);
                if (price < 0) throw new NumberFormatException();
            } catch (Exception e) {
                req.setAttribute("error", "Đơn giá phải là số dương hợp lệ.");
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").include(req, resp);
                return;
            }

            int categoryId = product.getCategory() != null ? product.getCategory().getCategoryid() : 0;
            try {
                if (categoryIdParam != null) categoryId = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException ignored) {}

            int quantity = product.getQuantity();
            try {
                if (quantityParam != null) quantity = Integer.parseInt(quantityParam);
            } catch (NumberFormatException ignored) {}

            int status = product.getStatus();
            try {
                if (statusParam != null) status = Integer.parseInt(statusParam);
            } catch (NumberFormatException ignored) {}

            product.setProductName(name.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            String uploadPath = constants.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String contentType = req.getContentType();
            if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
                try {
                    Part part = req.getPart("images1");
                    if (part != null && part.getSize() > 0) {
                        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        int index = filename.lastIndexOf(".");
                        String ext = index > 0 ? filename.substring(index + 1) : "png";
                        String fname = System.currentTimeMillis() + "." + ext;
                        part.write(uploadPath + File.separator + fname);
                        product.setImages(fname);
                    } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                        product.setImages(imageUrl.trim());
                    }
                } catch (Exception ignored) {}
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                product.setImages(imageUrl.trim());
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}
