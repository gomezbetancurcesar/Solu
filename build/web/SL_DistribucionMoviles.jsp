<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PORTAL SOLUTEL</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
<link rel="stylesheet" type="text/css" href="css/estilo_modulo1.css" />
<link href="css/style_tabla.css" type="text/css" rel="STYLESHEET" />
<link href="css/solutel.css" type="text/css" rel="STYLESHEET" />
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet" />
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/label.js" type="text/javascript"></script>
<script src="js/CargarCombo.js" type="text/javascript" ></script>
<script src="js/CRUD_Distribucion.js" type="text/javascript" ></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>
<script src="js/CargaPlanes.js" type="text/javascript"></script>
<!-- Librerias Jquery -->
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<%
    HttpSession s = request.getSession();
    if(s.getAttribute("nom")==null)
    {
        response.sendRedirect("login.jsp");
    }
    Connection _connMy = null;
    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));  
    String parametroActComercial = request.getParameter("par");
    String cantidad = request.getParameter("cantidad");
    String secuencia = request.getParameter("secuencia");
    String nroNegocio = request.getParameter("negocio");
    String tipoClte = request.getParameter("tipoClte");
    String corrCotiza = request.getParameter("correlativo");
    String tipoServicio = request.getParameter("tipoServicio");
    String estado = request.getParameter("estado");
    String tipoNegocio = request.getParameter("tipoNegocio");
    String serviMovil = request.getParameter("serviMovil");
    String caso = request.getParameter("caso");
    String nomCli = request.getParameter("nomCli");
    String rutCli = request.getParameter("rutCli");  
    String comentario = request.getParameter("comentario");
    String fecha = request.getParameter("fecha");
    String nomEje = request.getParameter("nomEje");
    String rv = request.getParameter("rv"); 
    String supervisor = request.getParameter("supervisor");
    String ultimo = request.getParameter("ultimo");
    String resta = request.getParameter("resta");
    System.out.println(corrCotiza);
%>
<script type="text/javascript">
    $(document).ready(function (){
    cargaTipoPlan();
});
</script>
    
