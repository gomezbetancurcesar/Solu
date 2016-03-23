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
import java.sql.SQLException;
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
 * @author Sistemas-ltda
 */
@WebServlet(name = "ServletSPClienteSolutel", urlPatterns = {"/ServletSPClienteSolutel"})
public class ServletSPClienteSolutel extends HttpServlet {

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
            HttpSession s = request.getSession();
            Connection _connMy = null;
            
            String variable = "";
            
            String rutCli = "";
            String nomCli = "";
            String contacto ="";
            String direccion ="";
            String nomEje = "";
            String estado ="";
            
            variable = request.getParameter("mod");            
            rutCli = request.getParameter("txt_cliente_rut");
            nomCli = request.getParameter("txt_cliente_nombre");
            contacto = request.getParameter("txt_cliente_contacto");
            direccion =request.getParameter("txt_cliente_direccion");
            nomEje = request.getParameter("txt_cliente_ejecutivo");
            estado = request.getParameter("txt_cliente_estado");                        
            try{
                
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));             
                CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_cliente(?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,variable);
                sp_usu.setString(2, "");
                sp_usu.setString(3,"");
                sp_usu.setString(4,nomEje);
                sp_usu.setString(5, rutCli);
                sp_usu.setString(6,nomCli);               
                sp_usu.setString(7,contacto);
                sp_usu.setString(8,direccion);                
                sp_usu.setString(9,estado);
                
                sp_usu.execute();  
                System.out.println(rutCli);
            }catch(Exception e){
                _connMy.rollback();
                e.printStackTrace();
                System.out.println("ERROR "+e.getMessage());
            }
            finally{
                _connMy.close();
            }
        }
        finally{
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
            Logger.getLogger(ServletSPClienteSolutel.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletSPClienteSolutel.class.getName()).log(Level.SEVERE, null, ex);
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
