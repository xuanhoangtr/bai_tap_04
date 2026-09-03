package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;

@WebServlet(urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui long nhap dia chi email.");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        String normalizedEmail = email.trim();
        if (userService.findByEmail(normalizedEmail) == null) {
            req.setAttribute("alert", "Email khong ton tai trong he thong.");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        boolean sent = userService.forgotPassword(normalizedEmail);
        if (sent) {
            HttpSession session = req.getSession();
            session.setAttribute("reset_email", normalizedEmail);
            resp.sendRedirect(req.getContextPath() + "/reset-password");
        } else {
            req.setAttribute("alert", "Khong the gui email OTP. Vui long kiem tra cau hinh SMTP va thu lai.");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }
}