</head>
<body id="principal">    
    <input type="hidden" id="parametroActComercial" value="<%=parametroActComercial%>" />
    <input type="hidden" id="secuencia" value="<%=secuencia%>" />
    <input type="hidden" id="cantidad" value="<%=cantidad%>" />
    <input type="hidden" id="tmpCantidadTotal" value="<%=resta%>" />    
    <input type="hidden" id="corrCotiza" value="<%=corrCotiza%>" />      
    <table class="header" >
    <tr>
        <td id="tablaDistribucion" rowspan="11">
            <div class="etiqueta">
                <center><label><b>Distribución de Móviles</b></label></center>
            </div>            
                <table id="tblDistribucion">
                    <thead>
                        <tr>
                            <th></th>                            
                            <th>PORT-PP-HAB</th>
                            <th>Tipo Plan Antiguo</th>
                            <th>Plan Antiguo</th>
                            <th>Cargo Fijo</th>
                            <th>Tipo Plan Nuevo</th>
                            <th>Plan Nuevo</th>
                            <th>Cargo Fijo</th>
                            <th>UF</th>
                            <th>ARPU</th>
                            <th>Cantidad</th>
                        </tr>
                    </thead>					
                    <tbody>                                      
                    </tbody>
                </table>            
        </td>
        <td rowspan="11">
            <a href="#">
            <img class="boton" border="0" id="IngDistribucion" onclick="ValidaDistribucion('ingreso')" src="images/logotipos/agregar.png" height="25px" width="25px"/>
            </a>
            <br/><br/>
            <a href="#"><img class="boton" border="0" id="ModDistribucion" style="display: none" onclick="ValidaDistribucion('modifica')"  src="images/logotipos/modificar.png" height="25px" width="25px" /></a>
            <br/><br/>
            <a href="#"><img border="0"	id="EliDistribucion" style="display: none" src="images/logotipos/eliminar.png" onclick="TablaDistribucion('elimina')"  height="25px" width="25px"/></a>	
        </td>
        <div>
            <input type="hidden" id="tmpId" value="" />
            <td class="letra" style="padding-top: 30px;">
                Número Móvil inicial:
            </td>
            <td class="letra" style="padding-top: 35px;">
                <input type="text" id="txt_distribucion_nro" maxlength="8" value = "<%=ultimo%>"/>               
            </td>
        </div>
        <td rowspan="6">
            <a href="#">
                <img class="check" src="images/logotipos/check.jpg" border="0" onclick="guardaDistribucion()" height="25px" width="25px" />
            </a>
        </td>
    </tr>
    <tr>
        <td class="letra">
            Tipo Plan Antiguo:
        </td>
        <td>
            <select id="slt_detalleComercial_tipoPlanAnt" onchange="loadPlanAntiguo()">
                <option value="">--Seleccione--</option>                        
            </select>
        </td>        
    </tr>
    <tr>
        <td class="letra" >
            Plan Antiguo:
        </td>
        <td>
            <select onchange="loadCargoFijoAntiguo()" id="slt_detalleComercial_planAnt">
                <option value="">--Seleccione--</option>                
            </select>
        </td>
    </tr>
    <tr>
        <td class="letra">Cargo Fijo:</td>
        <td>
            <input type="text" maxlength="11" id="txt_distribucion_cargoAnt" name="txt_distribucion_cargoAnt" />
        </td> 
    </tr>
    <tr> 
        <td class="letra">
            Tipo Plan Nuevo:
        </td>
        <td>
            <select id="slt_detalleComercial_tipoPlanNue" onchange="loadPlanNuevo()">
                <option value="">--Seleccione--</option>               
            </select>
        </td>				
    </tr>
    <tr>
        <td class="letra">
            Plan Nuevo:
        </td>
        <td>
            <select onchange="loadCargoFijoNuevo()"  id="slt_detalleComercial_PlanNue">
                <option value="">--Seleccione--</option>                
                <option></option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="letra">Cargo Fijo:</td>
        <td>
            <input type="text" maxlength="10" id="txt_distribucion_cargoNue" name="txt_distribucion_cargoNue" />
        </td> 
    </tr>
    <tr>
        <td class="letra">Arpu:</td>
        <td>
            <input type="text" maxlength="10" id="txt_distribucion_arpu" name="txt_distribucion_arpu" />
        </td> 
    </tr>
    <tr>
        <td class="letra">UF:</td>
        <td>
            <input type="text"  maxlength="5" name="txt_distribucion_uf" id="txt_distribucion_uf" />
        </td>
    </tr>
    <tr>
        <td class="letra">PORT-PP-HAB:</td>
        <td>
            <select id="slt_distribucion_portPPHAB" name="slt_distribucion_portPPHAB">
                <option value="">--Seleccione--</option>
                <%
                    String cargaPORTPPHAB = "PORT-PP-HAB";

                    CallableStatement sp_Carga_PORTPPHAB = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                    sp_Carga_PORTPPHAB.setString(1,cargaPORTPPHAB);
                    sp_Carga_PORTPPHAB.execute();
                    final ResultSet CargarPORTPPHAB = sp_Carga_PORTPPHAB.getResultSet();                                                   
                    while(CargarPORTPPHAB.next())
                    {             
                %>
                    <option value="<%=CargarPORTPPHAB.getString("descripcion")%>"><%=CargarPORTPPHAB.getString("descripcion")%></option>
                <%                                                       
                    }
                %>
            </select>
        </td>             
    </tr>
    <tr>        
        <td class="letra">
            Cantidad:
        </td>
        <td>
            <input type="text" id="txt_distribucion_cantidad" maxlength="9" />
        </td>
    </tr>
    <tr>
        <td id="margen">
            <input class="botonera" type="button" value="Volver" onClick="Volver()" />
        </td>
    </tr>
</table>
</body>
</html>