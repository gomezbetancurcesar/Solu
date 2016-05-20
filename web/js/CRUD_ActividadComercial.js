function ActividadComercial(id,secuencia){
    //Capturamos las actividades que NO se deben validar la cantidad de móviles
    var estadosExcepciones = [];
    var cargaExcepciones = false;
    $.ajax({
        url: "ServletExcepActCom",
        async: false,
        success: function (actividadExcepciones){
            estadosExcepciones = actividadExcepciones.split("___");
            cargaExcepciones = true;
        }
    });
    
    var mod = "";
    if (id === 1 || id === 4)
    {	
        mod = "ingreso";
    }
    if(id === 2)
    {
        mod= "modifica";
    }
    var fila = $("#tblDetalleComer").children("tbody").children("tr").length;
    var rv = "";
    
    rv = $("#txt_actComercial_rv").val();
    var rutCli = $("#txt_actComercial_rutcli").val();
    var tipoServicio = $("#slt_actComercial_tipoServicio").val();
    var nomEje = "";
    var nomCli = $("#txt_actComercial_nomCli").val();
    var fecha = $("#txt_actComercial_fecha").val();
    var caso = $("#txt_actComercial_caso").val();
    var cantMovil = $("#txt_actComercial_cantMovil").val();
    var ServicioMovil = $("#slt_actComercial_serviMovil").val();
    var nroNegocio = $("#txt_actComercial_nroNegocio").val();
    var crm = "";
    var tipoCli = $("#slt_actComercial_tipoClte").val();
    var estado = $("#slt_actComercial_status").val();
    var comentario = $("#txa_actComercial_comentario").val();
    var corrCotiza = $("#txt_actComercial_corrCotiza").val();
    var tipoNegocio = "";
    var supervisor = $("#txt_actComercial_supervisor").val();
    var uf = $("#txt_actComercial_uf").val();
    
    if($("#tipoUser").val() == "Usuario" || $("#tipoUser").val() == "Backoffice")
    {
        nomEje = $("#txt_actComercial_nomEje").val();
    }        
    else{
        nomEje = $("#slt_actComercial_ejecutivo").val();
        
    }
    tipoNegocio = $("#slt_actComercial_TipoNegocio").val();
    if($("#chkBox_actComercial_CRM").is(':checked'))
    {
        crm= "si";
    }else 
    {
        crm = "no";
    }
    
    if(cargaExcepciones){
        if(cantMovil != fila && $.inArray(estado, estadosExcepciones) < 0)
        {
            FuncionErrores(226);
            $("#txt_actComercial_cantMovil").focus();
            return false;
        }

        $.ajax({
            url : 'ServletSPActividadComercial', 
            data : "opcion_ActividadComercial="+mod+"&txt_actComercial_rv="+rv+"&txt_actComercial_rutcli="+rutCli+"&slt_actComercial_tipoServicio="+tipoServicio+
                    "&slt_actComercial_ejecutivo="+nomEje+"&txt_actComercial_nomCli="+nomCli+"&txt_actComercial_fecha="+fecha+"&txt_actComercial_caso="+caso+
                    "&txt_actComercial_cantMovil="+cantMovil+"&slt_actComercial_serviMovil="+ServicioMovil+"&txt_actComercial_nroNegocio="+nroNegocio+"&chkBox_actComercial_CRM="+crm+
                    "&slt_actComercial_tipoClte="+tipoCli+"&slt_actComercial_status="+estado+"&txa_actComercial_comentario="+comentario+"&txt_actComercial_corrCotiza="+corrCotiza+
                    "&slt_actComercial_TipoNegocio="+tipoNegocio+"&seq="+secuencia+"&slt_actComercial_supervisor="+supervisor+"&txt_actComercial_uf="+uf,
            type : 'POST',
            dataType : "html",
            success : function(data){
                    if(data != "")
                    {
                        FuncionErrores(222);      
                        if(fila >= 1)
                        {
                           $("#btn_detalleComercial_limpiaTabla").show();
                        }                        
                        $("#txt_actComercial_corrCotiza").focus();
                        return false;
                    }
                    else
                    {
                        location.href="SL_Seleccion_ActividadComercial.jsp";
                    }
            }        
        });
    }
}

