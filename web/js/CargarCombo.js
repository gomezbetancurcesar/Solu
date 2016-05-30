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
            
            //$('#slt_actComercial_serviMovil').html("<option value=''>--Seleccione--</option>"+data);
            
            $("#slt_actComercial_serviMovil").find("option").remove(); 
            $("#slt_actComercial_serviMovil").append('<option value="-1" selected>--Seleccione--</option>');
            if($("#parametroActComercial").val() !=  1)
            {
                if(tipo != "" && tipo == $("#tipoServicioMovil").val())
                {
                    $("#slt_actComercial_serviMovil").append(data);
                    $("#slt_actComercial_serviMovil").val($("#tipServicio").val());
                }
            }
            if($("#parametroActComercial").val() ==  1)
            {
                if(tipo != "")
                {
//                    $("#slt_actComercial_serviMovil").append('<option value="" selected>--Seleccione--</option>');
                    $("#slt_actComercial_serviMovil").append(data);                    
                }
            }
        }
    });
}

function cargaRv()
    {
        var ejecutivo = $("#slt_actComercial_ejecutivo").val();  
        var bloquearEnCaptura = false;
        if($("#supervisorCaptura").length > 0){
            bloquearEnCaptura = true;
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
                    $("#slt_actComercial_TipoNegocio").attr("disabled","disabled");
                    $("#slt_actComercial_TipoNegocio").html("")
                    $("#slt_actComercial_TipoNegocio").append("<option value='Captura'>Captura</option>");
                }
                if(campos[1] == "Desarrollo Peque\u00f1a Empresa")
                {
                    $("#slt_actComercial_TipoNegocio").removeAttr("disabled");
                    //Sacar las opciones
                    $("#slt_actComercial_TipoNegocio").html("");
                    //$("#slt_actComercial_TipoNegocio").append("<option value='Captura'>Captura</option>");
                    $("#slt_actComercial_TipoNegocio").append("<option selected value='Desarrollo Peque\u00f1a Empresa'>Desarrollo Peque\u00f1a Empresa</option>");                    
                }
                if(campos[1] == "Desarrollo Mediana Empresa")
                {
                    $("#slt_actComercial_TipoNegocio").removeAttr("disabled");
                    //Sacar las opciones
                    $("#slt_actComercial_TipoNegocio").html("");
                    //$("#slt_actComercial_TipoNegocio").append("<option value='Captura'>Captura</option>");
                    $("#slt_actComercial_TipoNegocio").append("<option selected value='Desarrollo Mediana Empresa'>Desarrollo Mediana Empresa</option>");                    
                }
                
                if(bloquearEnCaptura){
                    $("#slt_actComercial_TipoNegocio").html("");
                    $("#slt_actComercial_TipoNegocio").append("<option value='Captura'>Captura</option>");
                    $("#slt_actComercial_TipoNegocio").val("Captura");
                }
                $("#txt_actComercial_supervisor").val(campos[2]);
                $("#txt_actComercial_supervisor").attr("disabled","disabled");
                
                
            }
        });
    }
    
 