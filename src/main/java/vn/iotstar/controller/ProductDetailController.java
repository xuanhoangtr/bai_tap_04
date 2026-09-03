package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.ProductServiceImpl;

@WebServlet(urlPatterns = {"/product/detail", "/product-detail"})
public class ProductDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Product product = productService.findById(id);
            if (product != null) {
                req.setAttribute("product", product);
                req.getRequestDispatcher("/views/product-detail.jsp").forward(req, resp);
                return;
            }
        } catch (NumberFormatException ignored) {
        }

        resp.sendRedirect(req.getContextPath() + "/product");
    }
}
