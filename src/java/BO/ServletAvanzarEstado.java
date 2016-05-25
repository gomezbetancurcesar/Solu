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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author cesar-gomez
 */
@WebServlet(name = "ServletAvanzarEstado", urlPatterns = {"/ServletAvanzarEstado"})
public class ServletAvanzarEstado extends HttpServlet {

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
            throws ServletException, IOException, SQLException{
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession s = request.getSession();
            Connection _connMy = null;
            String rut = (String) s.getAttribute("rut");
            
            String nuevoEstado = (String) request.getParameter("nuevoEstado");
            String idActividad = (String) request.getParameter("idActividad");
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                Statement stmt = null;
                this.agregarHistorial((String)s.getAttribute("organizacion"), rut, idActividad, nuevoEstado);
                stmt = _connMy.createStatement();
                String query = "update sl_actcomercial_tot set estado='"+nuevoEstado+"' where corr_cotiza="+idActividad+";";
                stmt.executeUpdate(query);
            }catch(Exception e){
                _connMy.rollback();
                e.printStackTrace();
            }
            finally{
                _connMy.close();
            }
            
        }
    }
    
    private void agregarHistorial(String organizacion, String rut, String corrCotiza, String estado)
        throws SQLException{
        Connection _connMy = null;
        try{
            _connMy = conexionBD.Conectar(organizacion);
            CallableStatement sp_usu = _connMy.prepareCall("{call sp_historial(?,?,?,?)}");
            sp_usu.setString(1,"ingreso");                                        
            sp_usu.setLong(2,Long.parseLong(corrCotiza));
            sp_usu.setString(3,estado);
            sp_usu.setString(4,rut);
            sp_usu.execute();
        }catch(Exception e){
            _connMy.rollback();
            e.printStackTrace();
        }finally{
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
                Logger.getLogger(ServletSPUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ServletSPUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
