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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
@WebServlet(name = "ServletComision", urlPatterns = {"/ServletComision"})
public class ServletComision extends HttpServlet {

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
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            String mes = request.getParameter("slt_comision_mes");            
            String anio = request.getParameter("txt_comision_anio");           
            String fechaInicio = request.getParameter("txt_comision_inicio");
            String fechaFinal = request.getParameter("txt_comision_final");
            String estadoCierre = request.getParameter("estadoCierre");
            String fechaCierre = request.getParameter("txt_comision_fechaHoy"); 
            String contador = "";
        try{
            _connMy =conexionBD.Conectar((String)s.getAttribute("organizacion"));
            Statement stmt = null;
            ResultSet rs = null;
            stmt = _connMy.createStatement();
            String query= "select count(*) as contador from sl_actcomercial_tot where DATE(fecha) between '"+fechaInicio+"' and '"+fechaFinal+"'";
            rs = stmt.executeQuery(query);
            while(rs.next())
            {
                 contador = rs.getString("contador");
            }
            if(Integer.parseInt(contador) > 0)
            {
                                                       
                CallableStatement sp_usu = _connMy.prepareCall("{call sp_Comision(?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,"ingreso");
                sp_usu.setInt(2,Integer.parseInt(anio));
                sp_usu.setInt(3,Integer.parseInt(mes));
                sp_usu.setString(4,fechaCierre);
                sp_usu.setString(5,fechaInicio);
                sp_usu.setString(6,fechaFinal);
                sp_usu.setString(7,estadoCierre);
                sp_usu.setString(8,(String)s.getAttribute("rut"));            
                sp_usu.execute();
                
                Date sqlDateCierre= new Date(formato.parse(fechaCierre).getTime()); 
                sp_usu = _connMy.prepareCall("{call sp_actividad_comercial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,"cierre");
                sp_usu.setLong(2,0);
                sp_usu.setString(3,"");
                sp_usu.setString(4,"");
                sp_usu.setDate(5,sqlDateCierre);
                sp_usu.setString(6,"");
                sp_usu.setString(7,"");
                sp_usu.setString(8,"");
                sp_usu.setString(9,"");
                sp_usu.setLong(10,0);
                sp_usu.setLong(11,0);
                sp_usu.setLong(12,0);
                sp_usu.setString(13, "");
                sp_usu.setString(14, "");
                sp_usu.setInt(15,0);
                sp_usu.setInt(16,0);
                sp_usu.setInt(17,0);
                sp_usu.setString(18,"");
                sp_usu.setString(19,"");
                sp_usu.setString(20,"");
                sp_usu.setString(21,"");
                sp_usu.setString(22,estadoCierre);
                sp_usu.setString(23,fechaInicio);
                sp_usu.setString(24,fechaFinal);   
                sp_usu.setLong(25,0); 
                sp_usu.execute();
            }else
            {
                out.println("No hay Datos");
            }            
        }catch(Exception e){
            _connMy.rollback();
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
            Logger.getLogger(ServletSPEscritorio.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletSPEscritorio.class.getName()).log(Level.SEVERE, null, ex);
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
