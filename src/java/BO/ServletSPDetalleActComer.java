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
import java.sql.Types;
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
@WebServlet(name = "ServletSPDetalleActComer", urlPatterns = {"/ServletSPDetalleActComer"})
public class ServletSPDetalleActComer extends HttpServlet {

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
            String opcion_Detalle_ActividadComercial = request.getParameter("opcion_Detalle_ActividadComercial"); 
            String nroMovil = request.getParameter("txt_detalleComercial_nroMovil");
            String tipoPlanAnt = request.getParameter("slt_detalleComercial_tipoPlanAnt");
            String tipoPlanNue = request.getParameter("slt_detalleComercial_tipoPlanNue");
            String PlanAnt = request.getParameter("slt_detalleComercial_planAnt");
            String PlanNue = request.getParameter("slt_detalleComercial_PlanNue");
            String cargoFijoAnt = request.getParameter("txt_detalleComercial_cargoFijoAnt");
            String cargoFijoNue = request.getParameter("txt_detalleComercial_cargoFijoNue");
            String port_pp_hab = request.getParameter("slt_detalleComercial_portPPHAB");
            String arpu = request.getParameter("txt_detalleComercial_arpu");
            String corrCotiza = request.getParameter("txt_actComercial_corrCotiza");
            String secuencia = request.getParameter("secuencia");
            //int movil = Integer.parseInt(nroMovil);    
            long movil  = Long.parseLong(nroMovil);
                        
            if(cargoFijoAnt.equals(""))
            {
                cargoFijoAnt = "0";
            }
            try{            
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));                            
                CallableStatement sp_usu = _connMy.prepareCall("{call sp_detalleComer_Tmp(?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,opcion_Detalle_ActividadComercial);
                sp_usu.setLong(2,movil);
                sp_usu.setString(3,tipoPlanAnt);
                sp_usu.setString(4,tipoPlanNue);
                sp_usu.setString(5,PlanAnt);
                sp_usu.setString(6,PlanNue);
                sp_usu.setLong(7,Long.parseLong(cargoFijoAnt));
                sp_usu.setLong(8,Long.parseLong(cargoFijoNue));
                sp_usu.setString(9,port_pp_hab);
                sp_usu.setLong(10,Long.parseLong(arpu));
                sp_usu.setLong(11,Long.parseLong(corrCotiza));
                sp_usu.setLong(12,Integer.parseInt(secuencia));            
                sp_usu.execute();

                String var = "consulta";
                sp_usu = _connMy.prepareCall("{call sp_detalleComer_Tmp(?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,var);
                sp_usu.setInt(2,0);
                sp_usu.setString(3,"");
                sp_usu.setString(4,"");
                sp_usu.setString(5,"");
                sp_usu.setString(6,"");
                sp_usu.setLong(7,0);
                sp_usu.setLong(8,0);
                sp_usu.setString(9,"");
                sp_usu.setLong(10,0);
                sp_usu.setLong(11,Long.parseLong(corrCotiza)); 
                sp_usu.setLong(12,Long.parseLong(secuencia));
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
                    salida += "<tr id='filaTablaDetalle"+cont+"' class='"+cla+"'>";

                    salida += "<td><a id=\"seleccion"+cont+"\" href=\"javascript: onclick=ModificaDetalleComercial("+cont+")\"> >></a>\n" +
                                "<input type=\"hidden\" value=\"0\" id=\"habilitaDetCom\" name=\"habilitaDetCom\" />\n" +
                                "</td> ";
                    salida += "<td id =\"actComerDet_nroMovil"+cont+"\">"+rs.getString("nro_movil")+"</td>";   
                    salida += "<td id =\"actComerDet_portPPHab"+cont+"\">"+rs.getString("port_pp_hab")+"</td>";   
                    salida += "<td id =\"actComerDet_tipoPlanAnt"+cont+"\">"+rs.getString("tipo_plant_ant")+"</td>"; 
                    salida += "<td id =\"actComerDet_planAnt"+cont+"\">"+rs.getString("plan_antiguo")+"</td>"; 
                    salida += "<td id =\"actComerDet_cargoFijoAnt"+cont+"\">"+rs.getString("cargo_fijo_ant")+"</td>"; 
                    salida += "<td id =\"actComerDet_tipoPlanNue"+cont+"\">"+rs.getString("tipo_plan_nue")+"</td>"; 
                    salida += "<td id =\"actComerDet_planNue"+cont+"\">"+rs.getString("plan_nuevo")+"</td>"; 
                    salida += "<td id =\"actComerDet_cargoFijoNue"+cont+"\">"+rs.getString("cargo_fijo_nue")+"</td>"; 
                    salida += "<td id =\"actComerDet_arpu"+cont+"\">"+rs.getString("arpu")+"</td>";                
                    salida += "</tr>";
                    cont++;
                }    
                out.print(salida);            
            }catch(Exception e){
                out.print("Error:"+e.getMessage());
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
            Logger.getLogger(ServletSPErrores.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletSPErrores.class.getName()).log(Level.SEVERE, null, ex);
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
