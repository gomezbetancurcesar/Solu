function DetalleComercial(id)
{    
    var nroMovil = "";
    var uf= "";
    var tipoPlanAnt = "";
    var tipoPlanNue = "";
    var planAntiguo = "";
    var planNuevo ="";
    var cargoFijoAnt = "";
    var cargoFijoNue ="";
    var port_pp_hab = "";
    var arpu = "";
    var nroNegocio = "";
    var secuencia ="";
    var parametro = "";
    nroMovil = $("#txt_detalleComercial_nroMovil").val();
    uf = $("#txt_detalleComercial_uf").val();
    tipoPlanAnt =  $("#slt_detalleComercial_tipoPlanAnt").val();
    tipoPlanNue = $("#slt_detalleComercial_tipoPlanNue").val();
    planAntiguo = $("#slt_detalleComercial_planAnt").val();
    planNuevo = $("#slt_detalleComercial_PlanNue").val();
    cargoFijoAnt = $("#txt_detalleComercial_cargoFijoAnt").val();
    cargoFijoNue = $("#txt_detalleComercial_cargoFijoNue").val();
    port_pp_hab = $("#slt_detalleComercial_portPPHAB").val();
    arpu =  $("#txt_detalleComercial_arpu").val();    
    nroNegocio = $("#txt_actComercial_nroNegocio").val();
    secuencia = $("#secuencia").val();        
    parametro = $("#parametroActComercial").val();
    $.ajax({
        url : 'ServletSPDetalleActComer', 
        data : "opcion_Detalle_ActividadComercial="+id+"&txt_detalleComercial_nroMovil="+nroMovil+"&txt_detalleComercial_uf="+uf+"&slt_detalleComercial_tipoPlanAnt="+tipoPlanAnt+
                "&slt_detalleComercial_tipoPlanNue="+tipoPlanNue+"&slt_detalleComercial_planAnt="+planAntiguo+
                "&slt_detalleComercial_PlanNue="+planNuevo+"&txt_detalleComercial_cargoFijoAnt="+cargoFijoAnt+
                "&txt_detalleComercial_cargoFijoNue="+cargoFijoNue+"&slt_detalleComercial_portPPHAB="+port_pp_hab+
                "&txt_detalleComercial_arpu="+arpu+"&txt_actComercial_nroNegocio="+nroNegocio+"&secuencia="+secuencia,
        type : 'POST',
        dataType : "html",
        success : function(data) {     
            $("#tablaDetalle").find("tbody").html(data);  
            var fila = $('#tblDetalleComer').children('tbody').children('tr').length;
            $("#slt_detalleComercial_planAnt").find("option").remove();            
            $("#slt_detalleComercial_planAnt").append('<option value="" selected>--Seleccione--</option>');
            $("#slt_detalleComercial_PlanNue").find("option").remove();
            $("#slt_detalleComercial_PlanNue").append('<option value="" selected>--Seleccione--</option>');
            $("#txt_detalleComercial_nroMovil").val("");
            $("#slt_detalleComercial_tipoPlanAnt").val("");
            $("#slt_detalleComercial_planAnt").val("");
            $("#txt_detalleComercial_cargoFijoAnt").val("");
            $("#slt_detalleComercial_portPPHAB").val("");
            $("#txt_detalleComercial_uf").val("");
            $("#slt_detalleComercial_tipoPlanNue").val("");
            $("#slt_detalleComercial_PlanNue").val("");
            $("#txt_detalleComercial_cargoFijoNue").val("");
            $("#txt_detalleComercial_arpu").val("");            
            $("#DetalleIngreso").show();
            $("#txt_actComercial_nroNegocio").attr("readonly",true);
            $("#txt_detalleComercial_nroMovil").attr("readonly",false);
            $("#DetalleModifica").hide();
            $("#DetalleElimina").hide();
            $("#btn_detalleComercial_cancela").hide();
            $("#habilitaDetCom").val("0");
            if(fila == 0 && id == 'elimina' && parametro == 1 || parametro == 4)
            {
                $("#txt_actComercial_nroNegocio").attr("readonly",false);
            }
        }
    });

}
function ModificaDetalleComercial(id)
{
    CancelaDetalle();
    if($("#habilitaDetCom").val() == 0)
    {
        var planAnt = "";
        var planNue = "";
        $("#filaTablaDetalle"+id).css("background-color","#58FAF4").removeClass("alt");
        $("#txt_detalleComercial_nroMovil").val($("#actComerDet_nroMovil"+id).text());
        $("#slt_detalleComercial_tipoPlanAnt").val($("#actComerDet_tipoPlanAnt"+id).text());        
        $("#txt_detalleComercial_cargoFijoAnt").val($("#actComerDet_cargoFijoAnt"+id).text());
        $("#slt_detalleComercial_portPPHAB").val($("#actComerDet_portPPHab"+id).text());
        $("#txt_detalleComercial_uf").val($("#actComerDet_uf"+id).text());
        $("#slt_detalleComercial_tipoPlanNue").val($("#actComerDet_tipoPlanNue"+id).text());        
        $("#txt_detalleComercial_cargoFijoNue").val($("#actComerDet_cargoFijoNue"+id).text());
        $("#txt_detalleComercial_arpu").val($("#actComerDet_arpu"+id).text());
        $("#txt_detalleComercial_nroMovil").attr("readonly",true);
        $("#DetalleModifica").show();
        $("#DetalleElimina").show();        
        $("#DetalleIngreso").hide();
        $("#habilitaDetCom").val("1");        
        planAnt = $("#actComerDet_planAnt"+id).text();
        planNue = $("#actComerDet_planNue"+id).text();        
        $("#hidtemp").val(id);
        cargaPlanAntiguo(planAnt);
        cargaPlanNuevo(planNue);
    }
}
function CancelaDetalle()
{
    var td = $('#tblDetalleComer').children('tbody').children('tr').length;           
    for(var i = 0; i<=td;i++){                
        if(i % 2 === 0){
            $("#filaTablaDetalle"+i).addClass("alt");
        }else {                    
            $("#filaTablaDetalle"+i).css("background-color","white");
        }
    }
    $("#txt_detalleComercial_nroMovil").attr("readonly",false);
    $("#txt_detalleComercial_nroMovil").val("");
    $("#slt_detalleComercial_tipoPlanAnt").val("");
    $("#slt_detalleComercial_planAnt").val("");
    $("#txt_detalleComercial_cargoFijoAnt").val("");
    $("#slt_detalleComercial_portPPHAB").val("");
    $("#txt_detalleComercial_uf").val("");
    $("#slt_detalleComercial_tipoPlanNue").val("");
    $("#slt_detalleComercial_PlanNue").val("");
    $("#txt_detalleComercial_cargoFijoNue").val("");
    $("#txt_detalleComercial_arpu").val("");    
    $("#DetalleIngreso").show();
    $("#DetalleModifica").hide();
    $("#DetalleElimina").hide();    
    $("#habilitaDetCom").val("0");    
    cargaPlanAntiguo();
    cargaPlanNuevo();

}
function LimpiaDetalle()
{    
    $("#tblDetalleComer").children("tbody").remove();
    $("#txt_actComercial_nroNegocio").attr("readonly",false);
    $("#btn_detalleComercial_limpiaTabla").hide();
}
function llamarSecuencia(id){
    $.ajax({
        url : 'ServletSecuencia', 
        type : 'POST',
        dataType : "html",
        success : function(data) {
            id = data
                      
//                location.href="SL_Actualiza_ActividadComercial.jsp";
        }
    });
}
