package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceContext;

@PersistenceContext
public class JpaConfig {
    private static EntityManagerFactory factory;
    public static EntityManager getEntityManager() {
        try {
            if (factory == null || !factory.isOpen()) {
                factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql");
            }
            return factory.createEntityManager();
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalStateException("Không thể kết nối PostgreSQL/JPA", e);
        }
    }
}
