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
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
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
 * @author User
 */
@WebServlet(name = "ServletDistribucion", urlPatterns = {"/ServletDistribucion"})
public class ServletDistribucion extends HttpServlet {

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
            CallableStatement sp_usu = null;
            String cantidad = request.getParameter("arrayCantidad");
            String tipoAntiguo = request.getParameter("arrayTipoAnt");
            String planAntiguo = request.getParameter("arrayPlanAnt");
            String tipoNue = request.getParameter("arrayTipoNue");
            String planNue = request.getParameter("arrayPlanNue");
            String CargoAnt = request.getParameter("arrayCargoAntiguo");
            String CargoNue = request.getParameter("arrayCargoNuevo");
            String arpu = request.getParameter("arrayArpu");
            String portPPHab = request.getParameter("arrayportPPHAB");
            String nroMovil = request.getParameter("nroMovil");
            String filas = request.getParameter("filas");
            String secuencia = request.getParameter("secuencia");
            String corrCotiza = request.getParameter("correlativo");
            String arrayTipoAnt [] = tipoAntiguo.split(",");
            String arrayPlanAnt [] = planAntiguo.split(",");
            String arrayCargoAnt [] = CargoAnt.split(",");            
            String arrayCant [] = cantidad.split(",");            
            String arrayTipoNue [] = tipoNue.split(",");
            String arrayPlanNue [] = planNue.split(",");    
            String arrayCargoNue [] = CargoNue.split(",");
            String arrayArpu [] = arpu.split(",");
            String arrayPortPPHab [] = portPPHab.split(",");
            //int movil = Integer.parseInt(nroMovil);         
            long movil  = Long.parseLong(nroMovil);
            try{                                
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
                System.out.println("Filas: "+ filas);
                System.out.println("Largo array: "+arrayTipoAnt.length);
                System.out.println("Tipo Antiguo: "+tipoAntiguo);
                for (int i = 0; i < Integer.parseInt(filas) ; i++) 
                {                                                            
                    sp_usu = _connMy.prepareCall("{call sp_cargarTmpDistri(?,?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setLong(1,movil);
                    
                    try{
                        sp_usu.setString(2, arrayTipoAnt[i]);
                        sp_usu.setString(3, arrayPlanAnt[i]);
                    }catch(Exception e){
                        sp_usu.setString(2, "");
                        sp_usu.setString(3, "");
                    }
                    
                    sp_usu.setString(4, arrayTipoNue[i]);
                    sp_usu.setString(5, arrayPlanNue[i]);
                    sp_usu.setInt(6, Integer.parseInt(arrayCant[i]));
                    sp_usu.setInt(7, Integer.parseInt(corrCotiza));
                    sp_usu.setInt(8, Integer.parseInt(secuencia));
                    
                    try {
                        sp_usu.setInt(9, Integer.parseInt(arrayCargoAnt[i]));
                    } catch (Exception e) {
                        sp_usu.setInt(9, 0);
                    }
                    
                    sp_usu.setInt(10, Integer.parseInt(arrayCargoNue[i]));
                    
                    try {
                        sp_usu.setString(11, arrayPortPPHab[i]);
                    } catch (Exception e) {
                        sp_usu.setString(11, "");
                    }
                    
                    sp_usu.setInt(12, Integer.parseInt(arrayArpu[i]));                    
                    sp_usu.execute();  
                    
                    movil = movil + Integer.parseInt(arrayCant[i]);
                }
            }catch(Exception e){
              System.out.println("ERROR "+e.getMessage());
//                _connMy.rollback();
                e.printStackTrace();
                
              }
              finally{
                _connMy.close();
            }
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
            throws ServletException, IOException{
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
