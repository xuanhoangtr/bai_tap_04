package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.User;

public interface IUserDao {
    void insert(User user);
    void update(User user);
    void delete(int id);
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    User checkLogin(String username, String password);
    List<User> findAll();
}
