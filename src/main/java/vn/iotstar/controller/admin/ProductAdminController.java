package vn.iotstar.controller.admin;

import java.io.File;
import java.io.FileNotFoundException;
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
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.delete(id);
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
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int status = Integer.parseInt(req.getParameter("status"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            Product product = new Product();
            product.setProductName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Xu ly upload file anh
            String fname = "";
            String uploadPath = constants.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = index > 0 ? filename.substring(index + 1) : "png";
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    product.setImages(fname);
                } else {
                    String imageUrl = req.getParameter("images");
                    product.setImages(imageUrl != null && !imageUrl.isEmpty() ? imageUrl : "avatar.png");
                }
            } catch (Exception e) {
                product.setImages("avatar.png");
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if (url.contains("/admin/product/update")) {
            int id = Integer.parseInt(req.getParameter("productId"));
            String name = req.getParameter("productName");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int status = Integer.parseInt(req.getParameter("status"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            Product product = productService.findById(id);
            if (product != null) {
                product.setProductName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setStatus(status);

                Category category = categoryService.findById(categoryId);
                product.setCategory(category);

                String uploadPath = constants.DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                try {
                    Part part = req.getPart("images1");
                    if (part != null && part.getSize() > 0) {
                        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        int index = filename.lastIndexOf(".");
                        String ext = index > 0 ? filename.substring(index + 1) : "png";
                        String fname = System.currentTimeMillis() + "." + ext;
                        part.write(uploadPath + "/" + fname);
                        product.setImages(fname);
                    } else {
                        String imageUrl = req.getParameter("images");
                        if (imageUrl != null && !imageUrl.isEmpty()) {
                            product.setImages(imageUrl);
                        }
                    }
                } catch (Exception ignored) {
                }

                productService.update(product);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}
