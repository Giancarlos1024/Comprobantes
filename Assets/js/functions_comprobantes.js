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
    console.log("Iniciando DataTable...");
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
            { "data": "fechaAsiento" },
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
            // Verificar si los totales de debe y haber son iguales
            let totalDebe = parseFloat(document.querySelector('#totalDebe').innerText);
            let totalHaber = parseFloat(document.querySelector('#totalHaber').innerText);

            if (totalDebe !== totalHaber) {
                swal("Advertencia", "Los totales de 'Debe' y 'Haber' no son iguales. Por favor, verifica los valores antes de guardar.", "warning");
                return false;  // Detener el envío del formulario
            }

            // Ocultar mensaje de advertencia si los totales son iguales
            // document.querySelector('#alertMessage').style.display = 'none';

            let strNumeroAsiento = document.querySelector('#txtNumeroAsiento').value;
            let strFechaAsiento = document.querySelector('#txtFechaAsiento').value;
            let strTipoComprobante = document.querySelector('#listComprobante').value;
            let intEstadoTransaccion = document.querySelector('#listStatus').value;
            let strConceptoOperacion = document.querySelector('#txtConceptoOperacion').value;
            let intIdUsuario = loggedUserId;

            if (!strNumeroAsiento || !intEstadoTransaccion || !strFechaAsiento || !strConceptoOperacion || !strTipoComprobante || !intIdUsuario) {
                console.error("Error: Todos los campos son obligatorios.");
                swal("Atención", "Todos los campos son obligatorios.", "error");
                return false;
            }

            divLoading.style.display = "flex";
            let request = new XMLHttpRequest();
            let ajaxUrl = base_url + '/Comprobantes/setComprobante';
            let formData = new FormData(formComprobante);
            let rows = document.querySelectorAll('#detalleBody tr');
            rows.forEach((row, index) => {
                const codigoCuenta = row.querySelector('select[name="codigoCuenta[]"]').value || "";
                const nombreCuenta = row.querySelector('select[name="nombreCuenta[]"]').value || "";
                const debe = row.querySelector('input[name="debe[]"]').value || "0";
                const haber = row.querySelector('input[name="haber[]"]').value || "0";
                const descripcion = row.querySelector('input[name="descripcion[]"]').value || "";

                if (codigoCuenta) formData.append(`codigoCuenta[]`, codigoCuenta);
                if (nombreCuenta) formData.append(`nombreCuenta[]`, nombreCuenta);
                if (debe) formData.append(`debe[]`, debe);
                if (haber) formData.append(`haber[]`, haber);
                if (descripcion) formData.append(`descripcion[]`, descripcion);
            });
            formData.append('idUsuario', intIdUsuario); // Agregar ID de usuario
            request.open("POST", ajaxUrl, true);
            request.send(formData);
            request.onreadystatechange = function() {
                if (request.readyState === 4) {
                    divLoading.style.display = "none";
                    if (request.status >= 200 && request.status < 300) {
                        try {
                            let objData = JSON.parse(request.responseText);
                            if (objData && typeof objData === "object" && objData.hasOwnProperty("status")) {
                                if (objData.status) {
                                    $('#tableComprobantes').DataTable().ajax.reload();
                                    $('#modalFormComprobantes').modal("hide");
                                    formComprobante.reset();
                                    swal("Comprobante", objData.message || "Comprobante guardado exitosamente.", "success");
                                } else {
                                    swal("Atención", objData.msg || "Hubo un problema al procesar su solicitud.", "error");
                                }
                            }
                        } catch (error) {
                            swal("Error", "Error al procesar la respuesta del servidor.", "error");
                        }
                    } else {
                        swal("Error", "Ha ocurrido un error en la solicitud. Inténtelo de nuevo.", "error");
                    }
                }
            };
        }
    }
}, false);

function openModal() {
    document.querySelector('.modal-header').classList.replace("headerUpdate", "headerRegister");
    document.querySelector('#btnActionForm').classList.replace("btn-info", "btn-primary");
    document.querySelector('#btnText').innerHTML = "Guardar";
    document.querySelector('#titleModal').innerHTML = "Nuevo comprobante";
    document.querySelector("#formComprobantes").reset();
    
    // Habilitar el campo de número de asiento al abrir el modal para crear uno nuevo
    document.querySelector("#txtNumeroAsiento").disabled = false;
    document.querySelector("#listStatus").disabled = false;

    $('#modalFormComprobantes').modal('show');
}

