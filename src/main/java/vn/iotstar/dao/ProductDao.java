package vn.iotstar.dao;
import java.util.List;
import jakarta.persistence.*;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Product;
public class ProductDao implements IProductDao {
 private void execute(java.util.function.Consumer<EntityManager>a){EntityManager em=JpaConfig.getEntityManager();EntityTransaction tx=em.getTransaction();try{tx.begin();a.accept(em);tx.commit();}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();}}
 public void insert(Product p){execute(em->em.persist(p));} public void update(Product p){execute(em->em.merge(p));}
 public void delete(int id){execute(em->{Product p=em.find(Product.class,id);if(p!=null)em.remove(p);});}
 public Product findById(int id){EntityManager em=JpaConfig.getEntityManager();try{return em.find(Product.class,id);}finally{em.close();}}
 public List<Product> findAll(){EntityManager em=JpaConfig.getEntityManager();try{return em.createNamedQuery("Product.findAll",Product.class).getResultList();}finally{em.close();}}
 public List<Product> findTop10Latest(){EntityManager em=JpaConfig.getEntityManager();try{return em.createQuery("select p from Product p where p.status=1 order by p.productId desc",Product.class).setMaxResults(10).getResultList();}finally{em.close();}}
 public List<Product> findAll(int page,int size){EntityManager em=JpaConfig.getEntityManager();try{return em.createQuery("select p from Product p where p.status=1 order by p.productId desc",Product.class).setFirstResult(Math.max(0,page-1)*size).setMaxResults(size).getResultList();}finally{em.close();}}
 public int count(){EntityManager em=JpaConfig.getEntityManager();try{return ((Long)em.createQuery("select count(p) from Product p where p.status=1").getSingleResult()).intValue();}finally{em.close();}}
}
