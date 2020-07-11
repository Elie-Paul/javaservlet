package ui;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.IEmploye;
import dao.IService;
import model.Employe;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "employe" , urlPatterns = "/employe")
public class EmployeServlet extends HttpServlet {
    @EJB
    private IService serviceDao;
    @EJB
    private IEmploye employeDao;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            String nom = req.getParameter("nom");
            String poste = req.getParameter("poste");
            int salaire = Integer.parseInt(req.getParameter("salaire"));
            int service = Integer.parseInt(req.getParameter("service"));
            Employe employe = new Employe();
            employe.setNomComplet(nom);
            employe.setPoste(poste);
            employe.setSalaire(salaire);
            employe.setService(serviceDao.findById(service));
            switch (action) {
                case "add":
                    employeDao.save(employe);
                    req.setAttribute("services",serviceDao.findAll());
                    req.setAttribute("employes",employeDao.findAll());
                    getServletContext().getRequestDispatcher("/WEB-INF/employe.jsp").forward(req,resp);
                    resp.getWriter().println("ok");
                    break;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    req.setAttribute("services",serviceDao.findAll());
                    req.setAttribute("employes",employeDao.findAll());
                    getServletContext().getRequestDispatcher("/WEB-INF/employe.jsp").forward(req,resp);
                    break;
                case "update":
                    int id = Integer.parseInt(req.getParameter("employe_id"));
                    Employe e = employeDao.findById(id);
                    ObjectMapper mapper = new ObjectMapper();
                    String data = mapper.writeValueAsString(e);
                    resp.getWriter().println(data);

                    break;
            }
        }
    }
}
