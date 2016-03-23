<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="DAL.conexionBD"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
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
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<!--Codigo Sistemas SA-->

<%
    HttpSession s = request.getSession();  
    Connection _connMy = null;
    String tipoUser = "";
    String timeOut = "";
    int tiempoRestante = 0;
    try{
        if(s.getAttribute("nom")==null)
        {
            response.sendRedirect("login.jsp");
        }
        
        if(s.getAttribute("tipo") != null)
        {
            tipoUser =(String)s.getAttribute("tipo");
        }
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
        Context env = (Context)new InitialContext().lookup("java:comp/env");
        timeOut = (String)env.lookup("TimeOut");
        tiempoRestante = Integer.parseInt(timeOut);  
    }catch(Exception e)
    {
        response.sendRedirect("login.jsp");
    }
%>
<script type="text/javascript">
    var cont = "<%=tiempoRestante%>";
function contador(){        
    cont --;
    if(cont=== 0)
    {
        location.href="login.jsp";
    }else
    {
        setTimeout(contador,1000);
    }
}   
function Actividad()
{
   cont = "<%=tiempoRestante%>";
}
</script>
</head>    
<body id="principal" onmouseover="Actividad()" onload="contador()">
<table id="header">
    <thead>
        <tr>            
            <td><img id="logo" src="images/logotipos/logo_solutel.png" /></td>
                <td colspan ="4">
                    <div class = "tituloModulo">
                        <label for="male"> <%=s.getAttribute("nom")%></label>
                        <b> - <%= s.getAttribute("organizacion")%></b>
                        <a href="login.jsp" >
                            <img src="images/apagar.jpg" border="0"/>

                        </a>
                    </div>
                </td>
        </tr>
        <!--botones pestañas -->
        <tr>
            <td colspan="5" > 
                <div id="pestana">
                    <a class="link" href="SL_Escritorio.jsp" onclick="CambioEsc(cambio)" target="FrGral">
                        Escritorio
                    </a>
                    <a class="link" href="SL_Seleccion_ActividadComercial.jsp" onclick="CambioAct(cambio)" target="FrGral">
                        Actividad Comercial 
                    </a>
                    <a class="link" href="SL_Seleccion_Clientes.jsp" onclick="CambioCli(cambio)" name="clientes"target="FrGral">
                        Clientes
                    </a>
                    <%
                        if(tipoUser.equals("Administrador"))
                        {
                    %>
                        <a class="link" href="SL_Mantencion_Configuracion.jsp" onclick="CambioConf(cambio)" 
                           name="confi" target="FrGral">
                    <%
                        }
                        //validacion de usuario y supervisor para no ver mantenedor
                        if(tipoUser.equals("Usuario")|| tipoUser.equals("Supervisor") || tipoUser.equals("Backoffice"))
                        {
                    %> 
                     <%--cierre de <a>--%>
                        </a>
                        <%--cierre de <a>--%>
                        
                        <a class="link" href="javascript: alert('No tiene Los permisos para ver esta pagina');" disabled style="cursor: pointer;">
                    <%
                        }
                    %>
                        Configuración
                    
                    </a>
                    <%
                        if(tipoUser.equals("Administrador"))
                        {
                    %>
                       <a class="link" href="SL_Comisiones_Venta.jsp" onclick="CambioComision(cambio)" target="FrGral">
                    <%
                        }
                        //validacion de usuario y supervisor para no ver mantenedor
                        if(tipoUser.equals("Usuario")|| tipoUser.equals("Supervisor") || tipoUser.equals("Backoffice"))
                        {
                    %> 
                     <%--cierre de <a>--%>
                        </a>
                        <%--cierre de <a>--%>
                        
                        <a class="link" href="javascript: alert('No tiene Los permisos para ver esta pagina');" disabled style="cursor: pointer;">
                    <%
                        }
                    %>
                        Comisiones Venta                   
                    </a>                            
                </div>
            </td>
        </tr>
        <tr>	
            <td colspan ="5" >
                <div class = "tituloSolicitud" id="cuadro" align="left"><label id="cambio"></label></div>	
            </td>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <td colspan="10"><div id="banner" style="background:url(images/banner-index-verde.png);"></div></td>
        </tr>
        <tr>
            <td colspan="2">
                <img src="images/logo_sistemaspng.png" />
            </td>
            <td colspan="2" id="piePagina">
                <b>Dirección:</b> General Bari #165, Providencia - Santiago<br />
                <b>Teléfono:</b> 28267010<br />
                <b>Email:</b> <a class="email" href="mailto:contacto@sistemassa.cl">contacto@sistemassa.cl</a>					
            </td>
        </tr>
        <tr>
            <td colspan="10"><div id="banner" style="background:url(images/banner-index-verde.png);"></div></td>
        </tr>	
    </tfoot>
    <tbody>
        <tr>
            <td colspan="6">
                <iframe name="FrGral" frameborder="0" src="SL_Escritorio.jsp"></iframe>
            </td>
        </tr>
    </tbody>
</table>
</body>
</html>
