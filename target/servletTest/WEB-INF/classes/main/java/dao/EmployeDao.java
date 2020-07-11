package dao;

import model.Employe;
import model.Service;
import org.hibernate.Session;
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
        try {
            session.save(e);
            return e;
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public Employe findById(int id) {
        return session.find(Employe.class, id);
    }
}
