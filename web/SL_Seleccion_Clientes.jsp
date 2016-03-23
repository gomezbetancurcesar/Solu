<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
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

<link href="css/calendario.css" type="text/css" rel="stylesheet"/>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/label.js" type="text/javascript"></script>
<script src="js/CRUD_Clientes.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>

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
<%  
    int id= 1;
    int cont =0;
    HttpSession s = request.getSession();  
    String tipoUser = "";
    String rut = "";
    String nom= "";
     boolean showIngresar = true;
    boolean showModificar = true;
    if(s.getAttribute("nom")==null)
    {
        response.sendRedirect("login.jsp");
    }
    nom = (String)s.getAttribute("nom");
    if(s.getAttribute("tipo") != null)
    {
        tipoUser =(String)s.getAttribute("tipo");
    }
    if(s.getAttribute("rut")!= null)
    {
        rut = (String)s.getAttribute("rut");
    }
    Connection _connMy = null;
    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
//    if(_connMy == null)
//    {
//        response.sendRedirect("login.jsp");
//    }
%>
<script type="text/javascript">
        $(document).ready(function(){
   $('#tblCliente').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
        "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
        bFilter: false, bInfo: false,
        "bLengthChange": false,
        //"aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7,8,9,10,11,12,13,14] }]
        
        } );
});
//function seleccion(){
//    if($("#habilitaCliente").val() == 0)
//    {
//        alert("No hay un elemento seleccionado");
//        return false;
//    }
//
//    if($("#habilitaCliente").val()!==0) 
//    {        
//        var rut = $("#rut").val();
//        location.href='SL_Actualiza_Clientes.jsp?par=2&opcion='+rut;
//    }
//    
//}

    function seleccion_registro_clientes(id){
    if($("#habilitaCliente").val() == 0)
    {
        alert("No hay un elemento seleccionado");
        return false;
    }
    if($("#habilitaCliente").val()!==0) 
    {        
        var rut = $("#rut").val();
        location.href='SL_Actualiza_Clientes.jsp?par='+id+'&opcion='+rut;
    }
   }

</script>

