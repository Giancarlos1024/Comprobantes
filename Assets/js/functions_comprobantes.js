var tableComprobantes;
var divLoading = document.querySelector("#divLoading");
const loggedUserId = localStorage.getItem('loggedUserId');
const loggedUserEmail = localStorage.getItem('loggedUserEmail');
if (loggedUserId) {
    console.log("Usuario logueado ID:", loggedUserId);
    console.log("Correo del usuario logueado:", loggedUserEmail);
} else {
    console.log("No hay usuario logueado.");
}
document.addEventListener('DOMContentLoaded', function() {
    tableComprobantes = $('#tableComprobantes').dataTable({
        "aProcessing": true,
        "aServerSide": true,
        "language": {
            "url": "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
        },
        "ajax": {
            "url": base_url + "/Comprobantes/getComprobantes",
            "dataSrc": ""
        },
        "columns": [
            { "data": "idAsiento" },
            { "data": "numeroasiento" },
            { "data": "fecchaAsiento" },
            { "data": "conceptoOperacion" },
            { "data": "tipocomprobante" },
            { "data": "estadotransaccion" },
            { "data": "idUsuarios" },
            { "data": "status" },
            { "data": "options" }
        ],
        'dom': 'lBfrtip',
        'buttons': [
            { "extend": "copyHtml5", "text": "<i class='far fa-copy'></i> Copiar", "titleAttr": "Copiar", "className": "btn btn-secondary" },
            { "extend": "excelHtml5", "text": "<i class='fas fa-file-excel'></i> Excel", "titleAttr": "Exportar a Excel", "className": "btn btn-success" },
            { "extend": "pdfHtml5", "text": "<i class='fas fa-file-pdf'></i> PDF", "titleAttr": "Exportar a PDF", "className": "btn btn-danger" },
            { "extend": "csvHtml5", "text": "<i class='fas fa-file-csv'></i> CSV", "titleAttr": "Exportar a CSV", "className": "btn btn-info" }
        ],
        "responsive": true,
        "bDestroy": true,
        "iDisplayLength": 10,
        "order": [[0, "desc"]]
    });

    let formComprobante = document.querySelector("#formComprobantes");
    if (formComprobante) {
        formComprobante.onsubmit = function(e) {
            e.preventDefault();
            let strNumeroAsiento = document.querySelector('#txtNumeroAsiento').value;
            let strFechaAsiento = document.querySelector('#txtFechaAsiento').value;
            let strTipoComprobante = document.querySelector('#listComprobante').value;
            let intEstadoTransaccion = document.querySelector('#listStatus').value;
            let strConceptoOperacion = document.querySelector('#txtConceptoOperacion').value;
            let intIdUsuario = loggedUserId; // Usar el ID del usuario logueado

            let strCodigoCuenta = document.querySelector('#txtCodigoCuenta').value;
            let strNombreCuenta = document.querySelector('#txtNombreCuenta').value;
            let strDebe = document.querySelector('#txtDebe').value;
            let strHaber = document.querySelector('#txtHaber').value;
            let strDescripcion = document.querySelector('#txtDescripcion').value;

            if (!strNumeroAsiento || !intEstadoTransaccion || !strFechaAsiento || !strConceptoOperacion || !strTipoComprobante || !intIdUsuario) {
                console.error("Error: Todos los campos son obligatorios.");
                swal("Atención", "Todos los campos son obligatorios.", "error");
                return false;
            }

            if (!strNumeroAsiento || !intEstadoTransaccion || !strFechaAsiento || !strConceptoOperacion || !strTipoComprobante || !intIdUsuario || !strCodigoCuenta || !strNombreCuenta || !strDebe || !strHaber || !strDescripcion) {
                console.error("Error: Todos los campos son obligatorios.");
                swal("Atención", "Todos los campos son obligatorios.", "error");
                return false;
            }

            console.log("Formulario capturado:");
            console.log("Numero Asiento:", strNumeroAsiento);
            console.log("Fecha Asiento:", strFechaAsiento);
            console.log("Concepto Operacion:", strConceptoOperacion);
            console.log("Tipo Comprobante:", strTipoComprobante);
            console.log("Estado Transaccion:", intEstadoTransaccion);
            console.log("ID Usuario:", intIdUsuario);
            console.log("Código Cuenta:", strCodigoCuenta);
            console.log("Nombre Cuenta:", strNombreCuenta);
            console.log("Debe:", strDebe);
            console.log("Haber:", strHaber);
            console.log("Descripción:", strDescripcion);


            divLoading.style.display = "flex";
            let request = new XMLHttpRequest();
            let ajaxUrl = base_url + '/Comprobantes/setComprobante';
            let formData = new FormData(formComprobante);
            formData.append('idUsuario', intIdUsuario); // Agregar ID de usuario
            formData.append('codigoCuenta', strCodigoCuenta);
            formData.append('nombreCuenta', strNombreCuenta);
            formData.append('debe', strDebe);
            formData.append('haber', strHaber);
            formData.append('descripcion', strDescripcion);

            request.open("POST", ajaxUrl, true);
            request.send(formData);
            request.onreadystatechange = function() {
                if (request.readyState === 4) {
                    console.log("Estado de la solicitud: ", request.status);
                    if (request.status === 200) {
                        console.log("Respuesta del servidor: ", request.responseText);
                        try {
                            let objData = JSON.parse(request.responseText);
                            if (objData.status) {
                                $('#tableComprobantes').DataTable().ajax.reload();
                                $('#modalFormComprobantes').modal("hide");
                                formComprobante.reset();
                                swal("Comprobante", objData.message, "success");
                            } else {
                                swal("Atención", objData.message, "error");
                            }
                        } catch (error) {
                            console.error("Error al procesar la respuesta JSON:", error);
                        }
                    } else {
                        console.error("Error en la solicitud:", request.statusText);
                    }
                    divLoading.style.display = "none";
                }
            };
        }
    }
    
}, false);
function openModal() {
    document.querySelector('#idComprobantes').value = "";
    document.querySelector('.modal-header').classList.replace("headerUpdate", "headerRegister");
    document.querySelector('#btnActionForm').classList.replace("btn-info", "btn-primary");
    document.querySelector('#btnText').innerHTML = "Guardar";
    document.querySelector('#titleModal').innerHTML = "Nuevo comprobante";
    document.querySelector("#formComprobantes").reset();
    $('#modalFormComprobantes').modal('show');
}
function fntViewInfo(idAsiento) {
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function() {
        if (request.readyState == 4 && request.status == 200) {
            var objData = JSON.parse(request.responseText);
            if (objData.status) {
                document.querySelector("#celIdComprobante").innerHTML = objData.data.idAsiento;
                document.querySelector("#celNumeroAsiento").innerHTML = objData.data.numeroasiento;
                document.querySelector("#celFechaAsiento").innerHTML = objData.data.fecchaAsiento;
                document.querySelector("#celDetalle").innerHTML = objData.data.conceptoOperacion;
                document.querySelector("#celTipoComprobante").innerHTML = objData.data.tipocomprobante;
                document.querySelector("#celEstadoTransaccion").innerHTML = objData.data.estadotransaccion;
                document.querySelector("#celUsuario").innerHTML = objData.data.idUsuarios;
                document.querySelector("#celStatus").innerHTML = objData.data.status == 1 ? '<span class="badge badge-success">Activo</span>' : '<span class="badge badge-danger">Inactivo</span>';
                document.querySelector("#celDebe").innerHTML = objData.data.debe;
                document.querySelector("#celHaber").innerHTML = objData.data.haber;
                document.querySelector("#celDescripcionLidiario").innerHTML = objData.data.descripcion;
                document.querySelector("#celCodigoCuenta").innerHTML = objData.data.codigocuenta;
                document.querySelector("#celNombreCuenta").innerHTML = objData.data.nombrecuenta;

                $('#modalViewComprobante').modal('show');
            } else {
                swal("Error", objData.msg, "error");
            }
        }
    }
}
function fntEditInfo(idAsiento) {
    document.querySelector('#titleModal').innerHTML = "Actualizar Comprobante";
    document.querySelector('.modal-header').classList.replace("headerRegister", "headerUpdate");
    document.querySelector('#btnActionForm').classList.replace("btn-primary", "btn-info");
    document.querySelector('#btnText').innerHTML = "Actualizar";
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function() {
        if (request.readyState == 4 && request.status == 200) {
            var objData = JSON.parse(request.responseText);
            if (objData.status) {
                // document.querySelector("#idComprobantes").value = objData.data.idAsiento;
                document.querySelector("#txtNumeroAsiento").value = objData.data.numeroasiento;
                document.querySelector("#txtFechaAsiento").value = objData.data.fecchaAsiento;
                document.querySelector("#txtConceptoOperacion").value = objData.data.conceptoOperacion;
                document.querySelector("#listComprobante").value = objData.data.tipocomprobante;
                document.querySelector("#listStatus").value = objData.data.status;   
                
                
                $('#listComprobante').selectpicker('render');
                $('#listStatus').selectpicker('render');
                $('#modalFormComprobantes').modal('show');
            } else {
                swal("Error", objData.msg, "error");
            }
        }
    }
}
function fntDeltInfo(idAsiento) {
    swal({
        title: "Eliminar Información",
        text: "¿Realmente quiere eliminar esta información?",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, eliminar!",
        cancelButtonText: "No, cancelar!",
        closeOnConfirm: false,
        closeOnCancel: true
    }, function(isConfirm) {
        if (isConfirm) {
            // Crear una nueva instancia de XMLHttpRequest
            let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
            let ajaxUrl = base_url+'/Comprobantes/setDeleteComprobante';
            let strData = "idAsiento=" + idAsiento; 
            request.open("POST", ajaxUrl, true);
            request.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 
            request.send(strData);
            request.onreadystatechange = function() {
                if (request.readyState == 4 && request.status == 200) {
                    let objData = JSON.parse(request.responseText);
                    if (objData.status) {
                        swal("Eliminar!", objData.msg, "success");
                        tableComprobantes.api().ajax.reload(); 
                    } else {
                        swal("Atención!", objData.msg, "error");
                    }
                }
            }
        }
    });
}


