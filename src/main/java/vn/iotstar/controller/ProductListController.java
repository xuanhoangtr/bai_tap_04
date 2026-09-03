package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.ProductServiceImpl;

@WebServlet(urlPatterns = {"/product", "/products"})
public class ProductListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IProductService productService = new ProductServiceImpl();
    private static final int PAGE_SIZE = 6; // Yeu cau: phan trang 6 san pham / trang

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {
            }
        }

        int totalCount = productService.count();
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;

        List<Product> products = productService.findAll(page, PAGE_SIZE);

        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", totalCount);

        req.getRequestDispatcher("/views/product-list.jsp").forward(req, resp);
    }
}
