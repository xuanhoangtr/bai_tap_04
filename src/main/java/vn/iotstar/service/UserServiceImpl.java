package vn.iotstar.service;

import java.time.LocalDateTime;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.OtpUtil;

public class UserServiceImpl implements IUserService {

    private final IUserDao userDao = new UserDao();

    @Override
    public boolean register(User user) {
        if (userDao.findByUsername(user.getUsername()) != null) {
            return false;
        }
        if (userDao.findByEmail(user.getEmail()) != null) {
            return false;
        }

        user.setStatus(0); // 0: Cho kich hoat OTP
        String otp = OtpUtil.generateOtp(6);
        user.setOtp(otp);
        user.setOtpExpiry(LocalDateTime.now().plusMinutes(5));

        userDao.insert(user);
        if (!EmailUtil.sendOtpEmail(user.getEmail(), otp, "Kich hoat tai khoan")) {
            // Khong de lai tai khoan mo chua co OTP neu dich vu mail that bai.
            userDao.delete(user.getId());
            return false;
        }
        return true;
    }

    @Override
    public boolean verifyOtp(String emailOrUsername, String otp) {
        if (emailOrUsername == null || emailOrUsername.isBlank() || otp == null || otp.isBlank()) {
            return false;
        }
        User user = userDao.findByUsername(emailOrUsername);
        if (user == null) {
            user = userDao.findByEmail(emailOrUsername);
        }
        if (user == null) {
            return false;
        }

        if (user.getOtp() != null && user.getOtp().equals(otp.trim())) {
            if (user.getOtpExpiry() != null && LocalDateTime.now().isBefore(user.getOtpExpiry())) {
                user.setStatus(1); // Kich hoat thanh cong
                user.setOtp(null);
                user.setOtpExpiry(null);
                userDao.update(user);
                return true;
            }
        }
        return false;
    }

    @Override
    public User login(String username, String password) {
        User user = userDao.checkLogin(username, password);
        // Chi cho phep dang nhap neu tai khoan da duoc kich hoat (status == 1)
        if (user != null && user.getStatus() == 1) {
            return user;
        }
        return null;
    }

    @Override
    public boolean forgotPassword(String email) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        String oldOtp = user.getOtp();
        LocalDateTime oldOtpExpiry = user.getOtpExpiry();
        String otp = OtpUtil.generateOtp(6);
        user.setOtp(otp);
        user.setOtpExpiry(LocalDateTime.now().plusMinutes(5));
        userDao.update(user);

        if (!EmailUtil.sendOtpEmail(email, otp, "Dat lai mat khau")) {
            user.setOtp(oldOtp);
            user.setOtpExpiry(oldOtpExpiry);
            userDao.update(user);
            return false;
        }
        return true;
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        if (email == null || email.isBlank() || otp == null || otp.isBlank()
                || newPassword == null || newPassword.isBlank()) {
            return false;
        }
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        if (user.getOtp() != null && user.getOtp().equals(otp.trim())) {
            if (user.getOtpExpiry() != null && LocalDateTime.now().isBefore(user.getOtpExpiry())) {
                user.setPassword(newPassword);
                user.setOtp(null);
                user.setOtpExpiry(null);
                userDao.update(user);
                return true;
            }
        }
        return false;
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }
}
