
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Seleccion Actividad Comercial</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon"/>   
<link rel="stylesheet" type="text/css" href="css/estilo_modulo1.css"/>
<link href="css/style_tabla.css" type="text/css" rel="STYLESHEET"/>
<link href="css/solutel.css" type="text/css" rel="STYLESHEET"/>
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet"/>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/CRUD_ActividadComercial.js" type="text/javascript"></script>
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
    HttpSession s = request.getSession();
    Connection _connMy = null;
    CallableStatement sp_Carga = null;
    int id= 1;
    int cont =0; 
    String supervisor = "";
    String rut = "";
    String tipoUser = "";
    String nroSecuencia="";
    String varCarga = "";
    String secu = "";
    try
    {
        if(s.getAttribute("nom")==null)
        {
            response.sendRedirect("login.jsp");
        }
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
             rut = (String)s.getAttribute("rut");
        }
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
        String query = "select fn_secuencia() as secuencia";
        ResultSet resultQuery = _connMy.createStatement().executeQuery(query);
        while(resultQuery.next())
        {  
            nroSecuencia = resultQuery.getString("secuencia");
        }        
        s.setAttribute("secu",nroSecuencia);
        secu = (String)s.getAttribute("secu");  
    }catch(Exception e)
    {
        System.out.println("Error: "+ e.getMessage());
        response.sendRedirect("login.jsp");
    }
%>
<script type="text/javascript">
$(document).ready(function(){
   $('#tblActComercial').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
        "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
        bFilter: false, bInfo: false,
        "bLengthChange": false,
        "bAutoWidth": false,
       "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7,8,9,10,11,12,13] }]
    });
});
function seleccion_registro_actividadComercial(id){
    var id = parseInt(id);
    var numero = $("#corrCotiza").val();    
    var secu = $("#secu").val();
    if($("#habilitaActCom").val() == 0 || numero == null )
    {
        FuncionErrores(239);
        return false;
    }
    
    var estado = $(".seleccionado").find("[id^='ActCom_estado']").first().text();
    estado = $.trim(estado);
    
    
    var bloqueados = $("#bloqueados").val();
    bloqueados = bloqueados.split("___");
    
    
    
    if(id == 2 && $.inArray(estado, bloqueados) >= 0){
        FuncionErrores(246);
        return false;
        
    }
    
    $.ajax({
        url : 'ServletCargaTmp', 
        data : "secu="+secu+"&correlativo="+numero,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            location.href='SL_Actualiza_ActividadComercial.jsp?par='+id+'&correlativo='+numero+'&secuencia='+secu;                
        }
    });
}
</script>
</head>
<body id="principal"> 
<input type="hidden" id="secu" value="<%=secu%>" />
<input type="hidden" id="bloqueados" value="" />
    <table id="header2">
        <tr>
            <td colspan="5">
                <div class="tablafiltrar">
                    <table align="center">
                        <tr>
                            <td>Tipo Negocio:</td>
                            <td>
                                <select id="slt_filtroComercial_tipoNegocio" name="slt_filtroComercial_tipoNegocio" />
                                    <option value="">--Seleccione--</option>
                                    <%
                                        if(tipoUser.equals("Administrador") || tipoUser.equals("Backoffice") )
                                        {
                                            try
                                            {
                                                varCarga = "Tipo Negocio";                                        
                                                sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                sp_Carga.setString(1,varCarga);
                                                sp_Carga.execute();
                                                final ResultSet CargarMaeTabla = sp_Carga.getResultSet();                                                   
                                                while(CargarMaeTabla.next())
                                                {
                                                    //Si la opcion es "Desarrollo Mediana Empresa", la seleccionamos por defecto (selected)
                                                    if(CargarMaeTabla.getString("descripcion").equals("Desarrollo Mediana Empresa")){
                                                        %>
                                                            <option value="<%=CargarMaeTabla.getString("descripcion")%>" selected><%=CargarMaeTabla.getString("descripcion")%></option>
                                                        <%
                                                    }else{
                                                        %>
                                                            <option value="<%=CargarMaeTabla.getString("descripcion")%>"><%=CargarMaeTabla.getString("descripcion")%></option>
                                                        <%
                                                    }
                                                }
                                            }catch(Exception e)
                                            {
                                                out.print("Error: "+e.getMessage());
                                            }                                    
                                        }
                                        if(tipoUser.equals("Supervisor") || tipoUser.equals("Usuario"))
                                        {
                                            %>
                                            <option value="<%=s.getAttribute("tipoNegocio")%>"><%=s.getAttribute("tipoNegocio")%></option>
                                            <%
                                        }
