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
        // Kiem tra neu da co session account thi vao thang trang chu
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Kiem tra cookie remember me de tu dong dien hoac tu dong dang nhap
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

        // 1. Kiem tra trong bang User JPA (co ho tro OTP)
        vn.iotstar.entity.User iotUser = iotUserService.findByUsername(username);
        if (iotUser != null) {
            if (!iotUser.getPassword().equals(password)) {
                req.setAttribute("alert", "Mat khau khong chinh xac.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            // Kiem tra kich hoat OTP
            if (iotUser.getStatus() != 1) {
                req.setAttribute("alert", "Tai khoan chua duoc kich hoat qua Email OTP. Vui long nhap ma OTP de kich hoat.");
                req.setAttribute("email", iotUser.getEmail());
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                return;
            }

            // Dang nhap thanh cong
            UserModel account = new UserModel(iotUser.getId(), iotUser.getEmail(), iotUser.getUsername(), iotUser.getFullname(), iotUser.getPassword());
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, account);

            if (isRememberMe) {
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
                cookie.setMaxAge(30 * 60);
                cookie.setPath("/");
                resp.addCookie(cookie);
            }

            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 2. Kiem tra nguoi dung cu
        UserModel user = userService.login(username, password);
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, user);

            if (isRememberMe) {
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
                cookie.setMaxAge(30 * 60);
                cookie.setPath("/");
                resp.addCookie(cookie);
            }

            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("alert", "Tai khoan hoac mat khau khong chinh xac.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
