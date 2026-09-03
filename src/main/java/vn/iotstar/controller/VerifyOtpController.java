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

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        boolean verified = userService.verifyOtp(email, otp);
        if (verified) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.removeAttribute("verify_email");
            }
            req.setAttribute("successAlert", "Kich hoat tai khoan thanh cong! Ban co the dang nhap ngay bay gio.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Ma OTP khong chinh xac hoac da het han. Vui long thu lai.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