// function fntViewInfo(idAsiento) {
//     var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
//     var ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
//     request.open("GET", ajaxUrl, true);
//     request.send();
//     request.onreadystatechange = function() {
//         if (request.readyState == 4 && request.status == 200) {
//             var objData = JSON.parse(request.responseText);
//             if (objData.status) {
//                 document.querySelector("#celIdComprobante").innerHTML = objData.data.idAsiento;
//                 document.querySelector("#celNumeroAsiento").innerHTML = objData.data.numeroasiento;
//                 document.querySelector("#celFechaAsiento").innerHTML = objData.data.fechaAsiento;
//                 document.querySelector("#celDetalle").innerHTML = objData.data.conceptoOperacion;
//                 document.querySelector("#celTipoComprobante").innerHTML = objData.data.tipocomprobante;
//                 document.querySelector("#celEstadoTransaccion").innerHTML = objData.data.estadotransaccion;
//                 document.querySelector("#celUsuario").innerHTML = objData.data.idUsuarios;
//                 document.querySelector("#celStatus").innerHTML = objData.data.status == 1 ? '<span class="badge badge-success">Activo</span>' : '<span class="badge badge-danger">Inactivo</span>';
//                 document.querySelector("#celDebe").innerHTML = objData.data.debe;
//                 document.querySelector("#celHaber").innerHTML = objData.data.haber;
//                 document.querySelector("#celDescripcionLidiario").innerHTML = objData.data.descripcion;
//                 document.querySelector("#celCodigoCuenta").innerHTML = objData.data.codigocuenta;
//                 document.querySelector("#celNombreCuenta").innerHTML = objData.data.nombrecuenta;

//                 $('#modalViewComprobante').modal('show');
//             } else {
//                 swal("Error", objData.msg, "error");
//             }
//         }
//     }
// }
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
                document.querySelector("#txtNumeroAsiento").value = objData.data.numeroasiento;
                document.querySelector("#txtFechaAsiento").value = objData.data.fechaAsiento;
                document.querySelector("#txtConceptoOperacion").value = objData.data.conceptoOperacion;
                document.querySelector("#listComprobante").value = objData.data.tipocomprobante;
                document.querySelector("#listStatus").value = objData.data.status;   

                // Deshabilitar el campo de número de asiento
                document.querySelector("#txtNumeroAsiento").disabled = true; 
                document.querySelector("#listStatus").disabled = true;

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

document.querySelector('#addRow').addEventListener('click', function() {
    let tableBody = document.querySelector('#detalleBody');
    let existingRows = tableBody.querySelectorAll('tr');
    
    let newRow = document.createElement('tr');
    newRow.innerHTML = `
        <td>${existingRows.length + 1}</td>
        <td>
            <select name="codigoCuenta[]" class="form-control" id="codigoCuentaSelect${existingRows.length}" onchange="updateNombreCuenta(${existingRows.length})">
                <option value="">Selecciona Código de Cuenta</option>
            </select>
        </td>
        <td>
            <select name="nombreCuenta[]" class="form-control" id="nombreCuentaSelect${existingRows.length}">
                <option value="">Selecciona Nombre de Cuenta</option>
            </select>
        </td>
        <td><input type="number" name="debe[]" class="form-control" placeholder="Debe" step="0.01" oninput="updateTotals()"></td>
        <td><input type="number" name="haber[]" class="form-control" placeholder="Haber" step="0.01" oninput="updateTotals()"></td>
        <td><input type="text" name="descripcion[]" class="form-control" placeholder="Descripción"></td>
        <td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Eliminar</button></td>
    `;

    tableBody.appendChild(newRow);
    loadCuentaOptions(existingRows.length);
    updateTotals();
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
        totalDebe += parseFloat(row.querySelector('[name="debe[]"]').value) || 0;
        totalHaber += parseFloat(row.querySelector('[name="haber[]"]').value) || 0;
    });
    document.querySelector('#totalDebe').innerText = totalDebe.toFixed(2);
    document.querySelector('#totalHaber').innerText = totalHaber.toFixed(2);
}


function loadCuentaOptions(rowIndex) {
    var request = new XMLHttpRequest();
    var ajaxUrl = base_url + '/Comprobantes/getPlanCuentas'; // Cambia a la ruta correspondiente en tu proyecto
    request.open("GET", ajaxUrl, true);
    request.send();

    request.onreadystatechange = function() {
        if (request.readyState === 4) {
            if (request.status === 200) {
                let data = JSON.parse(request.responseText);
                let codigoSelect = document.getElementById(`codigoCuentaSelect${rowIndex}`);
                let nombreSelect = document.getElementById(`nombreCuentaSelect${rowIndex}`);
                
                data.forEach(cuenta => {
                    let codigoOption = document.createElement('option');
                    codigoOption.value = cuenta.codigocuenta;
                    codigoOption.text = cuenta.codigocuenta;
                    codigoSelect.appendChild(codigoOption);
                
                    let nombreOption = document.createElement('option');
                    nombreOption.value = cuenta.nombrecuenta;
                    nombreOption.text = cuenta.nombrecuenta;
                    nombreSelect.appendChild(nombreOption);
                });
            } else {
                console.error('Error al cargar cuentas:', request.statusText);
            }
        }
    };
}


