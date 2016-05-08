

function FuncionActividadComercial(id,secuencia){
    var validarRut = new RegExp("[^0-9kK-]"); 
    var validarNum = new RegExp("[^0-9]");    
    var rv = $("#txt_actComercial_rv").val();  
    var rutCli = $("#txt_actComercial_rutcli").val();
    var posicion = rv.indexOf('-'); 
    var tmp = VerificaRut(rv);       
    var posicion1 = rutCli.indexOf('-'); 
    var tmp1 = VerificaRut(rutCli);
    var validaCorrCotiza = false;
    var errorCorrCotiza = false;
    var validaNroNegocio = false;
    var errorNroNegocio = false;
    
    if(id == '1'){
        //START VALIDA corrCotizacion
        $.ajax({
            url: 'ServletNroNegocio',
            async: false,
            data:{
                "campo": "corr_cotiza",
                "valor": $("#txt_actComercial_corrCotiza").val()
            },
            type : 'POST',
            success : function(count){
            },
            error: function(error){
                alert(error.responseText);
            }
        }).done(function(count){
            validaCorrCotiza = true;
            var cantidad = parseInt(count);
            if($.isNumeric(cantidad)){
                if(cantidad != 0){
                    errorCorrCotiza = true;
                }
            }
        });
        //END VALIDA corrCotizacion
        
        //START  validacion nroNegocio
        $.ajax({
            url: 'ServletNroNegocio',
            async: false,
            data:{
                "campo": "nro_negocio",
                "valor": $("#txt_actComercial_nroNegocio").val()
            },
            type : 'POST',
            success : function(count){
            },
            error: function(error){
                alert(error.responseText);
            }
        }).done(function(count){
            validaNroNegocio = true;
            var cantidad = parseInt(count);
            if($.isNumeric(cantidad)){
                if(cantidad != 0){
                    errorNroNegocio = true;
                }
            }
        });
        //END validacion nroNegocio
    }else{
        validaCorrCotiza = true;
        validaNroNegocio = true;
    }

    if(rv == ""){
        FuncionErrores(113);    
        $("#txt_actComercial_rv").focus();
        return false;
    }
    if (validarRut.test(rv)) {
        FuncionErrores(114);
        $("#txt_actComercial_rv").focus();
        return false;
    }
    if(posicion == -1)
    {
        FuncionErrores(115);
        $("#txt_actComercial_rv").focus();
        return false;
    }
    if(tmp == false)
    {
        FuncionErrores(116);
        $("#txt_actComercial_rv").focus();
        return false;
    }
//    if($("#txt_actComercial_nomEje").val() == "")
//    {
//        FuncionErrores(200);
//        $("#txt_actComercial_nomEje").focus();
//    return false;
//    }	
    if($("#txt_actComercial_fecha").val() == "")
    {
            FuncionErrores(105);
            $("#txt_actComercial_fecha").focus();
    return false;
    }
    if(rutCli == ""){
        FuncionErrores(113);   
        $("#txt_actComercial_rutcli").focus();
        return false;
    }
    if (validarRut.test(rutCli)) {
        FuncionErrores(114);   
        $("#txt_actComercial_rutcli").focus();
        return false;
    }
    if(posicion1 == -1)
    {
        FuncionErrores(115);   
        $("#txt_actComercial_rutcli").focus();
        return false;
    }
    if(tmp1 == false)
    {
        FuncionErrores(116);   
        $("#txt_actComercial_rutcli").focus();
        return false;
    }
    if($("#txt_actComercial_nomCli").val() == "")
    {
        FuncionErrores(201); 
        $("#txt_actComercial_nomCli").focus();
        return false;
    }
//    if($("#txt_actComercial_supervisor").val() == "")
//    {
//        FuncionErrores(240); 
//        $("#txt_actComercial_supervisor").focus();
//        return false;
//    }
    if($("#txt_actComercial_caso").val() == "" &&(
                $("#slt_actComercial_status").val()=="Ingresado a Back" || 
                $("#slt_actComercial_status").val()=="Asignado" ||
                $("#slt_actComercial_status").val()=="En Revisi\u00F3n" ||
                $("#slt_actComercial_status").val()=="En Revisión" ||
                $("#slt_actComercial_status").val()=="Rechazado Back" || 
                $("#slt_actComercial_status").val()=="Ingresado TATA" || 
                $("#slt_actComercial_status").val()=="Rechazado TATA" || 
                $("#slt_actComercial_status").val()=="Finalizado OK" ) )
    {
        FuncionErrores(242); 
        $("#txt_actComercial_caso").focus();
        return false;
    }    
    if(validarNum.test($("#txt_actComercial_caso").val()))
    {
        FuncionErrores(202); 
        $("#txt_actComercial_caso").focus();
        return false;
    }	
    if( $("#txt_actComercial_nroNegocio").val()== "" && $("#slt_actComercial_status").val() == "Finalizada OK" )
    {
        FuncionErrores(203); 
        $("#txt_actComercial_nroNegocio").focus();
        return false;
    }
    if(validarNum.test($("#txt_actComercial_nroNegocio").val()))
    {
        FuncionErrores(202); 
        $("#txt_actComercial_nroNegocio").focus();
        return false;
    }
    if($("#slt_actComercial_tipoClte").val() == "")
    {
        FuncionErrores(204); 
        $("#slt_actComercial_tipoClte").focus();
        return false;
    }
//    if( $("#txt_actComercial_corrCotiza").val()== "")
//    {
//        FuncionErrores(205); 
//        $("#txt_actComercial_corrCotiza").focus();
//        return false;
//    }
//    if(validarNum.test($("#txt_actComercial_corrCotiza").val()))
//    {
//        FuncionErrores(202);
//        $("#txt_actComercial_corrCotiza").focus();
//        return false;
//    }
//    validacion nroNegocio
//    if(id == 1 && !validarNumeroNegocio($("#txt_actComercial_nroNegocio").val())){
//        FuncionErrores(245);
//        $("#txt_actComercial_nroNegocio").focus();
//        return false;
//    }
//    validacion nroNegocio    
    if($("#slt_actComercial_tipoServicio").val() == "")
    {
        FuncionErrores(206);
        $("#slt_actComercial_tipoServicio").focus();
        return false;
    }
    if($("#slt_actComercial_serviMovil").val() == "")
    {
        FuncionErrores(207);
        $("#slt_actComercial_serviMovil").focus();
        return false;
    }	
    /*if($("#txt_actComercial_cantMovil").val() == "")
    {
        FuncionErrores(224);
        $("#txt_actComercial_cantMovil").focus();
        return false;
    }*/
    if(validarNum.test($("#txt_actComercial_cantMovil").val()))
    {
        FuncionErrores(224);
        $("#txt_actComercial_cantMovil").focus();
        return false;
    }
    if($("#slt_actComercial_status").val() == "")
    {
        FuncionErrores(208);
        $("#slt_actComercial_status").focus();
        return false;
    }
    if($("#slt_actComercial_TipoNegocio").val() == "")
    {
        FuncionErrores(209);
        $("#slt_actComercial_TipoNegocio").focus();
        return false;
    }
    if(validaCorrCotiza && validaNroNegocio){
        if(errorCorrCotiza){
            FuncionErrores(245);
            $("#txt_actComercial_corrCotiza").focus();
            return false;
        }
        
        if(errorNroNegocio){
            FuncionErrores(245);
            $("#txt_actComercial_corrCotiza").focus();
            return false;
        }
        ActividadComercial(id,secuencia);
    }
    
}
function DetalleActividadComercial(id)
{
    var validarNum = new RegExp("[^0-9]");
    var valNumDouble = new RegExp("[^0-9.]");    
    if(id == 'ingreso')
    {
        var td = $('#tblDetalleComer').children('tbody').children('tr').length; 
        for(var i = 0; i<td;i++)
        {                
            if($("#actComerDet_nroMovil"+i).text() === $("#txt_detalleComercial_nroMovil").val())
            {
                FuncionErrores(221);
                $("#txt_detalleComercial_nroMovil").focus();
                return false;
            }
        }
    }
    if($("#txt_detalleComercial_nroMovil").val() === "")
    {
        FuncionErrores(210);
        $("#txt_detalleComercial_nroMovil").focus();
        return false;
    }
    if(validarNum.test($("#txt_detalleComercial_nroMovil").val()))
    {
        FuncionErrores(202);
        $("#txt_detalleComercial_nroMovil").focus();
        return false;
    }
    if(valNumDouble.test($("#txt_detalleComercial_uf").val()))
    {
        FuncionErrores(202);
        $("#txt_detalleComercial_uf").focus();
        return false;
    }
    if($("#txt_detalleComercial_uf").val() > 999.99)
    {
        FuncionErrores(223);
        $("#txt_detalleComercial_uf").focus();
        return false;
    }
    if($("#slt_detalleComercial_tipoPlanNue").val() == "")
    {
        FuncionErrores(213);
        $("#slt_detalleComercial_tipoPlanNue").focus();
        return false;
    } 
    if($("#slt_detalleComercial_PlanNue").val() == "")
    {
        FuncionErrores(215);
        $("#slt_detalleComercial_PlanNue").focus();
        return false;
    }
    if(validarNum.test($("#txt_detalleComercial_cargoFijoAnt").val()))
    {
        FuncionErrores(202);
        $("#txt_detalleComercial_cargoFijoAnt").focus();
        return false;
    }
    if($("#txt_detalleComercial_cargoFijoNue").val() == "")
    {
        FuncionErrores(217);
        $("#txt_detalleComercial_cargoFijoNue").focus();
        return false;
    }
    if(validarNum.test($("#txt_detalleComercial_cargoFijoNue").val()))
    {
        FuncionErrores(202);
        $("#txt_detalleComercial_cargoFijoNue").focus();
        return false;
    }
    if($("#txt_detalleComercial_arpu").val() == "")
    {
        FuncionErrores(219);
        $("#txt_detalleComercial_arpu").focus();
        return false;
    }
    if(validarNum.test($("#txt_detalleComercial_arpu").val()))
    {
        FuncionErrores(202);
        $("#txt_detalleComercial_arpu").focus();
        return false;
    }
    DetalleComercial(id);
}