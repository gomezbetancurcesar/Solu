function FuncionValidaCliente(id){
     var validarRut = new RegExp("[^0-9kK-]"); 
	

    var rutCli = $("#txt_cliente_rut").val();
    var posicion1 = rutCli.indexOf('-');
    var tmp1 = VerificaRut(rutCli);   
    
    //valida rut cliente
   if(rutCli == ""){
        FuncionErrores(113);   
        $("#txt_cliente_rut").focus();
        return false;
    }
    if (validarRut.test(rutCli)) {
        FuncionErrores(114);   
        $("#txt_cliente_rut").focus();
        return false;
    }
     if(posicion1 == -1)
    {
        FuncionErrores(115);   
        $("#txt_cliente_rut").focus();
        return false;
    }
    
    if(tmp1 == false)
    {
        FuncionErrores(116);   
        $("#txt_cliente_rut").focus();
        return false;
    }
    //valida ingreso nombre cliente
     if($("#txt_cliente_nombre").val() == "")
    {
        FuncionErrores(201); 
        $("#txt_cliente_nombre").focus();
        return false;
    }
    
    if($("txt_cliente_contacto").val() == "")
    {
        FuncionErrores(220); 
        $("#txt_cliente_contacto").focus();
        return false;
    }
    
    if($("txt_cliente_direccion").val() == "")
    {
        FuncionErrores(221); 
        $("#txt_cliente_direccion").focus();
        return false;
    }
    
    if($("txt_cliente_ejecutivo").val() == "")
    {
        FuncionErrores(200); 
        $("#txt_cliente_ejecutivo").focus();
        return false;
    }
          
        if($("#txt_cliente_estado").val() == "")
	{
		alert("Ingrese estado");
		$("#txt_cliente_estado").focus();
        return false;
	}
         Clientes(id);
    }


