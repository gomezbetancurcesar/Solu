
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ingreso Actividad Comercial</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
<link href="css/style_tabla.css" type="text/css" rel="stylesheet" />
<link href="css/solutel.css" type="text/css" rel="stylesheet" />
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet" /> 
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/CRUD_ActividadComercial.js" type="text/javascript"></script>
<script src="js/validaciones.js" type="text/javascript"></script>
<script src="js/ValidacionActividadComercial.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>
<script src="js/CRUD_DetalleActComer.js" type="text/javascript" ></script>
<script src="js/CargarCombo.js" type="text/javascript" ></script>
<script src="js/CRUD_Distribucion.js" type="text/javascript" ></script>
<!-- Librerias Jquery -->
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<script src="js/CargaPlanes.js" type="text/javascript" ></script>
<%    
    //TipoUser, Rut y Nombre Ejecutivo PAra actualiza Actividad comercial.    
    HttpSession s = request.getSession();
    Connection _connMy = null;    
    CallableStatement sp_usu = null;   
    String tipoUser = "";
    String tipoNegocio = "";
    String rut = "";
    String nom = "";
    String id= "";
    String secuencia = "";
    String var = "";
    String tipoNeg = "";
    String fecha = "";
    String NomEje= "";
    String Estado = "";
    String rutEje = "";
    String rutCli = "";
    String nomCli = "";
    String caso = "";
    String tipServi = "";
    String servMovil = "";
    String cantMovil = "";
    String codCli = "";
    String tipCli = "";
    String corrCotiza = "0";
    String codEje = "";
    String crm = "";
    String comentario = "";
    String supervisor= "";
    String supervisorSP= "";
    String cantMovilSP ="";
    String negocio = "";
    String uf = "";
    try
    {
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
        if(s.getAttribute("nom")== null)
        {                                  
            response.sendRedirect("login.jsp");
        }
        nom  = (String)s.getAttribute("nom"); 
        if(request.getParameter("par") != null)
        {
            id = request.getParameter("par");
        }
        if(request.getParameter("secuencia") != null)
        {
            secuencia = request.getParameter("secuencia");
        }
        if(request.getParameter("correlativo") != null)
        {
            corrCotiza = request.getParameter("correlativo") ;
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
        if(s.getAttribute("tipoNegocio")!= null)
        {
             tipoNegocio = (String)s.getAttribute("tipoNegocio");
        }
        if(request.getParameter("cantidad")!= null)
        {
             cantMovil = request.getParameter("cantidad");             
        }
        if(!id.equals("1"))
        {
            var = "consulta";        
            sp_usu = _connMy.prepareCall("{call sp_actividad_comercial(?,?,'','',null,'','','','','','0','0','','','5','6','9','','','','','','','','0','0')}");
            sp_usu.setString(1,var);
            sp_usu.setLong(2,Integer.parseInt(corrCotiza));
            sp_usu.execute();
            final ResultSet rs = sp_usu.getResultSet();
            while(rs.next())
            {
                negocio=rs.getString("nro_negocio");
                tipoNeg = rs.getString("tipo_negocio");
                fecha = rs.getString("fecha");
                NomEje= rs.getString("nombre_eje");
                Estado = rs.getString("estado");
                rutEje = rs.getString("rut_eje");
                rutCli = rs.getString("rut_cli");
                nomCli = rs.getString("nombre_cli");
                caso = rs.getString("caso");
                tipServi = rs.getString("tipo_servicio");
                servMovil = rs.getString("servicios_moviles");
                cantMovilSP = rs.getString("cant_moviles");
                codCli = rs.getString("rut_cod_cli");
                tipCli = rs.getString("tipo_cliente");
                corrCotiza = rs.getString("corr_cotiza");
                codEje = rs.getString("rut_cod_eje");
                crm = rs.getString("crm");
                comentario = rs.getString("comentario");
                supervisorSP= rs.getString("supervisor");
                uf = rs.getString("uf");
            }            
        }        
    }catch(Exception e)
    {
        out.println("Error:" + e.getMessage());
    }
%>
    <script type="text/javascript">  
        $(document).ready(function (){   
            var fila = $("#tblDetalleComer").children("tbody").children("tr").length;   
            if("<%=corrCotiza%>" != 0)
            {
                $("#txt_actComercial_corrCotiza").val("<%=corrCotiza%>"); 
            }                                   
            $("#txt_actComercial_fecha").val("<%=fecha%>");              
            $("#txa_actComercial_comentario").val("<%=comentario%>");
            $("#txt_actComercial_rutcli").val("<%=rutCli%>");
            $("#txt_actComercial_nomCli").val("<%=nomCli%>");
            $("#txt_actComercial_caso").val("<%=caso%>");                    
            $("#slt_actComercial_tipoClte").val("<%=tipCli%>");
            $("#txt_actComercial_corrCotiza").val("<%=corrCotiza%>");
            $("#slt_actComercial_tipoServicio").val("<%=tipServi%>");        
            $("#txt_actComercial_cantMovil").val("<%=cantMovil%>");
            $("#slt_actComercial_status").val("<%=Estado%>");    
            $("#hid_estadoActual").val("<%=Estado%>");
            $("#txt_actComercial_nroNegocio").val("<%=negocio%>");  
            if("<%=tipoUser%>" == "Usuario" || "<%=tipoUser%>" == "Backoffice")
            {      
                $("#txt_actComercial_nomEje").val("<%=NomEje%>");
                $("#txt_actComercial_rv").val("<%=rut%>");
            }

            if("<%=tipoUser%>" == "Usuario" || "<%=tipoUser%>" == "Supervisor")
            {      
                $("#btn_distribucion").hide();
                $("#DetalleIngreso").hide();
                $("#DetalleElimina").hide();
            }

             if("<%=id%>"== 1)
            {       
                $("#txt_actComercial_nomEje").val("<%=nom%>");
                $("#slt_actComercial_TipoNegocio").val("<%=tipoNegocio%>");
                $("#btn_actComercial_avanzar").hide();

            }
            if("<%=crm%>" === "si")
            {
                $("#chkBox_actComercial_CRM").prop("checked","checked");
            }else
            {
                $("#chkBox_actComercial_CRM").prop("checked","");
            }
            if("<%=id%>"== 2)
            {     
                $("#btn_actComercial_avanzar").show();
                if("<%=cantMovil%>" == "")
                {
                    $("#txt_actComercial_cantMovil").val("<%=cantMovilSP%>");
                }
                $("#txt_actComercial_rv").val("<%=rutEje%>");
                $("#slt_actComercial_TipoNegocio").val("<%=tipoNeg%>");
                $("#txt_actComercial_supervisor").val("<%=supervisorSP%>");
                $("#slt_actComercial_ejecutivo").val("<%=NomEje%>");            
                $("#txt_actComercial_uf").val("<%=uf%>");
                
                //Valida si no es administrador, en ese caso, carga las opciones del workflow
                if("<%=tipoUser%>" != "Administrador"){
                    cargarEstadosSiguientes();
                }
            }
            if("<%=id%>"== 3)
            {
                if("<%=cantMovil%>" == "")
                {
                    $("#txt_actComercial_cantMovil").val("<%=cantMovilSP%>");
                }
                $("#txt_actComercial_rv").val("<%=rutEje%>");

                if($("#tipoUser").val() != "Usuario")
                {
                    $("#slt_actComercial_ejecutivo").val("<%=NomEje%>");
                }        
                else{
                   $("#txt_actComercial_nomEje").val("<%=NomEje%>");
                }            
                $("#txt_actComercial_supervisor").val("<%=supervisorSP%>");
                $("#txt_actComercial_nroNegocio").attr("readonly",true);
                $("#btn_actComercial_grabar").hide();
                $("#lanzador").hide();
    //            $("#btn_distribucion").show();
                $("#DetalleIngreso").hide();
                $("#DetalleElimina").show();
                $("#btn_actComercial_avanzar").hide();
                var filas = $('#tblDetalleComer').children('tbody').children('tr').length;
                for(var i=0; i <filas ; i++)
                {
                    $("#seleccion"+i).hide();
                }
            }

            cargaTipoPlan();
            if("<%=tipoUser%>"!="Usuario"){
              cargaTipoNegocioInit();
            }
        });

        function cargaTipoNegocioInit()
        {
            var ejecutivo = "";
            ejecutivo = $("#slt_actComercial_ejecutivo").val();
            if("<%=tipoUser%>" == "Backoffice"){
                ejecutivo = $("#txt_actComercial_nomEje").val(); 
            }
            var tipo = $("#tipoUser").val();
            var rut = $("#rutUsuario").val();
            $.ajax({
                url : 'ServletCargaRv', 
                data: "ejecutivo="+ejecutivo+"&rut="+rut+"&tipoUser="+tipo,
                type : 'POST',
                dataType : "html",
                success : function(data) {
                    var campos = [];
                    $("#slt_actComercial_TipoNegocio").removeAttr("disabled");
                    campos = data.split("|");
                    $("#txt_actComercial_rv").val(campos[0]);
                    $("#txt_actComercial_rv").attr("disabled","disabled"); 
                    $("#slt_actComercial_TipoNegocio").val(campos[1]);

                    if(campos[1] == "Captura")
                    {
                        $("#slt_actComercial_TipoNegocio").children().remove();
                        $("#slt_actComercial_TipoNegocio").append("<option value='Captura'>Captura</option>");
                    }
                    if(campos[1] == "Desarrollo Peque\u00f1a Empresa")
                    {
                        $("#slt_actComercial_TipoNegocio").removeAttr("disabled");
                        //Sacar las opciones
                        $("#slt_actComercial_TipoNegocio").children().remove();
                        //$("#slt_actComercial_TipoNegocio").append("<option value='Captura'>Captura</option>");
                        $("#slt_actComercial_TipoNegocio").append("<option selected value='Desarrollo Peque\u00f1a Empresa'>Desarrollo Peque\u00f1a Empresa</option>");                    
                    }
                    if(campos[1] == "Desarrollo Mediana Empresa")
                    {
                        $("#slt_actComercial_TipoNegocio").removeAttr("disabled");
                        //Sacar las opciones
                        $("#slt_actComercial_TipoNegocio").children().remove();
                        //$("#slt_actComercial_TipoNegocio").append("<option value='Captura'>Captura</option>");
                        $("#slt_actComercial_TipoNegocio").append("<option selected value='Desarrollo Mediana Empresa'>Desarrollo Mediana Empresa</option>");                    
                    }

                    $('#slt_actComercial_TipoNegocio').val('<%=tipoNeg%>');
                    $("#txt_actComercial_supervisor").val(campos[2]);
                    $("#txt_actComercial_supervisor").attr("disabled","disabled");


                }
            });
        }
        
        function cargarEstadosSiguientes()
        {
            var estadoActual = $.trim($("#hid_estadoActual").val());
            $.ajax({
                url: "ServletSPWorkFlow",
                type:"post",
                data:{
                    opcion_WorkFlow: "estadosSiguientes",
                    estadoActual: estadoActual
                },
                success: function(estadosSiguientes){
                    var opciones = "<option>"+estadoActual+"</option>";
                    opciones += estadosSiguientes;
                    $("#slt_actComercial_status").html(opciones);
                }
            });
        }
        
        function avanzarEstado(){
            var idActividad = $("#txt_actComercial_corrCotiza").val();
            var estadoNuevo = $.trim($("#slt_actComercial_status").val());
            var estadoActual = $.trim($("#hid_estadoActual").val());
            
            //Cambiar código del error!!!
            if(estadoActual == estadoNuevo){
                $("#slt_actComercial_status").focus();
                FuncionErrores(227);
                return false;
            }
            
            if(confirm("Este proceso sólo avanzará de estado. \n\nOtros datos no serán actualizados")){
                $.ajax({
                    url: "ServletAvanzarEstado",
                    type: "post",
                    data:{
                        nuevoEstado: estadoNuevo,
                        idActividad: idActividad
                    },
                    success: function (data){
                        location.href="SL_Seleccion_ActividadComercial.jsp";
                    }
                });
            }
        }
</script>
</head>
<body id="principal" onload="cargaServicio()">
<input type="hidden" value="<%=id%>" id="parametroActComercial" />
<input type="hidden" value="<%=servMovil%>" id="tipServicio" />
<input type="hidden" value="<%=tipoUser%>" id="tipoUser" />
<input type="hidden" value="<%=rut%>" id="rutUsuario" />
<input type="hidden" value="<%=tipServi%>" id="tipoServicioMovil" />
<div class="formularioIngresar">
    <table id="header">                           
        <tr>
            <td>
                <form action="" method="post">
                    <table >
                        <tr>
                            <td colspan =" 2" >DATOS EJECUTIVO<hr /></td>
                            <td colspan = "2">DATOS CLIENTES<hr /></td>
                            <td colspan="2">SERVICIOS<hr /></td>
                        </tr>
                        <tr>
                            <td>RV:</td>                            
                            <td >                                 
                                <input type="text" disabled= "disabled" id="txt_actComercial_rv" maxlength="11" name="txt_actComercial_rv" />                            
                                                                
                            </td>                           
                            <td>Rut:</td>
                            <td><input type="text" id="txt_actComercial_rutcli" maxlength="11" name="txt_actComercial_rutcli" /></td>
                            <td>Tipo:</td>
                            <td>
                                <select onchange="cargaServicio()" id="slt_actComercial_tipoServicio" name="slt_actComercial_tipoServicio">
                                    <option value="">--Seleccione--</option>
                                    <%
                                        String tabla = "Tipo Servicio";
                                        String descripcionServicio = "";
                                        CallableStatement sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                        sp_Carga.setString(1,tabla);                                        
                                        sp_Carga.execute();
                                        final ResultSet CargarMaeTabla = sp_Carga.getResultSet();                                                   
                                        while(CargarMaeTabla.next())
                                        {                  
                                            descripcionServicio = CargarMaeTabla.getString("descripcion");
                                    %>                                    
                                            <option value="<%=descripcionServicio%>"><%=descripcionServicio%></option>
                                    <%                                                       
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>	
                        <tr>
                            <td>Nombre:</td>
                            <td> 
                                <%
                                    if (tipoUser.equals("Usuario") || tipoUser.equals("Backoffice") )
                                    {
                                %>
                                        <input type="text" disabled= "disabled" id="txt_actComercial_nomEje" maxlength="50" name="txt_actComercial_nomEje" />                                                                        
                                <%
                                    }
                                    if(tipoUser.equals("Administrador"))
                                    {
                                %>
                                <select onchange="cargaTipoNegocioInit()"  id="slt_actComercial_ejecutivo" name="slt_actComercial_ejecutivo">
                                    <option value="">--Seleccione--</option>
                                <%  
                                    
                                        Statement stmtNomEje = null;
                                        ResultSet rsNomEje = null;
                                        String ejecutivos = "";
                                        stmtNomEje = _connMy.createStatement();                                    
                                        rsNomEje = stmtNomEje.executeQuery("SELECT nombre_user FROM sl_mae_usuarios where tipo='Usuario'");                                                                                         
                                        while(rsNomEje.next())
                                        {             
                                            ejecutivos= (String)rsNomEje.getString("nombre_user");                                    
                                    %>
                                            <option value="<%=ejecutivos%>"><%=ejecutivos%></option>
                                    <%                                                       
                                        }
                                    }
                                    if(tipoUser.equals("Supervisor"))
                                    {
                                        %>
                                        <select onchange="cargaRv()"  id="slt_actComercial_ejecutivo" name="slt_actComercial_ejecutivo">
                                            <option value="">--Seleccione--</option>
                                        <%  
                                        
                                        Statement stmtNomEje = null;
                                        ResultSet rsNomEje = null;
                                        String ejecutivos = "";
                                        stmtNomEje = _connMy.createStatement();                                    
                                        rsNomEje = stmtNomEje.executeQuery("SELECT nombre_user FROM sl_mae_usuarios where supervisor='"+rut+"'");                                                                                         
                                        while(rsNomEje.next())
                                        {             
                                            ejecutivos= (String)rsNomEje.getString("nombre_user");                                    
                                    %>
                                            <option value="<%=ejecutivos%>"><%=ejecutivos%></option>
                                    <%                                                       
                                        }
                                    }
                                %>                                        
                                </select>                              
                            </td>
                            <td>Nombre:</td>
                            <td id="Area"> 
                                <textarea name="txt_actComercial_nomCli"  maxlength="80" id="txt_actComercial_nomCli" rows="4" cols="28"></textarea>
                            </td>
                            <td>Servicios Móviles:</td>
                            <td>
                                <select  name="slt_actComercial_serviMovil" id="slt_actComercial_serviMovil">
                                    <option value="">--Seleccione--</option>                                    
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha Creación:</td>
                            <td>
                                <input type = "text" name = "txt_actComercial_fecha" readonly id= "txt_actComercial_fecha" size="12" />
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador"/>
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                        inputField     :    "txt_actComercial_fecha",     // id del campo de texto 
                                        ifFormat     :     "%Y-%m-%d",     // formato de la fecha que se escriba en el campo de texto 
                                        button     :    "lanzador"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>	
                            </td>
                            <td>Caso:</td>
                            <td><input type="text" name="txt_actComercial_caso" maxlength="11" id="txt_actComercial_caso" /></td>
                            <td>Cantidad móviles:</td>
                            <td>
                                <input type="text" name="txt_actComercial_cantMovil" maxlength="5" id="txt_actComercial_cantMovil"/>                                                                 
                                <%
                                    if(!tipoUser.equals("Usuario"))
                                    {
                                %>
                                        <input class="distribucion" type="button" id="btn_distribucion" name="btn_distribucion" value="Abrir distribución" onclick="AbrirDistribucion()"/>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <tr>
                            <td>Supervisor:</td>
                            <td>                                
                                
                                <%
                                    String nomUser= "";
                                    if(tipoUser!=("Administrador"))
                                    {
                                        Statement stmt = null;
                                        ResultSet rsSupervisor = null;                                         
                                        stmt = _connMy.createStatement();                                    
                                        rsSupervisor = stmt.executeQuery("SELECT nombre_user FROM sl_mae_usuarios where rut = '"+supervisor+"'");                                                                                         
                                        while(rsSupervisor.next())
                                        {             
                                            nomUser = (String)rsSupervisor.getString("nombre_user");                                                                                        
                                        }
                                    }else
                                    {
                                        nomUser= "";
                                    }
                                %>
                                <%
                                    if(tipoUser.equals("Usuario"))
                                    {
                                        %>
                                   <input disabled="disabled" value="<%=nomUser%>" type="text" name="txt_actComercial_supervisor"  id="txt_actComercial_supervisor"/>  
                                    <%
                                    }                                    
                                        %>
                                        <% if(!tipoUser.equals("Usuario"))
                                        {
                                        %>
                                <input  disabled value="<%=nomUser%>" type="text" name="txt_actComercial_supervisor"  id="txt_actComercial_supervisor"/>  
                                <%
                                    }
                                %>
                            </td>
                            <td>Nro. Negocio:</td>
                            <td><input type="text" name="txt_actComercial_nroNegocio" maxlength="11" id="txt_actComercial_nroNegocio"/></td>
                            <td>CRM</td>
                            <td><input type="checkbox" name="chkBox_actComercial_CRM" id="chkBox_actComercial_CRM"/></td>
                        </tr>
                        <tr>
                            <td colspan="2">Comentario:</td>	 
                            <td>Tipo Cliente:</td>
                            <td>
                                <select name="slt_actComercial_tipoClte" id="slt_actComercial_tipoClte">
                                    <option value="">--Seleccione--</option>
                                    <option value="Nuevo">Nuevo</option>
                                    <option value="Antiguo">Antiguo</option>
                                </select>
                            </td>
                            <td>Estado:</td>
                            <td>
                                <input type="hidden" id="hid_estadoActual"/>
                                <select  name="slt_actComercial_status" id="slt_actComercial_status">
                                    <option value="">--Seleccione--</option>
                                    <%
                                        tabla = "Estado_ActCom";
                                        if(tipoUser.equals("Usuario") || tipoUser.equals("Supervisor"))
                                        {
                                            sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,?,'')}");
                                            sp_Carga.setString(1,tabla);
                                            sp_Carga.setString(2,"Usuario");
                                        }
                                        if(tipoUser.equals("Backoffice"))
                                        {
                                            sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,?,'')}");
                                            sp_Carga.setString(1,tabla);
                                            sp_Carga.setString(2,"Backoffice");
                                        }
                                        if(tipoUser.equals("Administrador"))
                                        {
                                            sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                            sp_Carga.setString(1,tabla);                                            ;
                                        }
                                        sp_Carga.execute();
                                        
                                        final ResultSet CargarEstado = sp_Carga.getResultSet();                                                   
                                        boolean add=true;
                                        
                                        while(CargarEstado.next())
                                        {
                                           if(Estado.equals(CargarEstado.getString("descripcion"))){
                                               add=false;
                                           }
                                    %>
                                            <option value="<%=CargarEstado.getString("descripcion")%>"><%=CargarEstado.getString("descripcion")%></option>
                                    <%                                                       
                                        }if(add && !id.equals("1")){
                                            %>
                                            <option value="<%=Estado%>"><%=Estado%></option>
                                            <%
                                        }
                                        
                                    %>
                                </select>
                                <%
                                    /*
                                    if(!id.equals("1")){
                                        %>
                                            <!--<input class="distribucion" type="button" id="btn_distribucion" name="btn_distribucion" value="Avanzar Estado" onclick="AbrirDistribucion()"/>-->
                                        <%
                                    /*
                                    }
                                    */
                                %>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="2"colspan="2"> <textarea name="txa_actComercial_comentario" id="txa_actComercial_comentario" rows="2" cols="28"></textarea></td>
                        </tr>
                        <tr>
                            <td>UF</td>
                            <td><input type="text" name="txt_actComercial_uf" maxlength="11" id="txt_actComercial_uf"/></td>
                            
                            <td>Tipo Negocio:</td>
                            <td>
                                <select name="slt_actComercial_TipoNegocio" id="slt_actComercial_TipoNegocio">
                                            <%--<option value="">--Seleccione--</option>--%>
                                            <%--se elimina linea de option value = ""--%>
                                            <%
                                                if(tipoUser.equals("Administrador") || tipoUser.equals("Backoffice") )
                                                {
                                                    %>
                                                    <option value="" selected>--Seleccione--</option>
                                                    <%
                                                    try
                                                    {
                                                        tabla = "Tipo Negocio";
                                                        sp_Carga = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                        sp_Carga.setString(1,tabla);
                                                        sp_Carga.execute();
                                                        final ResultSet CargaTipoNegocio = sp_Carga.getResultSet();                                                   
                                                        while(CargaTipoNegocio.next())
                                                        {
                                                            String descripcion = CargaTipoNegocio.getString("descripcion");
                                                            //if(tipoNegocio.equals(descripcion)||tipoNeg.equals(descripcion) || descripcion.equals("Captura")||tipoUser.equals("Administrador")||tipoUser.equals("Backoffice"))
                                                            %>
                                                            <option value="<%=descripcion%>"><%=descripcion%></option>
                                                            
                                                            <%
                                                        }
                                                    }catch(Exception e)
                                                    {
                                                        out.print("Error: "+e.getMessage());
                                                    }                                    
                                                }
                                                if(tipoUser.equals("Supervisor") || tipoUser.equals("Usuario"))
                                                {
                                                    %>
                                                    <option value="<%=tipoNegocio%>"><%=tipoNegocio%></option>
                                                    <%
                                                }
                                            %>
                                </select>
                            </td>
                           <td><input type="hidden" name="txt_actComercial_corrCotiza" maxlength="11" id="txt_actComercial_corrCotiza" value="0"/></td>                           
                           
                        </tr>
                    </table>
                </form>
            </td>
            <td rowspan="6" >
                <div id="alineacionEstados" >
                    <div class="etiqueta" >
                        <center><label><b>Historial de Estados</b></label></center>
                    </div>
                    <div class="grillaConf">
                        <table>
                            <thead>
                                <tr>
                                    <th>Estado Anterior</th>
                                    <th>Estado Siguiente</th>
                                    <th>Fecha</th>                                    
                                    <th>Rut Usuario</th>                                    
                                    <th>Nombre Usuario</th>
                                </tr>
                            </thead>				
                            <tbody>
                                    <%
                                        int cont = 0;                                        
                                         var = "consulta";                                        
                                         sp_usu = _connMy.prepareCall("{call sp_historial(?,?,'','')}");
                                        sp_usu.setString(1,var);                                        
                                        sp_usu.setLong(2,Long.parseLong(corrCotiza));                                          
                                        sp_usu.execute();
                                        final ResultSet rsHistorial = sp_usu.getResultSet();
                                        String claseGrilla = "";
                                        while(rsHistorial.next())
                                        {
                                            if(cont % 2 == 0)
                                            {                                                
                                                claseGrilla = "alt";
                                            }
                                            out.println("<tr id='filaTablaHistorial"+cont+"' class='"+claseGrilla+"'>");
                                    %>                                                                                                                                                                    
                                        <td id ="historial_estAnterior<%=cont%>"><%=rsHistorial.getString("estado_anterior")%></td>
                                        <td id ="historial_estSiguiente<%=cont%>"><%=rsHistorial.getString("estado_siguiente")%></td>
                                        <td id ="historial_fecha<%=cont%>"><%=rsHistorial.getString("fecha")%></td>
                                        <td id ="historial_rutUser<%=cont%>"><%=rsHistorial.getString("rutUser")%></td>
                                        <td id ="historial_nomUser<%=cont%>"><%=rsHistorial.getString("nomUser")%></td>                                                                                   
                                     <%
                                            out.print("</tr>");
                                            claseGrilla = "";
                                            cont ++;
                                        }
                                     %>                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>      
        <tr>
            <td colspan="9">
                <table class="detalle">
                    <tr>
                        <td colspan = "7" id='margen'><center>DETALLE DE SERVICIO</center><hr /></td>
                    </tr>
                    <tr>
                        <td>Número Movil:</td>
                        <td id="EspacioDetalle"><input type="text" id="txt_detalleComercial_nroMovil" maxlength="11" name="txt_detalleComercial_nroMovil" /></td>
                        <td>Tipo Plan Antiguo:</td>
                        <td id="EspacioDetalle">
                            <select onchange="loadPlanAntiguo()" id="slt_detalleComercial_tipoPlanAnt" name="slt_detalleComercial_tipoPlanAnt">
                                <option value="">--Seleccione--</option>                                
                            </select>
                        </td>
                        <td>Plan Antiguo:</td>
                        <td id="EspacioDetalle">
                            <select onchange="loadCargoFijoAntiguo()" id="slt_detalleComercial_planAnt" name="slt_detalleComercial_planAnt">
                                <option value="">--Seleccione--</option>                                
                            </select>
                        </td>
                        <td>Cargo Fijo:</td>
                        <td id="EspacioDetalle"><input type="text" maxlength="11" id="txt_detalleComercial_cargoFijoAnt" name="txt_detalleComercial_cargoFijoAnt" /></td> 
                        <td>PORT-PP-HAB:</td>
                        <td>
                            <select id="slt_detalleComercial_portPPHAB" name="slt_detalleComercial_portPPHAB">
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
                        <td>Tipo Plan Nuevo:</td>
                        <td>
                            <select onchange="loadPlanNuevo()" id="slt_detalleComercial_tipoPlanNue" name="slt_detalleComercial_tipoPlanNue">
                                <option value="">--Seleccione--</option>                                                             
                            </select>
                        </td>
                        <td>Plan Nuevo:</td>
                        <td>
                            <select onchange="loadCargoFijoNuevo()" id="slt_detalleComercial_PlanNue" name="slt_detalleComercial_PlanNue">
                                <option value="">--Seleccione--</option>                                
                            </select>
                        </td>
                        <td>Cargo Fijo:</td>
                        <td><input type="text" maxlength="11" id="txt_detalleComercial_cargoFijoNue" name="txt_detalleComercial_cargoFijoNue" /></td> 
                        <td >ARPU:</td>
                        <td><input type="text"  maxlength="11" name="txt_detalleComercial_arpu" id="txt_detalleComercial_arpu" /></td>
                        <input type="hidden" value="<%=secuencia%>" id="secuencia" />
                        <input type="hidden" id="hidtemp"/>
                        <td>
