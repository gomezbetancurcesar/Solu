/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function cargaTipoPlan(){
    $.ajax({
        url: "ServletCargaPlanes?opcion=TipoPlan",
        type: 'POST',
        cache: false,
        async:false,
        success: function(msg){            
            $('#slt_detalleComercial_tipoPlanAnt').html("<option value=''>--Seleccione--</option>"+msg);
            $('#slt_detalleComercial_tipoPlanNue').html("<option value=''>--Seleccione--</option>"+msg);
            }
    });
}

function loadPlanNuevo(){
    var tipoPlan = $('#slt_detalleComercial_tipoPlanNue').val();
    $('#txt_detalleComercial_cargoFijoNue').val("");
    $.ajax({
        url: "ServletCargaPlanes?opcion=Plan&TipoPlan="+tipoPlan,
        type: 'POST',
        cache: false,
        async:false,
        success: function(msg){
            $('#slt_detalleComercial_PlanNue').html("<option value=''>--Seleccione--</option>"+msg);
        }
    });
}

function loadPlanAntiguo(){
    var tipoPlan = $('#slt_detalleComercial_tipoPlanAnt').val();
    $('#txt_detalleComercial_cargoFijoAnt').val("");
    $.ajax({
        url: "ServletCargaPlanes?opcion=Plan&TipoPlan="+tipoPlan,
        type: 'POST',
        cache: false,
        async:false,
        success: function(msg){
            $('#slt_detalleComercial_planAnt').html("<option value=''>--Seleccione--</option>"+msg);
        }
    });
}

function loadCargoFijoNuevo(){
    var tipoPlan = $('#slt_detalleComercial_tipoPlanNue').val();
    var plan =$('#slt_detalleComercial_PlanNue').val();
    $.ajax({
        url: "ServletCargaPlanes?opcion=CargaFijo&TipoPlan="+tipoPlan+"&Plan="+plan,
        type: 'POST',
        cache: false,
        async:false,
        success: function(msg){
            $('#txt_detalleComercial_cargoFijoNue').val(msg);
            $('#txt_distribucion_cargoNue').val(msg);
        }
    });
}

function loadCargoFijoAntiguo(){
    var tipoPlan = $('#slt_detalleComercial_tipoPlanAnt').val();
    var plan =$('#slt_detalleComercial_planAnt').val();
    $.ajax({
        url: "ServletCargaPlanes?opcion=CargaFijo&TipoPlan="+tipoPlan+"&Plan="+plan,
        type: 'POST',
        cache: false,
        async:false,
        success: function(msg){
            $('#txt_detalleComercial_cargoFijoAnt').val(msg);
            $('#txt_distribucion_cargoAnt').val(msg);
        }
    });
}