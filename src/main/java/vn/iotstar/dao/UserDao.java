package vn.iotstar.dao;
import java.util.List;
import jakarta.persistence.*;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.User;
/** PostgreSQL-only JPA DAO. */
public class UserDao implements IUserDao {
 private void execute(java.util.function.Consumer<EntityManager> a){EntityManager em=JpaConfig.getEntityManager();EntityTransaction tx=em.getTransaction();try{tx.begin();a.accept(em);tx.commit();}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();}}
 public void insert(User u){execute(em->em.persist(u));} public void update(User u){execute(em->em.merge(u));}
 public void delete(int id){execute(em->{User u=em.find(User.class,id);if(u!=null)em.remove(u);});}
 public User findById(int id){EntityManager em=JpaConfig.getEntityManager();try{return em.find(User.class,id);}finally{em.close();}}
 private User single(String f,String v){EntityManager em=JpaConfig.getEntityManager();try{List<User> r=em.createQuery("select u from User u where "+f+"=:v",User.class).setParameter("v",v).setMaxResults(1).getResultList();return r.isEmpty()?null:r.get(0);}finally{em.close();}}
 public User findByUsername(String v){return single("u.username",v);} public User findByEmail(String v){return single("u.email",v);}
 public User checkLogin(String n,String p){EntityManager em=JpaConfig.getEntityManager();try{List<User> r=em.createQuery("select u from User u where u.username=:n and u.password=:p",User.class).setParameter("n",n).setParameter("p",p).setMaxResults(1).getResultList();return r.isEmpty()?null:r.get(0);}finally{em.close();}}
 public List<User> findAll(){EntityManager em=JpaConfig.getEntityManager();try{return em.createNamedQuery("User.findAll",User.class).getResultList();}finally{em.close();}}
}