</head>
<body id="principal">
    <table id="header" align="center" >
        <tr>
            <td colspan="5">
                <div class="tablafiltrar">
                    <table align="center" >
                        <tr>
                            <td>Ejecutivo:</td>
                            <td>
                                <select name="filtro_cliente_ejecutivo" id="filtro_cliente_ejecutivo">
                                     <option value="">--Seleccione--</option>
                                    <%
                                        Statement stmt = null;
                                        ResultSet rsQuery = null;                                       
                                        stmt = _connMy.createStatement();
                                        String q = "";
                                        
                                        if(tipoUser.equals("Administrador") || tipoUser.equals("Backoffice"))
                                        {
                                            q = "SELECT nombre_user FROM sl_mae_usuarios";                                            
                                        }  
                                         if(tipoUser.equals("Backoffice")){
                                                showIngresar = false;
                                                showModificar = false;
                                         }
                                        if(tipoUser.equals("Supervisor"))
                                        {
                                            q = "SELECT nombre_user FROM sl_mae_usuarios"
                                                    + " where supervisor='"+rut+"'";
                                        }
                                        if(tipoUser.equals("Usuario"))
                                        {
                                            q = "SELECT nombre_user FROM sl_mae_usuarios"
                                                    + " where rut='"+rut+"'";
                                        }                                                     
                                        rsQuery = stmt.executeQuery(q);
                                        while(rsQuery.next())
                                        {             
                                    %>
                                            <option value="<%=rsQuery.getString("nombre_user")%>"><%=rsQuery.getString("nombre_user")%></option>
                                    <%                                                       
                                        }
                                    %>
                                </select>
                            </td>
                            <td>Estado:</td>
                            <td>					
                                <select name="filtro_cliente_estado" id="filtro_cliente_estado">
                                     <option value="">--Selecione--</option>
                                                <%
                                                    String varCarga = "Estado_Cliente";
                                                    
                                                    CallableStatement sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                    sp_Carga.setString(1,varCarga);
                                                    sp_Carga.execute();
                                                    final ResultSet CargarMaeTabla = sp_Carga.getResultSet();                                                   
                                                    while(CargarMaeTabla.next())
                                                    {             
                                                %>
                                                <option value="<%=CargarMaeTabla.getString("descripcion")%>"><%=CargarMaeTabla.getString("descripcion")%></option>
                                                <%                                                       
                                                    }
                                                %>
                                </select>
                            </td>			
                            <td id="botonBuscar">
                                <input class ="botonera" type="submit" name="btnBuscar"  onClick="filtroCliente()"value="Buscar"/>
                            </td>
                                
                        </tr>
                        <tr>
                            <td>Rut Cliente:</td>
                            <td><input type="text" name="filtro_cliente_rut" id="filtro_cliente_rut" /></td>
                            <td>Nombre Cliente:</td>
                            <td><input type="text" name="filtro_cliente_nombre" id="filtro_cliente_nombre" /></td>
                            <td id="botonEliminarFiltro">
                                <input class ="botonera" type="submit" name="botonEliminarFiltro"  value="Eliminar Filtro" onclick="window.location.reload()"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>	
        </tr>
        <tr>
            <td colspan="5">
                <div class="datagrid" align="center">
                    <table class="centerCli" id="tblCliente" >
                        <thead>
                            <tr>
                                <th>
                                <th id="cliente">Rut Cliente</th>
                                <th id="cliente">Nombre Cliente</th>
                                <th id="cliente">Contacto</th>
                                <th id="cliente">Dirección</th>
                                <th id="cliente">Ejecutivo</th>
                                <th id="cliente">Estado</th>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                
                                String op = "consulta_N";
                                
                                CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_cliente(?,?,?,?,'','','','','')}");
                                sp_usu.setString(1,op);
                                sp_usu.setString(2,tipoUser);
                                sp_usu.setString(3, rut);
                                sp_usu.setString(4, nom);
                                sp_usu.execute();
                                final ResultSet rs = sp_usu.getResultSet();
                                String estilo = "";
                                while(rs.next())
                                {
                                    if(cont % 2 == 0)
                                    {                                            
                                        estilo = "alt";
                                    }else
                                    {  
                                        estilo = "";                                            
                                    }
                                    out.println("<tr id='filaTablaCliente"+cont+"' class='"+estilo+"'>");
                            %>
                            
                            <td>
                                    <a href="javascript: onclick=ModificaCliente(<%=cont%>)"> >> </a>
                                    <input type="hidden" value="0" id="habilitaCliente" name="habilitaCliente" />
                                    <input type="hidden" value="" id="rut" name="rut" />
                                </td>
                                   
                                <td id="Cliente_rut<%=cont%>"><%= rs.getString("rut")%></td>
                                <td id="Cliente_Nombre<%=cont%>"><%= rs.getString("nombre")%></td>
                                <td id="Cliente_Contacto<%=cont%>"><%= rs.getString("contacto")%></td>
                                <td id="Cliente_Direccion<%=cont%>"><%=rs.getString("direccion")%></td>
                                <td id="Cliente_Ejecutivo<%=cont%>"><%= rs.getString("ejecutivo")%></td>
                                <td id="Cliente_Estado<%=cont%>"><%= rs.getString("estado")%></td>
                            
                            <%
                                    out.println("</tr>");                                   
                                    cont ++;
                                }
                            
                            %>

                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
        <!--Sistemas sa 20/10/2015-->
        <td>
            
        <%
            if(showIngresar){
                %>
                    <input class ="botonera" type="submit" name="btnIngresa" value="Ingresar" onClick="window.location.href='SL_Actualiza_Clientes.jsp?par=1'"/>    
                <%
            }
            if(showModificar){
                %>
                    <input class ="botonera" type="submit" name="btnModifica" value="Modificar" onClick="seleccion_registro_clientes(2)"/>  
                <%
            }
        %>
        <input class ="botonera" type="submit" name="btnConsulta" value="Consultar" onClick="seleccion_registro_clientes(3)"/>
<!--    <input class ="botonera" style="display: none" type="button" onclick="CancelaCliente()" id="btn_Cliente_Cancelar" name="btn_Cliente_Cancelar" value="Desmarcar" />-->
        </td>	
        </tr>

    </table>
</body>
</html>