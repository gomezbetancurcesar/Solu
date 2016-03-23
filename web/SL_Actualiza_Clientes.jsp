<%@page import="java.sql.Connection"%>
<%@page import="java.awt.Button"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PORTAL SOLUTEL</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
<link href="css/style_tabla.css" type="text/css" rel="stylesheet" />
<link href="css/solutel.css" type="text/css" rel="stylesheet" />
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet" /> 
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/CRUD_Clientes.js" type="text/javascript"></script>
<script src="js/validaciones.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>

<script src="js/ValidacionCliente.js" type="text/javascript"></script>
<script src="js/validaciones.js" type="text/javascript"></script>
<script src="js/label.js" type="text/javascript"></script>
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
    String rutCli ="";
    String nomCli ="";
    String contacto ="";
    String direccion="";
    String nomEje="";
    String estado="";
    String tipoUser = "";
    String supervisor = "";
    String rutUser = "";
    String nom= "";
    Connection _connMy = null;
    if(s.getAttribute("nom")==null)
    {
        response.sendRedirect("login.jsp");
    }
    nom = (String)s.getAttribute("nom");
    if(s.getAttribute("tipo") != null)
    {
        tipoUser =(String)s.getAttribute("tipo");
    }
    if(s.getAttribute("supervisor")!= null)
    {
         supervisor = (String)s.getAttribute("supervisor");
    }
    if(s.getAttribute("rut")!= null)
    {
         rutUser = (String)s.getAttribute("rut");
    }
    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
//    if(_connMy == null)
//    {
//        response.sendRedirect("login.jsp");
//    }
//    
    int id = Integer.parseInt(request.getParameter("par"));  
%>
<script  type="text/javascript">
$(document).ready(function (){        
  
    $("#txt_cliente_rut").val("<%=rutCli%>");
    $("#txt_cliente_nombre").val("<%=nomCli%>");
    $("#txt_cliente_contacto").val("<%=contacto%>");
    $("#txt_cliente_direccion").val("<%=direccion%>");
    $("#txt_cliente_ejecutivo").val("<%=nom%>");
    $("#txt_cliente_estado").val("<%=estado%>");        
}
        );
</script>
<%
    if(id == 2)
    {        
        String rut = request.getParameter("opcion");
        String opcion = "consulta";
        
        CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_cliente(?,?,?,?,?,'','','','')}");
        sp_usu.setString(1,opcion);
        sp_usu.setString(2,"");
        sp_usu.setString(3,"");
        sp_usu.setString(4, "");
        sp_usu.setString(5, rut);
        
        sp_usu.execute();
        
        final ResultSet rs = sp_usu.getResultSet();
        while(rs.next())            
        {
            rutCli = rs.getString("rut");
            nomCli = rs.getString("nombre");
            contacto = rs.getString("contacto");
            direccion = rs.getString("direccion");
            nomEje  = rs.getString("ejecutivo");
            estado = rs.getString("estado");            
        }
    
%>

<%--script para traer datos al ingresar por opcion modificar--%>
<script type="text/javascript">
$(document).ready(function (){        
  
    $("#txt_cliente_rut").val("<%=rutCli%>").attr("disabled",true);
    $("#txt_cliente_nombre").val("<%=nomCli%>");
    $("#txt_cliente_contacto").val("<%=contacto%>");
    $("#txt_cliente_direccion").val("<%=direccion%>");
    $("#txt_cliente_ejecutivo").val("<%=nom%>");
    $("#txt_cliente_estado").val("<%=estado%>");        
}
        );
</script>
    <%
    }
