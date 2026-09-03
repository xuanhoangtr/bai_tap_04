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

@WebServlet(urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            req.setAttribute("alert", "Mat khau xac nhan khong khop.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean resetOk = userService.resetPassword(email, otp, newPassword);
        if (resetOk) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.removeAttribute("reset_email");
            }
            req.setAttribute("successAlert", "Dat lai mat khau thanh cong! Vui long dang nhap voi mat khau moi.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Ma OTP khong chinh xac hoac da het han.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }
}