function updateNombreCuenta(rowIndex) {
    let codigoSelect = document.getElementById(`codigoCuentaSelect${rowIndex}`);
    let nombreSelect = document.getElementById(`nombreCuentaSelect${rowIndex}`);
    let selectedCodigo = codigoSelect.value;

    var request = new XMLHttpRequest();
    var ajaxUrl = base_url + '/Comprobantes/getPlanCuentas';
    request.open("GET", ajaxUrl, true);
    request.send();

    request.onreadystatechange = function() {
        if (request.readyState === 4) {
            if (request.status === 200) {
                let data = JSON.parse(request.responseText);
                const cuenta = data.find(item => item.codigocuenta === selectedCodigo);
                if (cuenta) {
                    nombreSelect.value = cuenta.nombrecuenta;
                } else {
                    nombreSelect.value = '';
                }
            } else {
                console.error('Error al actualizar nombre de cuenta:', request.statusText);
            }
        }
    };
}


function generatePDF(idAsiento) {
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function() {
        if (request.readyState == 4 && request.status == 200) {
            var objData = JSON.parse(request.responseText);
            if (objData.status) {
                // Crear un nuevo documento PDF
                const { jsPDF } = window.jspdf;
                const doc = new jsPDF();

                // Agregar contenido al PDF
                doc.text('Detalles del Comprobante', 10, 10);
                doc.text(`ID: ${objData.data.idAsiento}`, 10, 20);
                doc.text(`Número de Comprobante: ${objData.data.numeroasiento}`, 10, 30);
                doc.text(`Fecha: ${objData.data.fechaAsiento}`, 10, 40);
                doc.text(`Detalle: ${objData.data.conceptoOperacion}`, 10, 50);
                doc.text(`Tipo Comprobante: ${objData.data.tipocomprobante}`, 10, 60);
                doc.text(`Estado: ${objData.data.estadotransaccion}`, 10, 70);
                doc.text(`Usuario: ${objData.data.idUsuarios}`, 10, 80);
                doc.text(`Status: ${objData.data.status == 1 ? 'Activo' : 'Inactivo'}`, 10, 90);

                // Agregar detalles de las cuentas
                doc.text(`Código Cuenta: ${objData.data.codigocuenta}`, 10, 100);
                doc.text(`Nombre Cuenta: ${objData.data.nombrecuenta}`, 10, 110);
                doc.text(`Debe: ${objData.data.debe}`, 10, 120);
                doc.text(`Haber: ${objData.data.haber}`, 10, 130);
                doc.text(`Descripción: ${objData.data.descripcion}`, 10, 140);

                // Generar el archivo PDF
                doc.save(`Comprobante_${idAsiento}.pdf`);
            } else {
                swal("Error", objData.msg, "error");
            }
        }
    };
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
                // Mostrar los detalles en el modal
                document.querySelector("#celIdComprobante").innerHTML = objData.data.idAsiento;
                document.querySelector("#celNumeroAsiento").innerHTML = objData.data.numeroasiento;
                document.querySelector("#celFechaAsiento").innerHTML = objData.data.fechaAsiento;
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

                // Mostrar el modal
                $('#modalViewComprobante').modal('show');

                // Eliminar el botón PDF anterior si existe
                var existingButton = document.querySelector("#btnDownloadPDF");
                if (existingButton) {
                    existingButton.remove();
                }

                // Crear un nuevo botón para generar el PDF
                const pdfButton = document.createElement('button');
                pdfButton.id = "btnDownloadPDF";  // Agregar un ID al botón para evitar duplicación
                pdfButton.classList.add('btn', 'btn-danger');
                pdfButton.innerHTML = '<i class="fas fa-file-pdf"></i> Descargar PDF';
                pdfButton.addEventListener('click', () => generatePDF(idAsiento));

                // Agregar el botón al modal
                document.querySelector('.modal-footer').appendChild(pdfButton);
            } else {
                swal("Error", objData.msg, "error");
            }
        }
    }
}

