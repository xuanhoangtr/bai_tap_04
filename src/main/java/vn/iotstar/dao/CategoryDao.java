package vn.iotstar.dao;
import java.util.List;
import jakarta.persistence.*;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Category;
public class CategoryDao implements ICategoryDao {
 private void execute(java.util.function.Consumer<EntityManager>a){EntityManager em=JpaConfig.getEntityManager();EntityTransaction tx=em.getTransaction();try{tx.begin();a.accept(em);tx.commit();}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();}}
 public void insert(Category c){execute(em->em.persist(c));} public void update(Category c){execute(em->em.merge(c));}
 public void delete(int id){execute(em->{Category c=em.find(Category.class,id);if(c!=null)em.remove(c);});}
 public Category findById(int id){EntityManager em=JpaConfig.getEntityManager();try{return em.find(Category.class,id);}finally{em.close();}}
 public Category findByCategoryname(String n){EntityManager em=JpaConfig.getEntityManager();try{List<Category>r=em.createQuery("select c from Category c where c.categoryname=:n",Category.class).setParameter("n",n).setMaxResults(1).getResultList();return r.isEmpty()?null:r.get(0);}finally{em.close();}}
 public List<Category> findAll(){EntityManager em=JpaConfig.getEntityManager();try{return em.createNamedQuery("Category.findAll",Category.class).getResultList();}finally{em.close();}}
 public List<Category> searchByName(String n){EntityManager em=JpaConfig.getEntityManager();try{return em.createQuery("select c from Category c where lower(c.categoryname) like lower(:n)",Category.class).setParameter("n","%"+n+"%").getResultList();}finally{em.close();}}
 public List<Category> findAll(int page,int size){EntityManager em=JpaConfig.getEntityManager();try{return em.createNamedQuery("Category.findAll",Category.class).setFirstResult(Math.max(0,page)*size).setMaxResults(size).getResultList();}finally{em.close();}}
 public int count(){EntityManager em=JpaConfig.getEntityManager();try{return ((Long)em.createQuery("select count(c) from Category c").getSingleResult()).intValue();}finally{em.close();}}
}
