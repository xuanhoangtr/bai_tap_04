package vn.hcmute.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hcmute.models.UserModel;
import vn.hcmute.services.IUserService;
import vn.hcmute.services.impl.UserServiceImpl;
import vn.hcmute.utils.Constant;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService userService = new UserServiceImpl();
    private final vn.iotstar.service.IUserService iotUserService = new vn.iotstar.service.UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (Constant.COOKIE_REMEMBER.equals(c.getName())) {
                    req.setAttribute("rememberUser", c.getValue());
                    break;
                }
            }
        }

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");
        boolean isRememberMe = "on".equals(remember);

        req.setAttribute("username", username);

        // Server-side Validation
        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("alert", "Tên đăng nhập không được để trống.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("alert", "Mật khẩu không được để trống.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // 1. Kiểm tra trong bảng User JPA
        vn.iotstar.entity.User iotUser = iotUserService.findByUsername(username.trim());
        if (iotUser != null) {
            if (!iotUser.getPassword().equals(password)) {
                req.setAttribute("alert", "Mật khẩu không chính xác.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            if (iotUser.getStatus() != 1) {
                req.setAttribute("alert", "Tài khoản chưa được kích hoạt qua Email OTP. Vui lòng nhập mã OTP để kích hoạt.");
                req.setAttribute("email", iotUser.getEmail());
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                return;
            }

            UserModel account = new UserModel(iotUser.getId(), iotUser.getEmail(), iotUser.getUsername(), iotUser.getFullname(), iotUser.getPassword(), iotUser.getPhone(), iotUser.getImages());
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, account);

            if (isRememberMe) {
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username.trim());
                cookie.setMaxAge(30 * 60);
                cookie.setPath("/");
                resp.addCookie(cookie);
            }

            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 2. Kiểm tra fallback
        UserModel user = userService.login(username.trim(), password);
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, user);

            if (isRememberMe) {
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username.trim());
                cookie.setMaxAge(30 * 60);
                cookie.setPath("/");
                resp.addCookie(cookie);
            }

            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không chính xác.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