%> 
                                        
                                </select>
                            </td>
                            <td>Ejecutivo:</td>
                            <td>
                                <select id="slt_filtroComercial_ejecutivo" name="slt_filtroComercial_ejecutivo"/>
                                    <option value="">--Seleccione--</option>     
                                   <%
                                      Statement stmt = null;
                                        ResultSet rsQuery = null;                                       
                                        stmt = _connMy.createStatement();
                                        String q = "";
                                        
                                        if(tipoUser.equals("Administrador") || tipoUser.equals("Backoffice"))
                                        {
                                            q = "SELECT nombre_user FROM sl_mae_usuarios where tipo='Usuario'";                                            
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
                            </td>
                            <td>Supervisor:</td>
                            <td>
                                <select id="slt_filtroComercial_supervisor" name="slt_filtroComercial_supervisor"/>
                                    <option value="">--Seleccione--</option>     
                                   <%
                                        //Statement stmt = null;
                                        //ResultSet rsQuery = null;                                       
                                        stmt = _connMy.createStatement();
                                        //String q = "";
                                        
                                        if(tipoUser.equals("Administrador") || tipoUser.equals("Backoffice"))
                                        {
                                            q = "SELECT nombre_user FROM sl_mae_usuarios where tipo='Supervisor'";                                            
                                        }                                     
                                        if(tipoUser.equals("Supervisor"))
                                        {
                                            q = "SELECT nombre_user FROM sl_mae_usuarios"
                                                    + " where supervisor='"+rut+"' and tipo='Supervisor'";
                                        }
                                        if(tipoUser.equals("Usuario"))
                                        {
                                            q = "SELECT nombre_user FROM sl_mae_usuarios"
                                                    + " where rut='"+rut+"' and tipo='Supervisor'";
                                        }                                                     
                                        rsQuery = stmt.executeQuery(q);
                                        while(rsQuery.next())
                                        {             
                                    %>
                                            <option value="<%=rsQuery.getString("nombre_user")%>"><%=rsQuery.getString("nombre_user")%></option>
                                    <%                                                       
                                        }
                                    %>
                            </td>
                            <td>Estado:</td>
                            <td>
                                <select id="slt_filtroComercial_estado" name="slt_filtroComercial_estado">
                                     <option value="">--Seleccione--</option>
                                    <%
                                        String varCargaEstado = "Estado_ActCom";
                                        if(tipoUser.equals("Usuario") || tipoUser.equals("Supervisor"))
                                        {
                                            sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,?,'')}");
                                            sp_Carga.setString(1,varCargaEstado);
                                            sp_Carga.setString(2,"Usuario");
                                        }
                                        if(tipoUser.equals("Backoffice"))
                                        {
                                            sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,?,'')}");
                                            sp_Carga.setString(1,varCargaEstado);
                                            sp_Carga.setString(2,"Backoffice");
                                        }
                                        if(tipoUser.equals("Administrador"))
                                        {
                                            sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                            sp_Carga.setString(1,varCargaEstado);                                            ;
                                        }
                                        sp_Carga.execute();
                                        final ResultSet CargarEstado = sp_Carga.getResultSet();                                                   
                                        while(CargarEstado.next())
                                        {             
                                    %>
                                            <option value="<%=CargarEstado.getString("descripcion")%>"><%=CargarEstado.getString("descripcion")%></option>
                                    <%                                                       
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Fecha &nbsp;&nbsp;Desde:</td>	
                            <td>
                                <%
                                    Date date = new Date();
                                    DateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
                                    Calendar calendario = Calendar.getInstance();
                                    calendario.setTime(date);
                                    
                                    calendario.set(Calendar.DAY_OF_MONTH, calendario.getActualMinimum(Calendar.DAY_OF_MONTH));
                                    String primerDiaMes = formato.format(calendario.getTime());
                                    
                                    calendario.set(Calendar.DAY_OF_MONTH, calendario.getActualMaximum(Calendar.DAY_OF_MONTH));
                                    String ultimoDiaMes = formato.format(calendario.getTime());
                                %>
                                <!--Codigo Sistemas SA-->
                                <input type = "text" readonly value="<%out.print(primerDiaMes);%>" name = "txt_filtroComercial_ingreso" id= "txt_filtroComercial_ingreso" size="12" />
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador" />
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                    inputField     :    "txt_filtroComercial_ingreso",     // id del campo de texto 
                                    ifFormat     :     "%Y-%m-%d",     // formato de la fecha que se escriba en el campo de texto 
                                    button     :    "lanzador"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>
                            </td>
                            <td align="right">Fecha&nbsp;&nbsp; Hasta:</td>
                            <td>
                                <input type = "text" readonly value="<%out.print(ultimoDiaMes);%>" name="txt_filtroComercial_final" id = "txt_filtroComercial_final" size="12"/>
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanza" />
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                    inputField     :    "txt_filtroComercial_final",     // id del campo de texto 
                                    ifFormat     :     "%Y-%m-%d",     // formato de la fecha que se escriba en el campo de texto 
                                    button     :    "lanza"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>
                                <!--Codigo Sistemas SA-->
                            </td>
                            <td colspan="2">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input class ="botonera" type="submit" name="btnBuscar" onclick="filtroActComercial()" value="Buscar" />                                                            
                                <input class ="botonera" type="submit" name="btnEliminaFiltro" onclick="window.location.reload()" value="Elimina Filtro" />                                
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <div class="datagrid">
                    <table id="tblActComercial">
                        <thead>
                            <tr>
                                <th width="2.4%"></th>
                                <th width="2.93%">RV</th>
                                <th width="5.9%">Ejecutivo</th>
                                <th width="5.34%">Fecha</th>
                                <th width="6.17%">Rut Cliente</th>
                                <th width="19.03%">Cliente</th>
                                <th width="3.9%">Caso</th>
                                <th width="6.8%">N&uacute;mero Negocio</th>
                                <th width="7.26%">Correlativo Cotizaci&oacute;n</th>
                                <th width="7.14%">Tipo Servicio</th>
                                <th width="9.1%">Servicios M&oacute;viles</th>
                                <th width="6.8%">Cantidad M&oacute;viles</th>
                                <th width="6.17%">Estado</th>
                                <th width="10.17%">Tipo Negocio</th>
<!--                                <th width="7.37%">Estado Cierre</th>-->
                            </tr>
                        </thead>                        
                        <tbody>                            
                            <%                                
                                String var = "consulta_N";
                                
                                CallableStatement sp_usu = _connMy.prepareCall("{call sp_actividad_comercial(?,?,?,?,?,?,?,?,'','1','2','3','','','4','5','6','','','','','','','','0','0')}");
                                sp_usu.setString(1,var);
                                sp_usu.setInt(2,0);
                                sp_usu.setString(3,tipoUser);
                                sp_usu.setString(4,"");
                                sp_usu.setDate(5,null);                                
                                sp_usu.setString(6,"");
                                sp_usu.setString(7,"");
                                sp_usu.setString(8,(String)s.getAttribute("rut"));                                                                
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
                                    out.println("<tr id='filaTablaActComercial"+cont+"' class='"+cla+"'>");
                            %>
                            <td>
                                <a href="javascript: onclick=ModificaActComercial(<%=cont%>)"> >></a>
                                <input type="hidden" value="0" id="habilitaActCom" name="habilitaActCom" />
                                <input type="hidden" value="" id="corrCotiza" />
                            </td>
                            <td id="ActCom_rv<%=cont%>"><%= rs.getString("rut_eje")%></td>
                            <td id="ActCom_NomEje<%=cont%>"><%= rs.getString("nombre_eje")%></td>
                            <td id="ActCom_Fecha<%=cont%>"><%=rs.getString("fecha")%></td>
                            <td id="ActCom_RutCli<%=cont%>"><%= rs.getString("rut_cli")%></td>
                            <td id="ActCom_NomCli<%=cont%>"><%= rs.getString("nombre_cli")%></td>
                            <td id="ActCom_Caso<%=cont%>"><%= rs.getString("caso")%></td>
                            <td id="ActCom_nroNegocio<%=cont%>"><%= rs.getString("nro_negocio")%></td>
                            <td id="ActCom_corrCotiza<%=cont%>"><%= rs.getString("corr_cotiza")%></td>
                            <td id="ActCom_TipoServi<%=cont%>"><%= rs.getString("tipo_servicio")%></td>
                            <td id="ActCom_ServicioMovil<%=cont%>"><%= rs.getString("servicios_moviles")%></td>                            
                            <td id="ActCom_cantMovil<%=cont%>"><%= rs.getString("cant_moviles")%></td>
                            <td id="ActCom_estado<%=cont%>"><%= rs.getString("estado")%></td>
                            <td id="ActCom_tipoNeg<%=cont%>"><%= rs.getString("tipo_negocio")%></td>
<!--                            <td id="ActCom_estadoCierre<%=cont%>"><%= rs.getString("estado_cierre")%></td>-->
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
                if(!tipoUser.equals("Backoffice")){
                    %><input class ="botonera" type="button" name="btn_actComercial_Ingresa" value="Ingresar" onClick="window.location.href='SL_Actualiza_ActividadComercial.jsp?par=1&secuencia='+<%=secu%>"/>	<%;
                }%> 
                <input class ="botonera" type="submit" name="btn_actComercial_Modifica" id="btn_actComercial_Modifica" value="Modificar" onClick="seleccion_registro_actividadComercial(2)" />	
                <input class ="botonera" type="submit" name="btn_actComercial_Consulta" value="Consultar" onClick="seleccion_registro_actividadComercial(3)"  />                
<!--                <input class ="botonera" style="display: none" type="button" onclick="desmarca_registro_actividadComercial()" id="btn_actComercial_cancela" name="btn_actComercial_cancela" value="Desmarcar" />-->
            </td>	
        </tr>
    </table>                            
</body>
<script>
    $(document).ready(function(){
        //Cargamos los estados que estan bloqueados de edicion segun el tipo de usuario
         $.ajax({
            url: "ServletBloqueoModActividad",
            success: function(bloqueados){
                $("#bloqueados").val(bloqueados);
            }
        });
    });
</script>
</html>
    