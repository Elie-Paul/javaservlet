package dao;

import model.Employe;
import model.Service;
import org.hibernate.Session;
import org.hibernate.Transaction;
import utils.HibernateUtil;

import javax.ejb.Stateless;
import java.util.List;

@Stateless
public class EmployeDao implements IEmploye {
    private Session session;

    public EmployeDao(){
        session = HibernateUtil.getSession();
    }
    @Override
    public List<Employe> findAll() {
        return session.createQuery("SELECT e FROM Employe e", Employe.class).list();
    }

    @Override
    public Employe save(Employe e) {
        Transaction transaction = session.getTransaction();
        try {
            transaction.begin();
            session.saveOrUpdate(e);
            transaction.commit();
            return e;
        }catch (Exception ex){
            transaction.rollback();
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public Employe findById(int id) {
        return session.find(Employe.class, id);
    }
}
