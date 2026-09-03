package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    boolean register(User user);
    boolean verifyOtp(String emailOrUsername, String otp);
    User login(String username, String password);
    boolean forgotPassword(String email);
    boolean resetPassword(String email, String otp, String newPassword);
    User findByUsername(String username);
    User findByEmail(String email);
}
