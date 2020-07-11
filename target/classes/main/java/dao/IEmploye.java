package dao;

import model.Employe;
import model.Service;

import javax.ejb.Local;
import java.util.List;

@Local
public interface IEmploye {
    public List<Employe> findAll();
    public Employe save(Employe e);
    public Employe findById(int id);
}
