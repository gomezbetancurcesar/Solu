function cargaServicio()
{	
    var tipo = "";    
    tipo = $("#slt_actComercial_tipoServicio").val();	        
    $.ajax({
        url : 'ServletCargaServicio', 
        data: "tipoServicio="+tipo,
        type : 'POST',
        dataType : "html",
        success : function(data) {		
            $("#slt_actComercial_serviMovil").find("option").remove(); 
            $("#slt_actComercial_serviMovil").append('<option value="" selected>--Seleccione--</option>');
            if($("#parametroActComercial").val() !=  1)
            {
                if(tipo != "")
                {
                    $("#slt_actComercial_serviMovil").append(data);
                    $("#slt_actComercial_serviMovil").val($("#tipServicio").val());
                }
            }
            if($("#parametroActComercial").val() ==  1)
            {
                if(tipo != "")
                {
                    $("#slt_actComercial_serviMovil").append('<option value="" selected>--Seleccione--</option>');
                    $("#slt_actComercial_serviMovil").append(data);                    
                }
            }
        }
    });
}
function cargaPlanAntiguo(plan)
{    
    var tipo = "";
    tipo = $("#slt_detalleComercial_tipoPlanAnt").val();    
    $.ajax({
        url : 'ServletCargaPlanAntiguo', 
        data: "tipoPlanAntiguo="+tipo,
        type : 'POST',
        dataType : "html",
        success : function(data) {		
            $("#slt_detalleComercial_planAnt").find("option").remove();            
            $("#slt_detalleComercial_planAnt").append('<option value="" selected>--Seleccione--</option>');
            if($("#habilitaDetCom").val() == 1)
            {   
                if(tipo != "")
                {
                    $("#slt_detalleComercial_planAnt").append(data);
                    $("#slt_detalleComercial_planAnt").val(plan);
                }
            }
            if($("#habilitaDetCom").val() != 1)
            {
                if(tipo != "")
                {
                    $("#slt_detalleComercial_planAnt").append(data);
                }
            }
        }
    });
}
function cargaPlanNuevo(plan)
{
    var tipo = $("#slt_detalleComercial_tipoPlanNue").val();    
    $.ajax({
        url : 'ServletCargaPlanNuevo', 
        data: "tipoPlanNuevo="+tipo,
        type : 'POST',
        dataType : "html",
        success : function(data) {		
            $("#slt_detalleComercial_PlanNue").find("option").remove();
            $("#slt_detalleComercial_PlanNue").append('<option value="">--Seleccione--</option>');            
                if(tipo != "")
                {                                        
                    $("#slt_detalleComercial_PlanNue").append(data);
                    $("#slt_detalleComercial_PlanNue").val(plan);
                }               
        }
    });
}