%>
<%
    if(id == 3)
    {        
        String rut = request.getParameter("opcion");
        String opcion = "consulta";
        
        CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_cliente(?,?,?,?,?,'','','','')}");
        sp_usu.setString(1,opcion);
        sp_usu.setString(2,"");
        sp_usu.setString(3,"");
        sp_usu.setString(4, "");
        sp_usu.setString(5, rut);
        
        sp_usu.execute();
        
        final ResultSet rs = sp_usu.getResultSet();
        while(rs.next())            
        {
            rutCli = rs.getString("rut");
             nomCli = rs.getString("nombre");
             contacto = rs.getString("contacto");
             direccion = rs.getString("direccion");
             nomEje  = rs.getString("ejecutivo");
             estado = rs.getString("estado");            
        }
        
    %>
    <script type="text/javascript">
        $(document).ready(function (){    

        $("#txt_cliente_rut").val("<%=rutCli%>");
        $("#txt_cliente_nombre").val("<%=nomCli%>");
        $("#txt_cliente_contacto").val("<%=contacto%>");
        $("#txt_cliente_direccion").val("<%=direccion%>");
        $("#txt_cliente_ejecutivo").val("<%=nom%>");
        $("#txt_cliente_estado").val("<%=estado%>");
        $("#btn_ingresar").css("display","none");
        
    
        }
        );

</script>

    <%
    }
%>
</head>

<body id="principal">
    
    <table id="header" >
        <!--Formulario Ingresar-->
        <tr>
            <td colspan="5">
                <div class="formularioIngresar">
                    <form action="" method="post">
                    <table class="tblCliActualiza">
                        <tr>
                            <td colspan = 2>FORMULARIO<hr/></td>	
                        </tr>
                        <tr>
                            <td>Rut Cliente: </td>
                            <td><input  maxlength="11" type="text" name="txt_cliente_rut" id="txt_cliente_rut"  /></td>
                        </tr>	
                        <tr>
                            <td>Nombre Cliente: </td>
                            <td><input class="nombre" type="text" id="txt_cliente_nombre" name="txt_cliente_nombre" maxlength="40" /></td>					
                        </tr>
                         <tr>
                            <td>Dirección: </td> 
                            <td><input class="direccion" type="t
                                       ext" id="txt_cliente_direccion" name="txt_cliente_direccion" maxlength="50"/></td> 
                        </tr>
                        <tr>
                            <td>Contacto: </td>
                            <td><input class="contacto" type = "text" id="txt_cliente_contacto" name="txt_cliente_contacto" maxlength="20"/></td>
                        </tr>
                       
                        <tr>
                            <td>Ejecutivo: </td>
                            <td>
                  <!--cargar combo ejecutivo-->
                                <input class="contacto" disabled="disabled" name="txt_cliente_ejecutivo" id="txt_cliente_ejecutivo" />                                   
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Estado: </td>
                            
                            <td><select class="contacto" id="txt_cliente_estado" name="txt_cliente_estado" 
                                        <% if(tipoUser.equals("Usuario")){%> disabled=""<% } %>>
                                    
                                    <option value="">--Selecione--</option>
                                                <%
                                                    String CargaCliente = "Estado_Cliente";
                                                   
                                                    CallableStatement sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                    sp_Carga.setString(1,CargaCliente);
                                                    sp_Carga.execute();
                                                    final ResultSet cargaEstado_Notificaciones = sp_Carga.getResultSet();                                                   
                                                    while(cargaEstado_Notificaciones.next())
                                                    {             
                                                %>
                                                <option value="<%=cargaEstado_Notificaciones.getString("descripcion")%>"><%=cargaEstado_Notificaciones.getString("descripcion")%></option>
                                                <%                                                       
                                                    }
                                                %>
                                </select>
                            </td>
                                
                            
                        </tr>
                    </table>	
                                </form>
                </div>	
            </td>
        </tr>	
    
        <tr>
            <td class="tblCliActualiza">
                <input id ="btn_ingresar" class ="botonera" type="button" name="btn_Cliente_Ingresar" value="Grabar" onClick="FuncionValidaCliente(<%=id%>)" />
                <input id ="btn_Cancelar" class ="botonera" type="button" name="btn_Cliente_Cancelar" value="Cancelar" onClick="window.location.href='SL_Seleccion_Clientes.jsp'" />
<!--                <a class="botonera" href="SL_Seleccion_Clientes.jsp">
                    Cancelar
                </a>-->
                
            </td>
        </tr>		
    </table>
        
</body>
</html>