function ModificaActComercial(id)
{
    desmarca_registro_actividadComercial();
    if($("#habilitaActCom").val() == 0)
    {
        $("#filaTablaActComercial"+id).css("background-color","#58FAF4").removeClass("alt");        
        $("#habilitaActCom").val("1");
        $("#filaTablaActComercial"+id).addClass("seleccionado");
        var neg =  $("#ActCom_corrCotiza"+id).text();        
        var caso = $("#ActCom_Caso"+id).text();
        if($("#ActCom_estadoCierre"+id).text() == "DE")
        {
            $("#btn_actComercial_Modifica").hide();
        }
        $("#corrCotiza").val(neg);
        $("#caso").val(caso);
    }
}
function desmarca_registro_actividadComercial()
{
    $("#corrCotiza").val("");
    var td = $('#tblActComercial').children('tbody').children('tr').length;           
    for(var i = 0; i<=td;i++)
    {                
        if(i % 2 === 0)
        {
            $("#filaTablaActComercial"+i).addClass("alt");
        }
        if(i % 2 != 0)
        {                    
            $("#filaTablaActComercial"+i).css("background-color","white");
        }
    }
    $(".seleccionado").removeClass("seleccionado");
    $("#btn_actComercial_Modifica").show();
    $("#habilitaActCom").val("0");
}

function  DeleteTmp(secuencia)
{      
    $.ajax({
        url : 'ServletCancelaTmp', 
        data: "secu="+secuencia,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            location.href="SL_Seleccion_ActividadComercial.jsp";
        }
    });
}
function filtroActComercial()
{
    var filTipNeg = "";
    var filEjecutivo = "";
    var filEstado = "";
    var filFechaInicial = "";
    var filFechaFinal = "";
    var filSupervisor="";
    filTipNeg= $("#slt_filtroComercial_tipoNegocio").val();
    filEjecutivo= $("#slt_filtroComercial_ejecutivo").val();
    filEstado = $("#slt_filtroComercial_estado").val();  
    filFechaInicial = $("#txt_filtroComercial_ingreso").val();  
    filFechaFinal = $("#txt_filtroComercial_final").val();
    filSupervisor=$("#slt_filtroComercial_supervisor").val();
    if(filTipNeg == "" && filEjecutivo == "" && filEstado == "" && filFechaInicial == "" && filFechaFinal  == "" && filSupervisor=="")
    {
        FuncionErrores(228);
        return false;
    }
    if( filFechaFinal  != "" && filFechaInicial == "" )
    {
        FuncionErrores(227);
        return false        
    }
    
     if(filFechaFinal < filFechaInicial && filTipNeg == "" && filEjecutivo == "" && filEstado == "" ){
         FuncionErrores(237);
     return false;
 }
//    if(filFechaInicial != "" && filFechaFinal ==""){
//        FuncionErrores(243);
//        return false
//    }
    $.ajax({
        url : 'ServletFiltroComercial', 
        data: "tipoNegocio="+filTipNeg+"&ejecutivo="+filEjecutivo+"&estado="+filEstado+
                "&fechaInicial="+filFechaInicial+"&fechaFinal="+filFechaFinal+"&supervisor="+filSupervisor,
        type : 'POST',
        dataType : "html",
        success : function(data) {     
            
            $('#tblActComercial').dataTable().fnDestroy(); 
            $("#tblActComercial").find("tbody").html(data);  
            $('#tblActComercial').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
                "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
                bFilter: false, bInfo: false,
                "bLengthChange": false,
               "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7,8,9,10,11,12] }]
            });
        }
    });
}