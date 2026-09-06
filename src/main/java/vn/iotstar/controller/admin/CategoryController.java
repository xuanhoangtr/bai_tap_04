package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
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
import vn.iotstar.service.CategoryServiceImpl;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.util.constants;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5 * 5
)
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/list", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/categories") || url.contains("/admin/category/list")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").include(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").include(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = cateService.findById(id);
                if (category != null) {
                    req.setAttribute("cate", category);
                    req.getRequestDispatcher("/views/admin/category-edit.jsp").include(req, resp);
                    return;
                }
            } catch (Exception ignored) {}
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else if (url.contains("/admin/category/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusParam = req.getParameter("status");
            String images = req.getParameter("images");

            // Server-side validation
            if (categoryname == null || categoryname.trim().isEmpty() || categoryname.trim().length() < 2) {
                req.setAttribute("error", "Tên danh mục không được để trống và phải có ít nhất 2 ký tự.");
                req.getRequestDispatcher("/views/admin/category-add.jsp").include(req, resp);
                return;
            }

            int status = 1;
            try {
                if (statusParam != null) status = Integer.parseInt(statusParam);
            } catch (NumberFormatException ignored) {}

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

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
                        String ext = (index > 0) ? filename.substring(index + 1) : "png";
                        String fname = System.currentTimeMillis() + "." + ext;

                        part.write(uploadPath + File.separator + fname);
                        category.setImages(fname);
                    } else if (images != null && !images.trim().isEmpty()) {
                        category.setImages(images.trim());
                    } else {
                        category.setImages("category_default.png");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (images != null && !images.trim().isEmpty()) {
                category.setImages(images.trim());
            } else {
                category.setImages("category_default.png");
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        }

        if (url.contains("/admin/category/update")) {
            String idParam = req.getParameter("categoryid");
            String categoryname = req.getParameter("categoryname");
            String statusParam = req.getParameter("status");
            String images = req.getParameter("images");

            if (idParam == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            int categoryid = Integer.parseInt(idParam);
            Category category = cateService.findById(categoryid);
            if (category == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            // Server-side validation
            if (categoryname == null || categoryname.trim().isEmpty() || categoryname.trim().length() < 2) {
                req.setAttribute("error", "Tên danh mục không được để trống và phải có ít nhất 2 ký tự.");
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").include(req, resp);
                return;
            }

            int status = category.getStatus();
            try {
                if (statusParam != null) status = Integer.parseInt(statusParam);
            } catch (NumberFormatException ignored) {}

            String fileold = category.getImages();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            String uploadPath = constants.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String contentType = req.getContentType();
            if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
                try {
                    Part part = req.getPart("images1");
                    if (part != null && part.getSize() > 0) {
                        if (fileold != null && !fileold.isEmpty() && !fileold.startsWith("http") && !"category_default.png".equals(fileold)) {
                            try {
                                deleteFile(uploadPath + File.separator + fileold);
                            } catch (Exception ignored) {}
                        }

                        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        int index = filename.lastIndexOf(".");
                        String ext = (index > 0) ? filename.substring(index + 1) : "png";
                        String fname = System.currentTimeMillis() + "." + ext;

                        part.write(uploadPath + File.separator + fname);
                        category.setImages(fname);
                    } else if (images != null && !images.trim().isEmpty()) {
                        category.setImages(images.trim());
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (images != null && !images.trim().isEmpty()) {
                category.setImages(images.trim());
            }

            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
}
