<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="DAL.conexionBD"%>
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
<link href="css/calendario.css" type="text/css" rel="stylesheet"/>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/CRUD_ActividadComercial.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>
<script src="js/FuncionComision.js" type="text/javascript"></script>
<!-- Librerias Jquery -->
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.dataTables.js" type="text/javascript"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<!--Codigo Sistemas SA-->
<%
    HttpSession s = request.getSession();
    if(s.getAttribute("nom")==null)
    {
        response.sendRedirect("login.jsp");
    }      
    Connection _connMy = null;
    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
//    if(_connMy == null)
//    {
//        response.sendRedirect("login.jsp");
//    }   
%>
<script type="text/javascript">
    function retornarFecha()
    {
      var fecha="";
      fecha=new Date();
      var cadena=fecha.getFullYear()+'-'+(fecha.getMonth()+1)+'-'+fecha.getDate();
      return cadena;
    }    
    $(document).ready(function(){
        $("#txt_comision_fechaHoy").val(retornarFecha());        
    });           
</script>
</head>
<body id="principal">
    <input type="hidden" id="hid_comision_fechaInicial" />
    <input type="hidden" id="hid_comision_fechaFinal" />
    <input type="hidden" id="hid_comision_anio" />
    <input type="hidden" id="hid_comision_mes" />
    <table id="tablaGeneral">
        <!--barra de color -->
        <tr>
            <td rowspan="9" id="tablaGeneralTd">
                <div class="etiqueta">
                    <center><label><b>Historial Cierre</b></label></center>
                </div>                             
                    <table  id="tblComision">
                        <thead>
                            <tr> 
                                <th></th>
                                <th>Año</th>
                                <th>Mes</th>
                                <th>Fecha Cierre</th>
                                <th>Fecha Inicio</th>
                                <th>Fecha Termino</th>
                                <th>Estado</th>
                                <th>Rut Usuario</th>
                                <th>Nombre Usuario</th>
                            </tr>
                        </thead>						
                        <tbody>                                                      
                                <%
                                int cont =0;
                                String var = "consulta";
                                CallableStatement sp_usu = _connMy.prepareCall("{call sp_Comision(?,0,0,'2015-01-02','2015-01-02','2015-01-02','','')}");
                                sp_usu.setString(1,var);
                                sp_usu.execute();
                                final ResultSet rs = sp_usu.getResultSet();
                                String cla = "";
                                while(rs.next())
                                {
                                    if(cont % 2 == 0)
                                    {

                                        cla = "alt";
                                    }else
                                    {  
                                        cla = "";

                                    }
                                    out.println("<tr id='filaComision"+cont+"' class='"+cla+"'>");
                            %>                               
                                <td>
                                    <a href="#" onclick="seleccionComision(<%=cont%>);">>></a>
                                    <input type="hidden" id="habilitaComision" value="0" />
                                </td>
                                <td id="comision_anio<%=cont%>"><%= rs.getString("anio")%></td>
                                <td id="comision_mes<%=cont%>"><%= rs.getString("mes")%></td>
                                <td id="comision_fechaCierre<%=cont%>"><%= rs.getString("fecha_cierre")%></td>
                                <td id="comision_fechaInicio<%=cont%>"><%= rs.getString("fecha_inicio")%></td>
                                <td id="comision_fechaFinal<%=cont%>"><%= rs.getString("fecha_termino")%></td>
                                <td id="comision_estado<%=cont%>"><%= rs.getString("estado")%></td>
                                <td id="comision_rut<%=cont%>"><%= rs.getString("rutUser")%></td>
                                <td id="comision_nomUser<%=cont%>"><%= rs.getString("nomUser")%></td>
                            <%   
                                    out.println("</tr>");                                   
                                    cont ++;
                                }
                            %>									                                                    						                            	
                        </tbody>
                </table>  
            </td>
        </tr>  
                        
        <tr>      
            <td style="padding-top: 150px">
                <input class ="botonera" type="button" onclick="excel()" id="ExcelComision" value="Exportar Excel" />               
            </td>            
            <td style="padding-left: 50px">
                <div style="border: 1px solid #800000">
                    <center><h2 class="letra">Proceso Mensual</h2></center>
                    <table>                        
                        <tr>
                            <td class="letra">Fecha Inicio:</td>
                                <td>
                                <input type = "text" readonly name = "txt_comision_inicio" id = "txt_comision_inicio" size="12"/>
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanza" />
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                    inputField     :    "txt_comision_inicio",     // id del campo de texto 
                                    ifFormat     :     "%Y-%m-%d",     // formato de la fecha que se escriba en el campo de texto 
                                    button     :    "lanza"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>
                <!--Codigo Sistemas SA-->
                            </td>
                        </tr>
                        <tr>
                            <td class="letra">Fecha Final:</td>
                                <td>
                                    <input readonly type = "text" name = "txt_comision_final" id = "txt_comision_final" size="12"/>
                                    <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha final" id="lanzaFinal" />
                                    <!-- script que define y configura el calendario--> 
                                    <script type="text/javascript"> 
                                        Calendar.setup({ 
                                        inputField     :    "txt_comision_final",     // id del campo de texto 
                                        ifFormat     :     "%Y-%m-%d",     // formato de la fecha que se escriba en el campo de texto 
                                        button     :    "lanzaFinal"     // el id del botón que lanzará el calendario 
                                        }); 
                                    </script>
                                    <!--Codigo Sistemas SA-->
                            </td>
                        </tr>
                        <tr>
                            <td class="letra">Año:</td>
                            <td class="letra"><input type="text" maxlength="4" name="txt_comision_anio" id="txt_comision_anio" /></td>
                        </tr>
                        <tr>
                            <td class="letra">Mes:</td>
                            <td class="letra">
                                <select name="slt_comision_mes" id="slt_comision_mes">
                                    <option value="">--Seleccione--</option>
                                    <option value="01">Enero</option>
                                    <option value="02">Febrero</option>
                                    <option value="03">Marzo</option>
                                    <option value="04">Abril</option>
                                    <option value="05">Mayo</option>
                                    <option value="06">Junio</option>
                                    <option value="07">Julio</option>
                                    <option value="08">Agosto</option>
                                    <option value="09">Septiembre</option>
                                    <option value="10">Octubre</option>
                                    <option value="11">Noviembre</option>
                                    <option value="12">Diciembre</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="letra">
                                Fecha de hoy:
                            </td>
                            <td class="letra">
                                <input type = "text" readonly name = "txt_comision_fechaHoy" id= "txt_comision_fechaHoy" size="12" />                             
                            </td>
                        </tr>
                        <tr>   
                            <td class="letra">Estado: </td>
                            <td class="letra">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Parcial<input type="radio" name="radiosComision" id="rd_comision_PA" value="PA"  />
                            </td>               
                        </tr>	
                        <tr>                            
                            <td class="letra" colspan="2" align="right" style="padding-right: 50px">
                                Definitivo<input type="radio" name="radiosComision" id="rd_comision_DE" value="DE" />
                            </td>  
                        </tr>
                        <tr>
                            <td colspan="2" id="cierreDeMes" >
                                <input class ="botonera" type="button" onclick="ValidaComision()" id="btn_Cierre" value="Procesar" />
                            </td>            
                        </tr>	     
                    </table>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>