package vn.iotstar.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;

public class ProductDao implements IProductDao {

    // Danh sach in-memory du phong khi SQL Server offline
    private static final List<Product> memoryProducts = new ArrayList<>();
    private static int autoId = 1;

    static {
        Category catePhone = new Category(1, "Phone", "avatar.png", 1, null);
        Category cateLaptop = new Category(2, "Laptop", "avatar.png", 1, null);
        Category cateAirPods = new Category(3, "Tai nghe", "avatar.png", 1, null);

        // 15 san pham thuoc 3 danh muc: Phone (iPhone), Laptop (MacBook), Tai nghe (AirPods)
        String[] names = {
            "iPhone 16 Pro Max", "iPhone 16 Pro", "iPhone 16", "iPhone 15 Pro Max", "iPhone 15",
            "MacBook Pro 16 M3 Max", "MacBook Pro 14 M3", "MacBook Air 15 M3", "MacBook Air 13 M2", "MacBook Air 13 M1",
            "AirPods Max", "AirPods Pro 2 MagSafe USB-C", "AirPods 4 ANC", "AirPods 4", "AirPods 3"
        };
        double[] prices = {
            34000000, 28000000, 22000000, 29000000, 19000000,
            89000000, 39000000, 32000000, 24000000, 18000000,
            13000000, 6000000, 5000000, 4000000, 4000000
        };
        Category[] cats = {
            catePhone, catePhone, catePhone, catePhone, catePhone,
            cateLaptop, cateLaptop, cateLaptop, cateLaptop, cateLaptop,
            cateAirPods, cateAirPods, cateAirPods, cateAirPods, cateAirPods
        };

        for (int i = 0; i < names.length; i++) {
            Product p = new Product();
            p.setProductId(autoId++);
            p.setProductName(names[i]);
            p.setDescription("San pham " + names[i] + " chinh hang Apple VN/A, bao hanh 12 thang.");
            p.setPrice(prices[i]);
            p.setQuantity(50);
            p.setStatus(1);
            p.setImages("avatar.png");
            p.setCategory(cats[i]);
            memoryProducts.add(p);
        }
    }

    @Override
    public void insert(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            EntityTransaction trans = enma.getTransaction();
            try {
                trans.begin();
                enma.persist(product);
                trans.commit();
            } catch (Exception e) {
                trans.rollback();
            } finally {
                enma.close();
            }
        }
        if (product.getProductId() == 0) {
            product.setProductId(autoId++);
        }
        memoryProducts.add(product);
    }

    @Override
    public void update(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            EntityTransaction trans = enma.getTransaction();
            try {
                trans.begin();
                enma.merge(product);
                trans.commit();
            } catch (Exception e) {
                trans.rollback();
            } finally {
                enma.close();
            }
        }
        for (int i = 0; i < memoryProducts.size(); i++) {
            if (memoryProducts.get(i).getProductId() == product.getProductId()) {
                memoryProducts.set(i, product);
                break;
            }
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            EntityTransaction trans = enma.getTransaction();
            try {
                trans.begin();
                Product p = enma.find(Product.class, id);
                if (p != null) enma.remove(p);
                trans.commit();
            } catch (Exception e) {
                trans.rollback();
            } finally {
                enma.close();
            }
        }
        memoryProducts.removeIf(p -> p.getProductId() == id);
    }

    @Override
    public Product findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            try {
                return enma.find(Product.class, id);
            } finally {
                enma.close();
            }
        }
        for (Product p : memoryProducts) {
            if (p.getProductId() == id) return p;
        }
        return null;
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            try {
                TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
                return query.getResultList();
            } catch (Exception ignored) {
            } finally {
                enma.close();
            }
        }
        return new ArrayList<>(memoryProducts);
    }

    @Override
    public List<Product> findTop10Latest() {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            String jpql = "SELECT p FROM Product p WHERE p.status = 1 ORDER BY p.productId DESC";
            try {
                TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
                query.setMaxResults(10);
                return query.getResultList();
            } catch (Exception ignored) {
            } finally {
                enma.close();
            }
        }
        // Fallback: lay 10 phan tu moi nhat
        List<Product> list = new ArrayList<>(memoryProducts);
        Collections.reverse(list);
        return list.subList(0, Math.min(10, list.size()));
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            String jpql = "SELECT p FROM Product p WHERE p.status = 1 ORDER BY p.productId DESC";
            try {
                TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
                query.setFirstResult((page - 1) * pageSize);
                query.setMaxResults(pageSize);
                return query.getResultList();
            } catch (Exception ignored) {
            } finally {
                enma.close();
            }
        }
        // Fallback phan trang
        List<Product> list = new ArrayList<>(memoryProducts);
        Collections.reverse(list);
        int start = (page - 1) * pageSize;
        if (start >= list.size()) return new ArrayList<>();
        int end = Math.min(start + pageSize, list.size());
        return list.subList(start, end);
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        if (enma != null) {
            String jpql = "SELECT count(p) FROM Product p WHERE p.status = 1";
            try {
                Query query = enma.createQuery(jpql);
                return ((Long) query.getSingleResult()).intValue();
            } catch (Exception ignored) {
            } finally {
                enma.close();
            }
        }
        return memoryProducts.size();
    }
}