document.addEventListener('DOMContentLoaded', function() {
    // Selecciona el botón para agregar filas y le añade un evento de click
    document.querySelector('#addRow').addEventListener('click', function() {
        // Obtiene los valores de los campos
        let codigoCuenta = document.querySelector('#txtCodigoCuenta').value;
        let nombreCuenta = document.querySelector('#txtNombreCuenta').value;
        let debe = document.querySelector('#txtDebe').value;
        let haber = document.querySelector('#txtHaber').value;
        let descripcion = document.querySelector('#txtDescripcion').value;

        // Verifica si todos los campos necesarios tienen valores
        if (!codigoCuenta || !nombreCuenta || !debe || !haber || !descripcion) {
            alert("Todos los campos son obligatorios");
            return;
        }

        // Crea una nueva fila en la tabla
        let tableBody = document.querySelector('#detalleBody');
        let rowCount = tableBody.rows.length + 1;
        let newRow = document.createElement('tr');

        newRow.innerHTML = `
            <td>${rowCount}</td>
            <td>${codigoCuenta}</td>
            <td>${nombreCuenta}</td>
            <td>${debe}</td>
            <td>${haber}</td>
            <td>${descripcion}</td>
            <td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Eliminar</button></td>
        `;

        // Añade la nueva fila al cuerpo de la tabla
        tableBody.appendChild(newRow);

        // Limpia los campos después de agregar la fila
        document.querySelector('#txtCodigoCuenta').value = '';
        document.querySelector('#txtNombreCuenta').value = '';
        document.querySelector('#txtDebe').value = '';
        document.querySelector('#txtHaber').value = '';
        document.querySelector('#txtDescripcion').value = '';

        // Actualiza los totales
        updateTotals();
    });
});

// Función para eliminar una fila
function removeRow(button) {
    let row = button.parentNode.parentNode;
    row.parentNode.removeChild(row);
    updateTotals();
}

// Función para actualizar los totales de "Debe" y "Haber"
function updateTotals() {
    let totalDebe = 0;
    let totalHaber = 0;
    document.querySelectorAll('#detalleBody tr').forEach(row => {
        totalDebe += parseFloat(row.cells[3].innerText) || 0;
        totalHaber += parseFloat(row.cells[4].innerText) || 0;
    });
    document.querySelector('#totalDebe').innerText = totalDebe.toFixed(2);
    document.querySelector('#totalHaber').innerText = totalHaber.toFixed(2);
}