<!--                            <input type="button" class="botonera" style="display: none" value="Cancelar" onclick="CancelaDetalle()" name="btn_detalleComercial_cancela" id="btn_detalleComercial_cancela" />-->
                            <input type="button" class="botonera" style="display: none" value="Limpiar Tabla" onclick="LimpiaDetalle()" name="btn_detalleComercial_limpiaTabla" id="btn_detalleComercial_limpiaTabla" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" rowspan="5" id='margen'>
                            <div class="etiqueta">
                                <center><label><b>Detalle</b></label></center>
                            </div>
                            <div  id = "tablaDetalle" class="grillaConf">
                                <table id="tblDetalleComer">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Nro. Móvil</th>
                                            <th>PORT-PP-HAB</th>
                                            <th>Tipo Plan Antiguo</th>
                                            <th>Plan Antiguo</th>
                                            <th>Cargo Fijo</th>
                                            <th>Tipo Plan Nuevo</th>
                                            <th>Plan Nuevo</th>
                                            <th>Cargo Fijo</th>
                                            <th>ARPU</th>
                                        </tr>
                                    </thead>				
                                    <tbody>
                                    <%
                                         cont = 0;
                                         int ultimo =0;
                                         
                                         var = "consulta";                                        
                                         sp_usu = _connMy.prepareCall("{call sp_detalleComer_Tmp(?,?,?,?,?,?,?,?,?,?,?,?)}");
                                        sp_usu.setString(1,var);
                                        sp_usu.setLong(2,0);
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
                                        final ResultSet rsDetalle = sp_usu.getResultSet();
                                        claseGrilla = "";
                                        while(rsDetalle.next())
                                        {
                                            if(cont % 2 == 0)
                                            {                                                
                                                claseGrilla = "alt";
                                            }
                                            out.println("<tr id='filaTablaDetalle"+cont+"' class='"+claseGrilla+"'>");
                                    %>                                        
                                        <td>
                                            <a id="seleccion<%=cont%>" href="javascript: onclick=ModificaDetalleComercial(<%=cont%>)"> >></a>
                                            <input type="hidden" value="0" id="habilitaDetCom" name="habilitaDetCom" />
                                        </td>                                                                                       
                                        <td id ="actComerDet_nroMovil<%=cont%>"><%=rsDetalle.getString("nro_movil")%></td>
                                        <td id ="actComerDet_portPPHab<%=cont%>"><%=rsDetalle.getString("port_pp_hab")%></td>
                                        <td id ="actComerDet_tipoPlanAnt<%=cont%>"><%=rsDetalle.getString("tipo_plant_ant")%></td>
                                        <td id ="actComerDet_planAnt<%=cont%>"><%=rsDetalle.getString("plan_antiguo")%></td>
                                        <td id ="actComerDet_cargoFijoAnt<%=cont%>"><%=rsDetalle.getString("cargo_fijo_ant")%></td>
                                        <td id ="actComerDet_tipoPlanNue<%=cont%>"><%=rsDetalle.getString("tipo_plan_nue")%></td>
                                        <td id ="actComerDet_planNue<%=cont%>"><%=rsDetalle.getString("plan_nuevo")%></td>                                            
                                        <td id ="actComerDet_cargoFijoNue<%=cont%>"><%=rsDetalle.getString("cargo_fijo_nue")%></td>
                                        <td id ="actComerDet_arpu<%=cont%>"><%=rsDetalle.getString("arpu")%></td>                                               
                                     <%
                                            out.print("</tr>");
                                            claseGrilla = "";
                                            cont ++;
                                            ultimo = Integer.parseInt(rsDetalle.getString("nro_movil"));                                                                                     
                                            
                                        }
                                     %>
                                    </tbody>
                                </table>
                                    
                                    <input type="hidden" id="ultimo" value="<%=ultimo+1%>">
                                    <input type="hidden" id="cantidad" value="<%=cont%>">
                            </div>                                               
                        </td>
                        <td id="bottom" rowspan="1">
                            <a  href="#">
                            <img onclick="DetalleActividadComercial('ingreso')" id="DetalleIngreso" class="ico" border="0" src="images/logotipos/agregar.png" 
                            height="25px" width="25px"/>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="DetalleModifica" style="display: none" onclick="DetalleActividadComercial('modifica')" src="images/logotipos/modificar.png" border="0" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="DetalleElimina" style="display: none" border="0" onclick="DetalleComercial('elimina')" src="images/logotipos/eliminar.png" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>            
<input class ="botonera" type="submit" id="btn_actComercial_grabar" name="btn_actComercial_grabar" value="Grabar" onClick="FuncionActividadComercial(<%=id%>,<%=secuencia%>)"  />
<input class ="botonera" type="submit" id="btn_actComercial_avanzar" name="btn_actComercial_grabar" value="Avanzar Estado" onClick="avanzarEstado()"  />
<input class = "botonera" type="submit" name="btnCancela" value="Cancelar" onClick="DeleteTmp(<%=secuencia%>)" />
</body>
</html>