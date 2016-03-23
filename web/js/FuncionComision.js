function ValidaComision()
{
    var validarNum = new RegExp("[^0-9]");
    var mes = "";
    var anio = "";
    mes = $("#slt_comision_mes").val();
    anio = $("#txt_comision_anio").val();
    var fechaIni = $("#txt_comision_inicio").val();
    var fechaFin = $("#txt_comision_final").val();
    var estadoCierre = $('input:radio[name=radiosComision]:checked').val();
    var inicial= [];
    var final = []
    inicial = fechaIni.split("-");
    final = fechaFin.split("-");
    if(fechaIni == "")
    {
        FuncionErrores(231);
        $("#txt_comision_inicio").focus();
        return false;
    }
    if(fechaFin == "")
    {
        FuncionErrores(232);
        $("#txt_comision_final").focus();
        return false;
    }
    if(anio == "")
    {
        FuncionErrores(233);
        $("#txt_comision_anio").focus();
        return false;
    }
    if(validarNum.test(anio))
    {
        FuncionErrores(202); 
        $("#txt_comision_anio").focus();
        return false;
    }	
    if(mes == "")
    {
        FuncionErrores(234);
        $("#slt_comision_mes").focus();
        return false;
    }
    if(fechaIni > fechaFin)
    {
        FuncionErrores(237);
        return false;
    }
    if(anio != inicial[0] && anio != final[0])
    {
        FuncionErrores(230);
        $("#txt_comision_anio").focus();
        return false;
    }  
    if(mes != inicial[1] && mes != final[1])
    {
        FuncionErrores(229);
        $("#slt_comision_mes").focus();
        return false;
    }
    if(!estadoCierre)
    {
        FuncionErrores(235);        
        return false;
    }    
    var filas = $("#tblComision").children("tbody").children('tr').length;
    var fInicio = "";
    var fFinal = "";
    for(var i = 0; i < filas ; i++ )
    {                     
        fInicio = $("#comision_fechaInicio"+i).text();
        fFinal = $("#comision_fechaFinal"+i).text();
        if(new Date(fechaIni).getTime() >=  new Date(fInicio).getTime() &&
            new Date(fechaIni).getTime() <= new Date(fFinal).getTime() &&
            $("#comision_estado"+i).text() === "DE")          
        {
             FuncionErrores(236);
             $("#txt_comision_inicio").focus();
             return false;
        }
        if(new Date(fechaFin).getTime() >= new Date(fInicio).getTime() &&
            new Date(fechaFin).getTime() <= new Date(fFinal).getTime() && 
            $("#comision_estado"+i).text() === "DE")
        {
             FuncionErrores(236);
             $("#txt_comision_final").focus();
             return false;
        }
    }
    NuevaComisionVenta();
}
function NuevaComisionVenta()
{
    var mes = "";
    var anio = "";
    mes = $("#slt_comision_mes").val();
    anio = $("#txt_comision_anio").val();
    var fechaIni = $("#txt_comision_inicio").val();
    var fechaFin = $("#txt_comision_final").val();
    var estadoCierre = $('input:radio[name=radiosComision]:checked').val();
    var fechaCierre = $("#txt_comision_fechaHoy").val();

    $.ajax({
        url : 'ServletComision',        
        data: "slt_comision_mes="+mes+"&txt_comision_anio="+anio+"&txt_comision_inicio="+fechaIni+
                "&txt_comision_final="+fechaFin+"&estadoCierre="+estadoCierre+"&txt_comision_fechaHoy="+fechaCierre,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            var result = $.trim(data); 
            if(result != "")
            {
                FuncionErrores(238);
            }
            location.href="SL_Comisiones_Venta.jsp";
        }
    });
}
function seleccionComision(id)
{
    desmarcarComision();    
    if($("#habilitaComision").val() == 0 )
    {         
        $("#filaComision"+id).css("background-color","#58FAF4").removeClass("alt");                 
        $("#hid_comision_fechaInicial").val($("#comision_fechaInicio"+id).text());
        $("#hid_comision_fechaFinal").val($("#comision_fechaFinal"+id).text());
        $("#hid_comision_mes").val($("#comision_mes"+id).text());
        $("#hid_comision_anio").val($("#comision_anio"+id).text());
        $("#habilitaComision").val("1");
    }    
}
function excel(){        
        var inicial = $("#hid_comision_fechaInicial").val();
        var final = $("#hid_comision_fechaFinal").val();
        var mes = $("#hid_comision_mes").val();
        var anio = $("#hid_comision_anio").val();
        $.ajax({
        url : 'ServletExcelComision',        
        data: "hid_comision_fechaInicial="+inicial+"&hid_comision_fechaFinal="+final,
        type : 'POST',
        dataType : "html",
        success : function(data) { 
            if($("#habilitaComision").val() == 0)
            {
                FuncionErrores(241);
            }
            else
            {
                var result = $.trim(data);    
                if (result != 'nada')
                {         
                    location.href="SL_excel.jsp?mes="+mes+"&anio="+anio;
                    desmarcarComision();
                }                        
            }
        }
    });               
}
function desmarcarComision()
{
     if($("#habilitaComision").val() == 1 )
    {         
        var td = $('#tblComision').children('tbody').children('tr').length;           
        for(var i = 0; i<=td;i++){                
            if(i % 2 === 0){
                $("#filaComision"+i).addClass( "alt" );
            }else {                    
                $("#filaComision"+i).css("background-color","white");
            }
        }                      
        $("#hid_comision_fechaInicial").val("");
        $("#hid_comision_fechaFinal").val("");
        $("#hid_comision_mes").val("");
        $("#hid_comision_anio").val("");
        $("#habilitaComision").val("0");
    }
}