function Clientes(id){

    var mod = "";
    if (id === 1)
    {	
        mod = "ingreso";
    } if(id==3){
        mod="Consultar";
        var boton=$("#btn_Cliente_Ingresar");
        var rutCli = $("#txt_cliente_rut").val();
	var nomCli = $("#txt_cliente_nombre").val();
        var contacto = $("#txt_cliente_contacto").val();
	var direccion = $("#txt_cliente_direccion").val();
	var nomEje = $("#txt_cliente_ejecutivo").val();
	var estado = $("#txt_cliente_estado").val();
        $.ajax({
		url : 'ServletSPClienteSolutel', 
		data : "mod="+mod+"&txt_cliente_rut="+rutCli+"&txt_cliente_nombre="+nomCli+"&txt_cliente_contacto="+contacto+
                        "&txt_cliente_direccion="+direccion+"&txt_cliente_ejecutivo="+nomEje+"&txt_cliente_estado="+estado,
		type : 'POST',
		dataType : "html"});
            
    }if(id === 2)
    {
        mod= "modifica";
    }
	//var rut = "";
        //rut = $("#txt_cliente_rut").val();
	var rutCli = $("#txt_cliente_rut").val();
	var nomCli = $("#txt_cliente_nombre").val();
        var contacto = $("#txt_cliente_contacto").val();
	var direccion = $("#txt_cliente_direccion").val();
	var nomEje = $("#txt_cliente_ejecutivo").val();
	var estado = $("#txt_cliente_estado").val();
        
	$.ajax({
		url : 'ServletSPClienteSolutel', 
		data : "mod="+mod+"&txt_cliente_rut="+rutCli+"&txt_cliente_nombre="+nomCli+"&txt_cliente_contacto="+contacto+
                        "&txt_cliente_direccion="+direccion+"&txt_cliente_ejecutivo="+nomEje+"&txt_cliente_estado="+estado,
		type : 'POST',
		dataType : "html",
		success : function(data){
                    window.location.href="SL_Seleccion_Clientes.jsp";
		},
                error:function(error){
                    alert(error.responseText);
                    console.log(error);
                }
	});

}
function filtroCliente()
{
    var filEjecutivoCli = "";
    var filEstadoCli = "";
    var filRutCli = "";
    var filNombreCli= "";
//    var filContactoCli="";
//    var filDirCli="";
    
    filEjecutivoCli= $("#filtro_cliente_ejecutivo").val();
    filEstadoCli= $("#filtro_cliente_estado").val();
    filRutCli = $("#filtro_cliente_rut").val();  
    filNombreCli = $("#filtro_cliente_nombre").val();  
//    filContactoCli =  $("#filtro_cliente_contacto").val();
//    filDirCli = $("#filtro_cliente_direccion").val();
    
    if(filEjecutivoCli == "" && filEstadoCli == "" && filRutCli == "" && filNombreCli == "")
    {
        FuncionErrores(228);
        return false;       
    }    
    $.ajax({
        url : 'ServletFiltroCliente', 
        data: "nomEje="+filEjecutivoCli+"&estado="+filEstadoCli+"&rutCli="+filRutCli+
                "&nomCli="+filNombreCli,
        type : 'POST',
        dataType : "html",
        success : function(data) {     
            
            $('#tblCliente').dataTable().fnDestroy(); 
            $("#tblCliente").find("tbody").html(data);  
            $('#tblCliente').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
                "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
                bFilter: false, bInfo: false,
                "bLengthChange": false,
              // "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7,8,9,10,11,12,13,14] }]
            });
        }
    });
}
function ModificaCliente(id)
{
    CancelaCliente();
    if($("#habilitaCliente").val() == 0)
    {
        $("#filaTablaCliente"+id).css("background-color","#58FAF4").removeClass("alt");
        $("#habilitaCliente").val("1");
        var rut =  $("#Cliente_rut"+id).text();        
        $("#rut").val(rut);
    }
}
//function ConsultaCliente(id)
//{
//    CancelaCliente();
//    if($("#habilitaCliente").val() == 0)
//    {
//        $("#filaTablaCliente"+id).css("background-color","#58FAF4").removeClass("alt");
//        $("#btn_Cliente_Ingresar").hide();
//        $("#habilitaCliente").val("1");
//        var rut =  $("#Cliente_rut"+id).text();        
//        $("#rut").val(rut);
//        
//    }
//}
function CancelaCliente()
{
    if($("#habilitaCliente").val() == 1)
    {
        $("#rut").val("");
	var td = $('#tblCliente').children('tbody').children('tr').length;           
	for(var i = 0; i<=td;i++){                
		if(i % 2 === 0){
			$("#filaTablaCliente"+i).addClass("alt");
		}else {                    
			$("#filaTablaCliente"+i).css("background-color","white");
		}
	}
	$("#habilitaCliente").val("0");
    }
}

