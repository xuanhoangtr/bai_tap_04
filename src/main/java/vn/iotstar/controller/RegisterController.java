package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");

        if (username == null || email == null || password == null || username.trim().isEmpty() || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui long dien day du cac thong tin bat buoc.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPassword(password.trim());
        user.setFullname(fullname != null ? fullname.trim() : "");

        // Kiem tra rieng tung truong de thong bao dung nguyen nhan cho nguoi dung.
        // Truoc day ca username va email deu hien cung mot thong bao nen de nham
        // rang username nao cung da ton tai khi thuc te email cu dang duoc dung lai.
        if (userService.findByUsername(user.getUsername()) != null) {
            req.setAttribute("alert", "Ten dang nhap da ton tai. Vui long chon ten dang nhap khac.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (userService.findByEmail(user.getEmail()) != null) {
            req.setAttribute("alert", "Email nay da duoc dang ky. Vui long dung email khac hoac dang nhap.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.register(user);
        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("verify_email", email.trim());
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("alert", "Khong the gui email OTP. Vui long kiem tra cau hinh SMTP va thu lai.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}
