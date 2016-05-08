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
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Felix
 */
@WebServlet(name = "ServletCargaPlanes", urlPatterns = {"/ServletCargaPlanes"})
public class ServletCargaPlanes extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession s = request.getSession();
            String opcion = request.getParameter("opcion");
            
            if(opcion.equals("TipoPlan")){
                out.print(cargaTipoPlan(s));
            }
            
            if(opcion.equals("Plan")){
                String tipoPlan=request.getParameter("TipoPlan");
                out.print(cargaPlan(s,tipoPlan));
            }
            
            if(opcion.equals("CargaFijo")){
                String tipoPlan=request.getParameter("TipoPlan");
                String plan=request.getParameter("Plan");
                out.print(cargaCargoFijo(s,tipoPlan,plan));
            }
            
        }
    }
    
    public String cargaCargoFijo(HttpSession s,String tipoPlan,String plan){
        String msg="";
        String tabla ="Tipo Plan";
        String resultado;
        try
            {
                CallableStatement sp_Carga = conexionBD.Conectar((String)s.getAttribute("organizacion")).prepareCall("{call sp_cargaplanes(?,?,?)}");
                sp_Carga.setString(1,tabla);
                sp_Carga.setString(2,tipoPlan);
                sp_Carga.setString(3,plan);
                sp_Carga.execute();
                final ResultSet CargarPlan = sp_Carga.getResultSet();                                                   
                while(CargarPlan.next())
                {                  
                    resultado = CargarPlan.getString("descripcion");
                    msg=resultado;
                }
            }catch(Exception e)
            {
                System.out.println(e.toString());
            }
        return msg;
    }
    
    public String cargaPlan(HttpSession s,String tipoPlan){
        String msg="";
        String tabla ="Tipo Plan";
        String plan="";
        String resultado;
        try
            {
                CallableStatement sp_Carga = conexionBD.Conectar((String)s.getAttribute("organizacion")).prepareCall("{call sp_cargaplanes(?,?,?)}");
                sp_Carga.setString(1,tabla);
                sp_Carga.setString(2,tipoPlan);
                sp_Carga.setString(3,plan);
                sp_Carga.execute();
                final ResultSet CargarPlan = sp_Carga.getResultSet();                                                   
                while(CargarPlan.next())
                {                  
                    resultado = CargarPlan.getString("relacion2");
                    msg+="<option value='"+resultado+"'>"+resultado+"</option>";
                }
            }catch(Exception e)
            {
                System.out.println(e.toString());
            }
        return msg;
    }
    
    public String cargaTipoPlan(HttpSession s){
        String msg="";
        String tabla ="Tipo Plan";
        String tipoPlan="";
        String plan="";
        String resultado;
        try
            {
                CallableStatement sp_Carga = conexionBD.Conectar((String)s.getAttribute("organizacion")).prepareCall("{call sp_cargaplanes(?,?,?)}");
                sp_Carga.setString(1,tabla);
                sp_Carga.setString(2,tipoPlan);
                sp_Carga.setString(3,plan);
                sp_Carga.execute();
                final ResultSet CargarPlan = sp_Carga.getResultSet();                                                   
                while(CargarPlan.next())
                {                  
                    resultado = CargarPlan.getString("relacion1");
                    msg+="<option value='"+resultado+"'>"+resultado+"</option>";
                }
            }catch(Exception e)
            {
                System.out.println(e.toString());
            }
        return msg;
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
        processRequest(request, response);
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
        processRequest(request, response);
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
