var tableConfiguracion;
var divLoading = document.querySelector("#divLoading");
document.addEventListener('DOMContentLoaded', function(){

	tableConfiguracion = $('#tableConfiguracion').dataTable( {
		"aProcessing":true,
		"aServerSide":true,
        "language": {
        	"url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
        },
        "ajax":{
            "url": " "+base_url+"/Configuracion/getConfiguracion",
            "dataSrc":""
        },
        "columns":[
            {"data":"idconfigura"},
            {"data":"nit"},
            {"data":"razonsocial"},
            {"data":"nombrereplegal"},
            {"data":"direccion"},
            {"data":"fechainiciofiscal"},
            {"data":"fechafinfiscal"},
            {"data":"status"},
            {"data":"options"}
        ],
        'dom': 'lBfrtip',
        'buttons': [
            {
                "extend": "copyHtml5",
                "text": "<i class='far fa-copy'></i> Copiar",
                "titleAttr":"Copiar",
                "className": "btn btn-secondary"
            },{
                "extend": "excelHtml5",
                "text": "<i class='fas fa-file-excel'></i> Excel",
                "titleAttr":"Esportar a Excel",
                "className": "btn btn-success"
            },{
                "extend": "pdfHtml5",
                "text": "<i class='fas fa-file-pdf'></i> PDF",
                "titleAttr":"Esportar a PDF",
                "className": "btn btn-danger"
            },{
                "extend": "csvHtml5",
                "text": "<i class='fas fa-file-csv'></i> CSV",
                "titleAttr":"Esportar a CSV",
                "className": "btn btn-info"
            }
        ],
        "resonsieve":"true",
        "bDestroy": true,
        "iDisplayLength": 10,
        "order":[[0,"desc"]]  
        });

    });

function openModal(){

    document.querySelector('#idconfigura').value ="";
    document.querySelector('.modal-header').classList.replace("headerUpdate", "headerRegister");
    document.querySelector('#btnActionForm').classList.replace("btn-info", "btn-primary");
    document.querySelector('#btnText').innerHTML ="Guardar";
    document.querySelector('#titleModal').innerHTML = "Nueva configuracion";
    document.querySelector("#formConfiguracion").reset();
	$('#modalFormConfiguracion').modal('show');
}


function fntViewInfo(idconfigura){
    var idconfigura = idconfigura;
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url+'/Configuracion/getConfigura/'+idconfigura;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){
        if(request.readyState == 4 && request.status == 200){
            var objData = JSON.parse(request.responseText);
            if(objData.status)
            {
                document.querySelector("#celIdconfigura").innerHTML = objData.data.idconfigura;
                document.querySelector("#celNit").innerHTML = objData.data.nit;
                document.querySelector("#celrazonsocial").innerHTML = objData.data.razonsocial;
                document.querySelector("#celreplegal").innerHTML = objData.data.nombrereplegal;
                document.querySelector("#celdireccion").innerHTML = objData.data.direccion;
                document.querySelector("#celfechainicio").innerHTML = objData.data.fechainiciofiscal;
                document.querySelector("#celfechafinal").innerHTML = objData.data.fechafinfiscal;
                document.querySelector("#estado").innerHTML = objData.data.status;
                $('#modalViewConfigura').modal('show');
            }else{
                swal("Error", objData.msg , "error");
            }
        }
    }
}

function fntEditInfo(idconfigura){

    // cambiar la apariencia al formulario

    document.querySelector('#titleModal').innerHTML ="Actualizar Empresa";
    document.querySelector('.modal-header').classList.replace("headerRegister", "headerUpdate");
    document.querySelector('#btnActionForm').classList.replace("btn-primary", "btn-info");
    document.querySelector('#btnText').innerHTML ="Actualizar";

    var idconfigura = idconfigura;
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url+'/Configuracion/getConfigura/'+idconfigura;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){
        if(request.readyState == 4 && request.status == 200){
            var objData = JSON.parse(request.responseText);
            if(objData.status)
            {
                document.querySelector("#txtID").value = objData.data.idconfigura;
                document.querySelector("#txtNit").value = objData.data.nit;
                document.querySelector("#txtRazonSocial").value = objData.data.razonsocial;
                document.querySelector("#txtNombreRepLegal").value = objData.data.nombrereplegal;
                document.querySelector("#txtDireccion").value = objData.data.direccion;
                document.querySelector("#txtFechainicio").value = objData.data.fechainiciofiscal;
                document.querySelector("#txtFechafin").value = objData.data.fechafinfiscal;

                if(objData.data.status == 1)
                    {
                         document.querySelector("#listStatus").value = 1;
                    }else{
                        document.querySelector("#listStatus").value = 2;
                    }
                    $('#listStatus').selectpicker('render');
                    $('#modalFormConfiguracion').modal('show');
            }else{
                swal("Error", objData.msg , "error");
            }
        }
    }
}

function fntEditkkkkkk(element,idpersona){
    rowTable = element.parentNode.parentNode.parentNode; 
    document.querySelector('#titleModal').innerHTML ="Actualizar Usuario";
    document.querySelector('.modal-header').classList.replace("headerRegister", "headerUpdate");
    document.querySelector('#btnActionForm').classList.replace("btn-primary", "btn-info");
    document.querySelector('#btnText').innerHTML ="Actualizar";

    let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    let ajaxUrl = base_url+'/Usuarios/getUsuario/'+idpersona;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){

        if(request.readyState == 4 && request.status == 200){
            let objData = JSON.parse(request.responseText);

            if(objData.status)
            {
                document.querySelector("#idUsuario").value = objData.data.idpersona;
                document.querySelector("#txtIdentificacion").value = objData.data.identificacion;
                document.querySelector("#txtNombre").value = objData.data.nombres;
                document.querySelector("#txtApellido").value = objData.data.apellidos;
                document.querySelector("#txtTelefono").value = objData.data.telefono;
                document.querySelector("#txtEmail").value = objData.data.email_user;
                document.querySelector("#listRolid").value =objData.data.idrol;
                $('#listRolid').selectpicker('render');

                if(objData.data.status == 1){
                    document.querySelector("#listStatus").value = 1;
                }else{
                    document.querySelector("#listStatus").value = 2;
                }
                $('#listStatus').selectpicker('render');
            }
        }
    
        $('#modalFormUsuario').modal('show');
    }
}

