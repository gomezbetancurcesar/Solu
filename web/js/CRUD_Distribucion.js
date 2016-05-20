function guardaDistribucion()
{    
    var validarNum = new RegExp("[^0-9]");
    var nroFilas = "";
    var nroMovil = "";
    var tipoAntiguo = [];
    var tipoNuevo = [];
    var planAntiguo = [];
    var planNuevo = [];
    var cant = [];
    var cargoAntiguo = [];
    var cargoNuevo = [];
    var arpu = [];
    var portPPHAB = [];
    var secuencia = $("#secuencia").val();
    var corrCotiza = $("#corrCotiza").val();            
    var cantMovil = $("#cantidad").val(); 
    var tmpCantidad = $("#tmpCantidadTotal").val();
    var par = $("#parametroActComercial").val()
    nroFilas = $("#tblDistribucion").children("tbody").children("tr").length;
    for(var i = 1; i <= nroFilas; i++)
    {     
        if($("#Distri_cargoAnt"+i).text()!= "")
        {
            cargoAntiguo.push($("#Distri_cargoAnt"+i).text());
        }
        cargoNuevo.push($("#Distri_cargoNue"+i).text());
        if($("#Distri_tipoAnt"+i).text() != "")
        {
            tipoAntiguo.push($("#Distri_tipoAnt"+i).text());
        }
        if($("#Distri_planAnt"+i).text()!= "")
        {
            planAntiguo.push($("#Distri_planAnt"+i).text()) 
        }
        tipoNuevo.push($("#Distri_tipoNue"+i).text());        
        planNuevo.push($("#Distri_planNue"+i).text());
        arpu.push($("#Distri_arpu"+i).text());
        if($("#Distri_portPPHab"+i).text()!= "")
        {
            portPPHAB.push($("#Distri_portPPHab"+i).text());
        }
        cant.push($("#Distri_cantidad"+i).text());
    }            
    nroMovil = $("#txt_distribucion_nro").val();  
    if($("#txt_distribucion_nro").val() === "")
    {
        FuncionErrores(210);
        $("#txt_distribucion_nro").focus();
        return false;
    }
    if(validarNum.test($("#txt_distribucion_nro").val()))
    {
        FuncionErrores(202);
        $("#txt_distribucion_nro").focus();
        return false;
    }
    
    $.ajax({
        url : 'ServletDistribucion',        
        data: "arrayCantidad="+cant+"&arrayTipoAnt="+tipoAntiguo+"&arrayPlanAnt="+planAntiguo+"&arrayTipoNue="+tipoNuevo+"&arrayPlanNue="+planNuevo+
                "&filas="+nroFilas+"&nroMovil="+nroMovil+"&correlativo="+corrCotiza+"&secuencia="+secuencia+
                "&arrayCargoAntiguo="+cargoAntiguo+"&arrayCargoNuevo="+cargoNuevo+
                "&arrayArpu="+arpu+"&arrayportPPHAB="+portPPHAB,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            if(tmpCantidad != 0)
            {
                if(confirm("Todavia quedan numeros disponibles, Esta Seguro de salir de esta pantalla?"))
                {
                    //resta de cantidad de movil                    
                    //cantMovil = cantMovil - tmpCantidad;                    
                    location.href = "SL_Actualiza_ActividadComercial.jsp?par="+par+"&secuencia="+secuencia+
                        "&correlativo="+corrCotiza+"&cantidad="+cantMovil;
                }                
            }else
            {
                location.href = "SL_Actualiza_ActividadComercial.jsp?par="+par+"&secuencia="+secuencia+
                "&correlativo="+corrCotiza+"&cantidad="+cantMovil;
            }
           
             
        }
    });

}
function TablaDistribucion(id)
{
    var fila = $("#tblDistribucion").children("tbody").children("tr").length + 1;
    var tipoAntiguo = $("#slt_detalleComercial_tipoPlanAnt").val();
    var planAntiguo = $("#slt_detalleComercial_planAnt").val();
    var tipoNuevo = $("#slt_detalleComercial_tipoPlanNue").val();
    var planNuevo = $("#slt_detalleComercial_PlanNue").val();
    var cantidad = $("#txt_distribucion_cantidad").val();
    var cargoAntiguo = $("#txt_distribucion_cargoAnt").val();
    var cargoNuevo = $("#txt_distribucion_cargoNue").val();
    var arpu = $("#txt_distribucion_arpu").val();
    var portPPHAB = $("#slt_distribucion_portPPHAB").val();
    var cantTotal = ""; 
    cantTotal = $("#tmpCantidadTotal").val();    
    if(id == 'ingreso')
    {  
        var total = cantTotal - cantidad;
        if(total >= 0)
        {
            var tabla = "";
            tabla += "<tr id='filaDistri"+fila+"'>";
            tabla += "<td><a href='javascript: onclick=ModificaDistribucion("+fila+")'>>></a>"+
                    "<input type='hidden' value='0' id='habilitaDetCom' name='habilitaDetCom'/></td>";
            tabla += "<td id='Distri_portPPHab"+fila+"'>"+portPPHAB+"</td>";
            tabla += "<td id='Distri_tipoAnt"+fila+"'>"+tipoAntiguo+"</td>";
            tabla += "<td id='Distri_planAnt"+fila+"'>"+planAntiguo+"</td>";
            tabla += "<td id='Distri_cargoAnt"+fila+"'>"+cargoAntiguo+"</td>";
            tabla += "<td id='Distri_tipoNue"+fila+"'>"+tipoNuevo+"</td>";
            tabla += "<td id='Distri_planNue"+fila+"'>"+planNuevo+"</td>";
            tabla += "<td id='Distri_cargoNue"+fila+"'>"+cargoNuevo+"</td>";
            tabla += "<td id='Distri_arpu"+fila+"'>"+arpu+"</td>";
            tabla += "<td id='Distri_cantidad"+fila+"'>"+cantidad+"</td>";
            tabla += "</tr>";
            $("#tblDistribucion").find('tbody').append(tabla);                
            $("#tmpCantidadTotal").val(total);
            alert("Quedan "+$("#tmpCantidadTotal").val()+" numeros!");                       
        }
        if(total < 0)
        {            
            if($("#tmpCantidadTotal").val() > 0)
            {
                alert("Quedan Solo "+$("#tmpCantidadTotal").val()+" numeros");
            }
            else
            {
                alert("No Quedan Numeros Disponibles");
            }
        }
    }
    if(id == 'elimina')
    {
        var nro = $("#tmpId").val();
        var c = $("#Distri_cantidad"+nro).text();
        var total =   parseFloat(cantTotal) + parseFloat(c);  
        $("#tmpCantidadTotal").val(total);
        $("#filaDistri"+nro).remove();             
        alert("Quedan disponibles "+$("#tmpCantidadTotal").val()+" numeros");         
    }       
    if(id == 'modifica')
    {        
        var nro = $("#tmpId").val();
        var c = $("#Distri_cantidad"+nro).text();
        var d = $("#txt_distribucion_cantidad").val();
        var e = c - d;
           
        var total = parseInt(cantTotal) + parseInt(e);
        if(total >= 0)
        {            
            $("#filaDistri"+nro).remove();
            var tabla = "";
            tabla += "<tr id='filaDistri"+nro+"'>";
            tabla += "<td><a href='javascript: onclick=ModificaDistribucion("+nro+")'>>></a>"+
                    "<input type='hidden' value='0' id='habilitaDetCom' name='habilitaDetCom'/></td>";
            tabla += "<td id='Distri_portPPHab"+nro+"'>"+portPPHAB+"</td>";
            tabla += "<td id='Distri_tipoAnt"+nro+"'>"+tipoAntiguo+"</td>";
            tabla += "<td id='Distri_planAnt"+nro+"'>"+planAntiguo+"</td>";
            tabla += "<td id='Distri_cargoAnt"+nro+"'>"+cargoAntiguo+"</td>";
            tabla += "<td id='Distri_tipoNue"+nro+"'>"+tipoNuevo+"</td>";
            tabla += "<td id='Distri_planNue"+nro+"'>"+planNuevo+"</td>";
            tabla += "<td id='Distri_cargoNue"+nro+"'>"+cargoNuevo+"</td>";
            tabla += "<td id='Distri_arpu"+nro+"'>"+arpu+"</td>";
            tabla += "<td id='Distri_cantidad"+nro+"'>"+cantidad+"</td>";
            tabla += "</tr>";
            $("#tblDistribucion").find('tbody').append(tabla);                         
            $("#tmpCantidadTotal").val(total);
            alert("Quedan "+$("#tmpCantidadTotal").val()+" numeros!");                        
        }
        if(total < 0)
        {            
            if($("#tmpCantidadTotal").val() > 0)
            {
                alert("Quedan Solo "+$("#tmpCantidadTotal").val()+" numeros");
            }
            else
            {
                alert("No Quedan Numeros Disponibles");
            }
        }       
    }    
    $("#IngDistribucion").show();
    $("#ModDistribucion").hide();
    $("#EliDistribucion").hide();      
    $("#slt_detalleComercial_planAnt").find("option").remove();            
    $("#slt_detalleComercial_planAnt").append('<option value="" selected>--Seleccione--</option>');
    $("#slt_detalleComercial_PlanNue").find("option").remove();
    $("#slt_detalleComercial_PlanNue").append('<option value="" selected>--Seleccione--</option>');    
    $("#slt_detalleComercial_tipoPlanAnt").val("");
    $("#slt_detalleComercial_planAnt").val("");
    $("#slt_detalleComercial_tipoPlanNue").val("");
    $("#slt_detalleComercial_PlanNue").val("");
    $("#txt_distribucion_cantidad").val("");
    $("#slt_distribucion_portPPHAB").val("");
    $("#txt_distribucion_cargoAnt").val("");
    $("#txt_distribucion_cargoNue").val("");
    $("#txt_distribucion_arpu").val("");        
}
function ModificaDistribucion(id)
{
    var fila = $("#tblDistribucion").children("tbody").children("tr").length + 1;
    for(var i = 1; i <= fila;i ++)
    {
        $("#filaDistri"+i).css("background-color","white");
    }
    var planAntiguo = "";
    var planNuevo = "";
    $("#filaDistri"+id).css("background-color","#58FAF4");
    $("#slt_detalleComercial_tipoPlanAnt").val($("#Distri_tipoAnt"+id).text());
    $("#slt_detalleComercial_planAnt").val();
    $("#slt_detalleComercial_tipoPlanNue").val($("#Distri_tipoNue"+id).text());
    $("#slt_detalleComercial_PlanNue").val();
    $("#txt_distribucion_cantidad").val($("#Distri_cantidad"+id).text());
    $("#slt_distribucion_portPPHAB").val($("#Distri_portPPHab"+id).text());
    $("#txt_distribucion_cargoAnt").val($("#Distri_cargoAnt"+id).text());
    $("#txt_distribucion_cargoNue").val($("#Distri_cargoNue"+id).text());
    $("#txt_distribucion_arpu").val($("#Distri_arpu"+id).text());
    $("#habilitaDetCom").val("1");
    planAntiguo = $("#Distri_planAnt"+id).text();
    planNuevo = $("#Distri_planNue"+id).text();
    cargaPlanAntiguo(planAntiguo);
    cargaPlanNuevo(planNuevo);
    $("#tmpId").val(id);
    $("#IngDistribucion").hide();
    $("#EliDistribucion").show();
    $("#ModDistribucion").show();
}
function AbrirDistribucion()
{       
    var validarNum = new RegExp("[^0-9]");    
    var corrCotiza = $("#txt_actComercial_corrCotiza").val();  
//    var nroContrato = $("#txt_actComercial_nroContrato").val();    
    var cantMovil = $("#txt_actComercial_cantMovil").val();
    var ultimo = $("#ultimo").val();
    var contador = $("#cantidad").val();
    var par = $("#parametroActComercial").val();
    var resta=cantMovil-contador;
    if($("#txt_actComercial_cantMovil").val() == "" || $("#txt_actComercial_cantMovil").val() == "0" )
    {
        FuncionErrores(224);
        $("#txt_actComercial_cantMovil").focus();
        return false;
    }
    if(validarNum.test($("#txt_actComercial_cantMovil").val()))
    {
        FuncionErrores(202);
        $("#txt_actComercial_cantMovil").focus();
        return false;
    }
    if($("#txt_actComercial_cantMovil").val() != "")
    {        
        
        var secu = $("#secuencia").val();
//        location.href="SL_DistribucionMoviles.jsp?cantidad="+cantMovil+"&secuencia="+secu+"&negocio="+nroNegocio+"&tipoClte="+tipoClte+
        location.href="SL_DistribucionMoviles.jsp?cantidad="+cantMovil+"&secuencia="+secu+
                "&correlativo="+corrCotiza+"&ultimo="+ultimo+"&resta="+resta+"&par="+par;
//                "&fecha="+fecha+"&nomEje="+nomEje+"&rv="+rv+"&supervisor="+supervisor+"&ultimo="+ultimo+"&cantidad="+cantidad;
    }
}
function ValidaDistribucion(id)
{
    var validarNum = new RegExp("[^0-9]");
    var valNumDouble = new RegExp("[^0-9.]"); 
    var tipoNuevo = $("#slt_detalleComercial_tipoPlanNue").val();
    var planNuevo = $("#slt_detalleComercial_PlanNue").val();
    var cantidad = $("#txt_distribucion_cantidad").val(); 
    var cargoNuevo = $("#txt_distribucion_cargoNue").val();
    var arpu = $("#txt_distribucion_arpu").val();
    var portPPHAB = $("#slt_distribucion_portPPHAB").val();        
    if(tipoNuevo == "")
    {
        FuncionErrores(213);
        $("#slt_detalleComercial_tipoPlanNue").focus();
        return false;
    }   
    if(planNuevo == "")
    {
        FuncionErrores(215);
        $("#slt_detalleComercial_PlanNue").focus();
        return false;
    }
    if(cargoNuevo == "")
    {
        FuncionErrores(217);
        $("#txt_distribucion_cargoNue").focus();
        return false;
    }
     if(validarNum.test(cargoNuevo))
    {
        FuncionErrores(202);
        $("#txt_distribucion_cargoNue").focus();
        return false;
    }
//    if(uf == "")
//    {
//        FuncionErrores(211);
//        $("#txt_distribucion_uf").focus();
//        return false;
//    }
    if(arpu == "")
    {
        FuncionErrores(219);
        $("#txt_distribucion_arpu").focus();
        return false;
    }
     if(validarNum.test(arpu))
    {
        FuncionErrores(202);
        $("#txt_distribucion_arpu").focus();
        return false;
    }
//    if(portPPHAB == "")
//    {
//        FuncionErrores(218);
//        $("#slt_distribucion_portPPHAB").focus();
//        return false;
//    }
    if(cantidad == "")
    {
        FuncionErrores(224);
        $("#txt_distribucion_cantidad").focus();
        return false;
    }
     if(validarNum.test(cantidad))
    {
        FuncionErrores(202);
        $("#txt_distribucion_cantidad").focus();
        return false;
    }
    TablaDistribucion(id);
}
function Volver()
{    
    var secuencia = $("#secuencia").val();
    var corrCotiza = $("#corrCotiza").val();
    var cantMovil = $("#cantidad").val();
    var par = $("#parametroActComercial").val();        
    location.href = "SL_Actualiza_ActividadComercial.jsp?par="+par+"&secuencia="+secuencia+
                "&correlativo="+corrCotiza+"&cantidad="+cantMovil;
}
