package vn.iotstar.dao;

import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.User;

public class UserDao implements IUserDao {

    // Danh sach in-memory du phong khi SQL Server chua bat
    private static final List<User> memoryUsers = new ArrayList<>();
    private static int autoId = 1;

    static {
        User defaultUser = new User();
        defaultUser.setId(autoId++);
        defaultUser.setUsername("xuan");
        defaultUser.setPassword("123");
        defaultUser.setEmail("xuanhoangtr@gmail.com");
        defaultUser.setFullname("Tran Xuan Hoang");
        defaultUser.setStatus(1); // da kich hoat
        memoryUsers.add(defaultUser);
    }

    @Override
    public void insert(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            EntityTransaction trans = enma.getTransaction();
            try {
                trans.begin();
                enma.persist(user);
                trans.commit();
            } catch (Exception e) {
                trans.rollback();
            } finally {
                enma.close();
            }
        }
        if (user.getId() == 0) {
            user.setId(autoId++);
        }
        memoryUsers.add(user);
    }

    @Override
    public void update(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            EntityTransaction trans = enma.getTransaction();
            try {
                trans.begin();
                enma.merge(user);
                trans.commit();
            } catch (Exception e) {
                trans.rollback();
            } finally {
                enma.close();
            }
        }
        for (int i = 0; i < memoryUsers.size(); i++) {
            if (memoryUsers.get(i).getId() == user.getId()) {
                memoryUsers.set(i, user);
                break;
            }
        }
    }

    @Override
    public void delete(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            EntityTransaction trans = enma.getTransaction();
            try {
                trans.begin();
                User persisted = enma.find(User.class, id);
                if (persisted != null) enma.remove(persisted);
                trans.commit();
            } catch (Exception e) {
                if (trans.isActive()) trans.rollback();
            } finally {
                enma.close();
            }
        }
        memoryUsers.removeIf(u -> u.getId() == id);
    }

    @Override
    public User findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            try {
                return enma.find(User.class, id);
            } finally {
                enma.close();
            }
        }
        for (User u : memoryUsers) {
            if (u.getId() == id) return u;
        }
        return null;
    }

    @Override
    public User findByUsername(String username) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            String jpql = "SELECT u FROM User u WHERE u.username = :username";
            try {
                TypedQuery<User> query = enma.createQuery(jpql, User.class);
                query.setParameter("username", username);
                List<User> list = query.getResultList();
                if (!list.isEmpty()) return list.get(0);
            } finally {
                enma.close();
            }
        }
        for (User u : memoryUsers) {
            if (u.getUsername().equalsIgnoreCase(username)) return u;
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            String jpql = "SELECT u FROM User u WHERE u.email = :email";
            try {
                TypedQuery<User> query = enma.createQuery(jpql, User.class);
                query.setParameter("email", email);
                List<User> list = query.getResultList();
                if (!list.isEmpty()) return list.get(0);
            } finally {
                enma.close();
            }
        }
        for (User u : memoryUsers) {
            if (u.getEmail().equalsIgnoreCase(email)) return u;
        }
        return null;
    }

    @Override
    public User checkLogin(String username, String password) {
        User user = findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public List<User> findAll() {
        return new ArrayList<>(memoryUsers);
    }
}
