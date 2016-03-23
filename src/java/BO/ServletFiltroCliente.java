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
 * @author Sistemas-ltda
 */
@WebServlet(name = "ServletFiltroCliente", urlPatterns = {"/ServletFiltroCliente"})
public class ServletFiltroCliente extends HttpServlet {

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
            String nomEje = request.getParameter("nomEje");            
            String estado = request.getParameter("estado");
            String rutCli = request.getParameter("rutCli");
            String nomCli = request.getParameter("nomCli");
//            String contacto = request.getParameter("contacto");
//            String direccion = request.getParameter("direccion");
            
        try{                
            
            System.out.println(nomEje);
            System.out.println(estado);
            System.out.println(rutCli);
            System.out.println(nomCli);
//            System.out.println(contacto);
//            System.out.println(direccion);
            
            _connMy =conexionBD.Conectar((String)s.getAttribute("organizacion"));            
            CallableStatement sp_filtro = _connMy.prepareCall("{call sp_filtro_cliente(?,?,?,?)}");
            sp_filtro.setString(1,nomEje);
            sp_filtro.setString(2,estado);
            sp_filtro.setString(3,rutCli);
            sp_filtro.setString(4,nomCli);
                    
            sp_filtro.execute();
            final ResultSet rs = sp_filtro.getResultSet();            
            String estilo = "";
            int cont = 0;
            String salida = "";
            while(rs.next())
            {
                if(cont % 2 == 0)
                {                    
                    estilo = "alt";
                }else
                {  
                    estilo = "";                    
                }
                salida += "<tr id='filaTablaCliente"+cont+"' class='"+estilo+"'>";

                salida += "<td><a id=\"seleccion"+cont+"\" href=\"javascript: onclick=ModificaCliente("+cont+")\"> >></a>\n" +
                            " <input type=\"hidden\" value=\"0\" id=\"habilitaCliente\" name=\"habilitaCliente\" />\n" +
"                                 <input type=\"hidden\" value=\"\" id=\"rut\" /></td> ";
                salida += "<td id =\"Cliente_rut"+cont+"\">"+rs.getString("rut")+"</td>";
                salida += "<td id =\"Cliente_Nombre"+cont+"\">"+rs.getString("nombre")+"</td>"; 
                salida += "<td id =\"Cliente_Contacto"+cont+"\">"+rs.getString("contacto")+"</td>"; 
                salida += "<td id =\"Cliente_Direccion"+cont+"\">"+rs.getString("direccion")+"</td>"; 
                salida += "<td id =\"Cliente_Ejecutivo"+cont+"\">"+rs.getString("ejecutivo")+"</td>";   
                salida += "<td id =\"Cliente_Estado"+cont+"\">"+rs.getString("estado")+"</td>";   
                
                
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
            Logger.getLogger(ServletFiltroCliente.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletFiltroCliente.class.getName()).log(Level.SEVERE, null, ex);
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
