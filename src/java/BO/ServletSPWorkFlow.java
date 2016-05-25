/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package BO;


import DAL.conexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdk.nashorn.internal.objects.NativeJSAdapter;

/**
 *
 * @author User
 */
@WebServlet(name = "ServletSPWorkFlow", urlPatterns = {"/ServletSPWorkFlow"})
public class ServletSPWorkFlow extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession s = request.getSession();
            Connection _connMy = null;
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                String opcion_WorkFlow = request.getParameter("opcion_WorkFlow");
                switch(opcion_WorkFlow){
                    case "ingreso":
                        this.ingreso(request, _connMy);
                    break;
                    case "modifica":
                        this.modifica(request, _connMy);
                    break;
                    case "elimina":
                        this.elimina(request, _connMy);
                    break;
                    case "estadosSiguientes":
                        String opciones = this.estadosSiguientes(request, _connMy);
                        out.print(opciones);
                    break;
                }
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }
    
    private String estadosSiguientes(HttpServletRequest request, Connection _connMy)
        throws SQLException{
        String opciones = "";
        String estadoActual = request.getParameter("estadoActual");
        try{
            CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_workflow(?,0,?,'','')}");
            sp_usu.setString(1, "siguienteEst");
            sp_usu.setString(2, estadoActual);
            //sp_usu.registerOutParameter("op", Types.VARCHAR);
            sp_usu.execute();
            final ResultSet rs = sp_usu.getResultSet();
            while(rs.next()){
                opciones += "<option>"+rs.getString("estado_siguiente")+"</option>";
            }
        }catch(Exception e){
            _connMy.rollback();
            e.printStackTrace();
        }finally{
            _connMy.close();
        }
        return opciones;
    }
    
    private void ingreso(HttpServletRequest request, Connection _connMy)
        throws SQLException{
        String actual = request.getParameter("slt_work_estAct");
        String siguiente = request.getParameter("slt_work_estSig");
        String rut = request.getParameter("txt_work_rut");
        String id = request.getParameter("hid_work_id");
        try{
            CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_workflow(?,?,?,?,?)}");
            sp_usu.setString(1,"ingreso");
            sp_usu.setLong(2,Integer.parseInt(id));
            sp_usu.setString(3,actual);
            sp_usu.setString(4,siguiente);
            sp_usu.setString(5,rut);
            sp_usu.registerOutParameter("op", Types.VARCHAR);
            sp_usu.execute();
        }catch(Exception e){
            _connMy.rollback();
            e.printStackTrace();
        }
        finally{
            _connMy.close();
        }
    }
    
    private void modifica(HttpServletRequest request, Connection _connMy)
        throws SQLException{
        String actual = request.getParameter("slt_work_estAct");
        String siguiente = request.getParameter("slt_work_estSig");
        String rut = request.getParameter("txt_work_rut");
        String id = request.getParameter("hid_work_id");
        try{
            CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_workflow(?,?,?,?,?)}");
            sp_usu.setString(1,"modifica");
            sp_usu.setLong(2,Integer.parseInt(id));
            sp_usu.setString(3,actual);
            sp_usu.setString(4,siguiente);
            sp_usu.setString(5,rut);
            sp_usu.registerOutParameter("op", Types.VARCHAR);
            sp_usu.execute();
        }catch(Exception e){
            _connMy.rollback();
            e.printStackTrace();
        }
        finally{
            _connMy.close();
        }
    }
    
    private void elimina(HttpServletRequest request, Connection _connMy)
        throws SQLException{
        String id = request.getParameter("hid_work_id");
        try{
            CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_workflow(?,?,'','','')}");
            sp_usu.setString(1,"elimina");
            sp_usu.setLong(2,Integer.parseInt(id));
            sp_usu.registerOutParameter("op", Types.VARCHAR);
            sp_usu.execute();
        }catch(Exception e){
            _connMy.rollback();
            e.printStackTrace();
        }
        finally{
            _connMy.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletSPWorkFlow.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletSPWorkFlow.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
