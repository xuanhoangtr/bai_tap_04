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
        String phone = req.getParameter("phone");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // Giữ lại thông tin form đã nhập
        req.setAttribute("username", username);
        req.setAttribute("email", email);
        req.setAttribute("phone", phone);
        req.setAttribute("fullname", fullname);

        // 1. Kiểm tra các trường bắt buộc
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng điền đầy đủ các thông tin bắt buộc.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        username = username.trim();
        email = email.trim();
        password = password.trim();

        // 2. Validate Username
        if (!username.matches("^[a-zA-Z0-9_]{3,30}$")) {
            req.setAttribute("alert", "Tên đăng nhập từ 3-30 ký tự, chỉ gồm chữ cái, số và dấu gạch dưới.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 3. Validate Email
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            req.setAttribute("alert", "Địa chỉ email không hợp lệ.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 4. Validate Phone (nếu có nhập)
        if (phone != null && !phone.trim().isEmpty()) {
            phone = phone.trim();
            if (!phone.matches("^0[0-9]{9}$")) {
                req.setAttribute("alert", "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                return;
            }
        }

        // 5. Validate Password length
        if (password.length() < 6) {
            req.setAttribute("alert", "Mật khẩu phải có ít nhất 6 ký tự.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 6. Validate Confirm Password
        if (confirmPassword != null && !password.equals(confirmPassword.trim())) {
            req.setAttribute("alert", "Xác nhận mật khẩu không trùng khớp với mật khẩu.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 7. Kiểm tra trùng lặp trong Database
        if (userService.findByUsername(username) != null) {
            req.setAttribute("alert", "Tên đăng nhập đã tồn tại. Vui lòng chọn tên đăng nhập khác.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (userService.findByEmail(email) != null) {
            req.setAttribute("alert", "Email này đã được đăng ký. Vui lòng dùng email khác hoặc đăng nhập.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setFullname(fullname != null ? fullname.trim() : username);
        user.setPhone(phone != null ? phone.trim() : "");
        user.setImages("avatar.png");
        user.setStatus(0); // Chờ xác thực OTP

        boolean success = userService.register(user);
        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("verify_email", email);
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("alert", "Không thể gửi email OTP. Vui lòng kiểm tra cấu hình SMTP và thử lại.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}
