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
@WebServlet(name = "ServletFiltroComercial", urlPatterns = {"/ServletFiltroComercial"})
public class ServletFiltroComercial extends HttpServlet {

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
            String tipoNegocio = request.getParameter("tipoNegocio");
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");                    
            String ejecutivo = (""+s.getAttribute("tipo")).equals("Usuario") ? (String)s.getAttribute("nom") : request.getParameter("ejecutivo");
            String estado = request.getParameter("estado");
            String fechaInicial = request.getParameter("fechaInicial");
            String fechaFinal = request.getParameter("fechaFinal");   
            String supervisor = request.getParameter("supervisor");   
            System.out.println("Supervisor: "+supervisor);
        try{
            System.out.println((String)s.getAttribute("rut")+" "+(String)s.getAttribute("tipo"));
            _connMy =conexionBD.Conectar((String)s.getAttribute("organizacion"));            
            CallableStatement sp_usu = _connMy.prepareCall("{call sp_filtroActComercial(?,?,?,?,?,?,?,?)}");
            sp_usu.setString(1,tipoNegocio);
            sp_usu.setString(2,ejecutivo);
            sp_usu.setString(3,estado);
            sp_usu.setString(4,fechaInicial);
            sp_usu.setString(5,fechaFinal);       
            sp_usu.setString(6,(String)s.getAttribute("tipo"));       
            sp_usu.setString(7,(String)s.getAttribute("rut"));       
            sp_usu.setString(8,supervisor);       
            sp_usu.execute();
            final ResultSet rs = sp_usu.getResultSet();            
            String cla = "";
            int cont = 0;
            String salida = "";
            while(rs.next())
            {
                if(cont % 2 == 0)
                {                    
                    cla = "alt";
                }else
                {  
                    cla = "";                    
                }
                salida += "<tr id='filaTablaActComercial"+cont+"' class='"+cla+"'>";

                salida += "<td><a id=\"seleccion"+cont+"\" href=\"javascript: onclick=ModificaActComercial("+cont+")\"> >></a>\n" +
                            " <input type=\"hidden\" value=\"0\" id=\"habilitaActCom\" name=\"habilitaActCom\" />\n" +
"                                 <input type=\"hidden\" value=\"\" id=\"corrCotiza\" /></td> ";
                salida += "<td style=\"width: 100px\"  id =\"ActCom_rv"+cont+"\">"+rs.getString("rut_eje")+"</td>";   
                salida += "<td id =\"ActCom_NomEje"+cont+"\">"+rs.getString("nombre_eje")+"</td>";   
                salida += "<td id =\"ActCom_Fecha"+cont+"\">"+rs.getString("fecha")+"</td>"; 
                salida += "<td id =\"ActCom_RutCli"+cont+"\">"+rs.getString("rut_cli")+"</td>"; 
                salida += "<td style=\"width: 150px\" id =\"ActCom_NomCli"+cont+"\">"+rs.getString("nombre_cli")+"</td>"; 
                salida += "<td id =\"ActCom_Caso"+cont+"\">"+rs.getString("caso")+"</td>"; 
                salida += "<td id =\"ActCom_nroNegocio"+cont+"\">"+rs.getString("nro_negocio")+"</td>"; 
                salida += "<td id =\"ActCom_corrCotiza"+cont+"\">"+rs.getString("corr_cotiza")+"</td>"; 
                salida += "<td id =\"ActCom_TipoServi"+cont+"\">"+rs.getString("tipo_servicio")+"</td>"; 
                salida += "<td id =\"ActCom_ServicioMovil"+cont+"\">"+rs.getString("servicios_moviles")+"</td>"; 
                salida += "<td id =\"ActCom_cantMovil"+cont+"\">"+rs.getString("cant_moviles")+"</td>"; 
                salida += "<td id =\"ActCom_estado"+cont+"\">"+rs.getString("estado")+"</td>";    
                salida += "<td id=\"ActCom_estadoCierre<%=cont%>\">"+ rs.getString("estado_cierre")+"</td>";    
                salida += "</tr>";
                cont++;
                }    
            salida += "<input type=\"hidden\" id=\"contador\" value=\""+cont+"\"/>";
                out.print(salida);            
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
