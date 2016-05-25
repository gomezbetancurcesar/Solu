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
@WebServlet(name = "ServletSPActividadComercial", urlPatterns = {"/ServletSPActividadComercial"})
public class ServletSPActividadComercial extends HttpServlet {

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
            String rv = "";
            String rutCli = "";
            String tipoServicio = "";
            String nomEje = "";
            String nomCli = "";
            String fecha = "";
            String caso = "";
            String cantMovil = "";
            String ServicioMovil = "";
            String nroNegocio = "";
            String crm = "";
            String tipoCli = "";
            String estado = "";
            String comentario = "";
            String corrCotiza = "";
            String tipoNegocio = "";
            String secuencia = "";
            String supervisor ="";
            String uf = "";
            
            
            String opcion_ActividadComercial = request.getParameter("opcion_ActividadComercial");
            secuencia = request.getParameter("seq");            
            rv = request.getParameter("txt_actComercial_rv");
            rutCli = request.getParameter("txt_actComercial_rutcli");
            tipoServicio = request.getParameter("slt_actComercial_tipoServicio");
            nomEje = request.getParameter("slt_actComercial_ejecutivo");
            nomCli = request.getParameter("txt_actComercial_nomCli");
            fecha = request.getParameter("txt_actComercial_fecha");
            caso = request.getParameter("txt_actComercial_caso");
            cantMovil = request.getParameter("txt_actComercial_cantMovil");
            ServicioMovil = request.getParameter("slt_actComercial_serviMovil");
            nroNegocio = request.getParameter("txt_actComercial_nroNegocio");
            crm = request.getParameter("chkBox_actComercial_CRM");
            tipoCli = request.getParameter("slt_actComercial_tipoClte");
            estado = request.getParameter("slt_actComercial_status");
            comentario = request.getParameter("txa_actComercial_comentario");
            corrCotiza = request.getParameter("txt_actComercial_corrCotiza");
            tipoNegocio = request.getParameter("slt_actComercial_TipoNegocio");   
            supervisor = request.getParameter("slt_actComercial_supervisor"); 
            uf = request.getParameter("txt_actComercial_uf"); 
            
            if(caso.equals(""))
            {
                caso="0";
            }
            if(nroNegocio.equals(""))
            {
                nroNegocio = "0";
            }
            if(cantMovil.equals(""))
            {
                cantMovil = "0";
            }
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                CallableStatement sp_usu = null;
                
                if(opcion_ActividadComercial.equals("ingreso")){
                    //Creamos el historial de estado SOLO cuando ingrese una nueva actividad comercial, puesto que al editar es el btn avanzar estado el que lo hace
                    String var = "ingreso";
                    sp_usu = _connMy.prepareCall("{call sp_historial(?,?,?,?)}");
                    sp_usu.setString(1,var);                                        
                    sp_usu.setLong(2,Long.parseLong(corrCotiza));
                    sp_usu.setString(3,estado);
                    sp_usu.setString(4,(String)s.getAttribute("rut"));
                    sp_usu.execute();
                }
                
                if(opcion_ActividadComercial.equals("modifica")){
                    estado = "";
                }
                
                Date sqlDate= new Date(formato.parse(fecha).getTime());
                int posicionRv = rv.indexOf('-'); 
                int rvCorto = Integer.parseInt(rv.substring(0,posicionRv));              
                int posicionRutCli = rutCli.indexOf('-'); 
                int rutCliCorto = Integer.parseInt(rutCli.substring(0,posicionRutCli)); 
                           
                sp_usu = _connMy.prepareCall("{call sp_actividad_comercial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,opcion_ActividadComercial);
                sp_usu.setLong(2,Long.parseLong(corrCotiza));
                sp_usu.setString(3,(String)s.getAttribute("tipo"));
                sp_usu.setString(4,tipoNegocio);
                sp_usu.setDate(5,sqlDate);
                sp_usu.setString(6,nomEje);
                sp_usu.setString(7,estado);
                sp_usu.setString(8,rv);
                sp_usu.setString(9,rutCli);
                sp_usu.setString(10,nomCli);
                sp_usu.setLong(11,Long.parseLong(caso));
                sp_usu.setLong(12,Long.parseLong(nroNegocio));
                sp_usu.setString(13, tipoServicio);
                sp_usu.setString(14, ServicioMovil);
                sp_usu.setInt(15,Integer.parseInt(cantMovil));
                sp_usu.setInt(16,rutCliCorto);
                sp_usu.setInt(17,rvCorto);
                sp_usu.setString(18,tipoCli);
                sp_usu.setString(19,crm);
                sp_usu.setString(20,comentario);
                sp_usu.setString(21,supervisor);
                sp_usu.setString(22,"");
                sp_usu.setString(23,"");
                sp_usu.setString(24,"");
                sp_usu.setLong(25, Long.parseLong(secuencia));
                sp_usu.setDouble(26, Double.parseDouble(uf));
                sp_usu.registerOutParameter(1, Types.VARCHAR);
                sp_usu.execute();
                String valorSalida = sp_usu.getString(1);                
                if(valorSalida.equalsIgnoreCase("error ejecucion"))
                {
                    out.println("Ya existe");
                }
                sp_usu = _connMy.prepareCall("{call sp_cargaDetalleComercial(?,?)}");
                sp_usu.setLong(1, Long.parseLong(corrCotiza));
                sp_usu.setLong(2, Long.parseLong(secuencia));
                sp_usu.execute();                
            }catch(Exception e){
                //_connMy.rollback();
                e.printStackTrace();
                System.out.println("ERROR "+e.getMessage());
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
