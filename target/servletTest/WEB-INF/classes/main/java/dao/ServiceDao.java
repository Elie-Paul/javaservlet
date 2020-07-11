package dao;

import model.Service;
import org.hibernate.Session;
import utils.HibernateUtil;

import javax.ejb.Stateless;
import java.util.List;

@Stateless
public class ServiceDao implements IService {
    private Session session;

    public ServiceDao(){
        session = HibernateUtil.getSession();
    }
    @Override
    public List<Service> findAll() {
        return session.createQuery("SELECT s FROM Service s", Service.class).list();
    }

    @Override
    public Service findById(int id) {
        return session.find(Service.class, id);
    }
}
