package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.hcmute.models.UserModel;
import vn.hcmute.utils.Constant;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;

@WebServlet(urlPatterns = {"/profile", "/user/profile", "/profile/edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5, // 5MB
    maxRequestSize = 1024 * 1024 * 5 * 5 // 25MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService userService = new UserServiceImpl();
    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "gif", "webp");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserModel account = (UserModel) session.getAttribute(Constant.SESSION_ACCOUNT);
        User user = userService.findById(account.getId());
        if (user == null) {
            user = userService.findByUsername(account.getUserName());
        }

        if (user != null) {
            req.setAttribute("user", user);
        } else {
            req.setAttribute("user", account);
        }

        req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserModel account = (UserModel) session.getAttribute(Constant.SESSION_ACCOUNT);
        User user = userService.findById(account.getId());
        if (user == null) {
            user = userService.findByUsername(account.getUserName());
        }

        if (user == null) {
            req.setAttribute("error", "Không tìm thấy thông tin tài khoản người dùng.");
            req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String images = req.getParameter("images");

        // 1. Validation Fullname
        if (fullname == null || fullname.trim().isEmpty() || fullname.trim().length() < 2) {
            req.setAttribute("error", "Họ và tên không được để trống và phải có ít nhất 2 ký tự.");
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
            return;
        }

        // 2. Validation Phone
        if (phone != null && !phone.trim().isEmpty()) {
            phone = phone.trim();
            if (!phone.matches("^0[0-9]{9}$")) {
                req.setAttribute("error", "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0.");
                req.setAttribute("user", user);
                req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
                return;
            }
            user.setPhone(phone);
        } else {
            user.setPhone("");
        }

        user.setFullname(fullname.trim());

        // 3. Upload file Multipart
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String oldImage = user.getImages();
        String contentType = req.getContentType();

        if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String submittedFileName = part.getSubmittedFileName();
                    if (submittedFileName != null && !submittedFileName.isEmpty()) {
                        String filename = Paths.get(submittedFileName).getFileName().toString();
                        int dotIndex = filename.lastIndexOf(".");
                        String ext = (dotIndex > 0) ? filename.substring(dotIndex + 1).toLowerCase() : "png";

                        if (!ALLOWED_EXTENSIONS.contains(ext)) {
                            req.setAttribute("error", "Định dạng file ảnh không hợp lệ (chỉ chấp nhận JPG, PNG, GIF, WebP).");
                            req.setAttribute("user", user);
                            req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
                            return;
                        }

                        String fname = "avatar_" + System.currentTimeMillis() + "." + ext;
                        part.write(uploadPath + File.separator + fname);
                        user.setImages(fname);

                        // Xóa file cũ nếu không phải ảnh mặc định hoặc URL
                        if (oldImage != null && !oldImage.isEmpty() && !oldImage.startsWith("http") && !"avatar.png".equals(oldImage)) {
                            try {
                                Files.deleteIfExists(Paths.get(uploadPath + File.separator + oldImage));
                            } catch (Exception ignored) {}
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi khi upload file ảnh: " + e.getMessage());
                req.setAttribute("user", user);
                req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
                return;
            }
        }
        
        if (images != null && !images.trim().isEmpty()) {
            user.setImages(images.trim());
        }

        // 4. Cập nhật JPA Database
        userService.update(user);

        // 5. Đồng bộ Session Account
        account.setFullName(user.getFullname());
        account.setPhone(user.getPhone());
        account.setImages(user.getImages());
        session.setAttribute(Constant.SESSION_ACCOUNT, account);

        req.setAttribute("user", user);
        req.setAttribute("message", "Cập nhật hồ sơ tài khoản thành công.");
        req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
    }
}
