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

async function generatePDF(idAsiento) {
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = async function() {
        if (request.readyState == 4 && request.status == 200) {
            var objData = JSON.parse(request.responseText);
            if (objData.status) {
                // Cargar el PDF de fondo
                const existingPdfUrl = base_url + '/Assets/modelo_pdf_comprobantes.pdf';
                const existingPdfBytes = await fetch(existingPdfUrl).then(res => res.arrayBuffer());

                // Crear un nuevo documento PDF usando el PDF de fondo
                const pdfDoc = await PDFLib.PDFDocument.load(existingPdfBytes);
                const page = pdfDoc.getPage(0); // Usar la primera página como fondo

                // Extraer datos del objeto de respuesta para mayor claridad
                const {
                    idAsiento,
                    numeroasiento,
                    fechaAsiento,
                    conceptoOperacion,
                    tipocomprobante,
                    estadotransaccion,
                    idUsuarios,
                    status,
                    codigocuenta,
                    nombrecuenta,
                    debe,
                    haber,
                    descripcion
                } = objData.data;

                let fontBold;
                try {
                    // Usar Times-Bold de los valores estándar si está disponible
                    fontBold = await pdfDoc.embedFont(PDFLib.StandardFonts.TimesRoman);
                    if (!fontBold) {
                        throw new Error("TimesBold no está disponible");
                    }
                } catch (e) {
                    console.error("No se pudo cargar la fuente TimesBold, intentando con Helvetica", e);
                    try {
                        // Intentar con Helvetica si TimesBold falla
                        fontBold = await pdfDoc.embedFont(PDFLib.StandardFonts.Helvetica);
                    } catch (e) {
                        console.error("No se pudo cargar Helvetica", e);
                    }
                }

                // Verificar si se cargó una fuente
                if (!fontBold) {
                    console.error("No se pudo cargar ninguna fuente válida");
                    return;
                }
                
                const formattedDate = formatDate(fechaAsiento);
                page.drawText(`CONSULTORIA Y CONSTRUCCIONES ORELLANA`, { x: 22, y: 763, size: 12, font: fontBold  });
                page.drawText(`CHARLES!ORLANDO!ORELLANA!LUJAN`, { x: 37, y: 751, size: 8, font: fontBold  });
                page.drawText(`6412178014`, { x: 38, y: 742, size: 8, font: fontBold  });
                page.drawText(`Calle!Londres!S/N!Zona!!Sexta!Parte`, { x: 22, y: 732, size: 8, font: fontBold  });
                page.drawText(`COCHABAMBA`, { x: 22, y: 724, size: 8, font: fontBold  });


                // Agregar texto sobre el PDF de fondo en posiciones específicas
                page.drawText('BS. 6.96 x USD', { x: 487, y: 736, size: 10, font: fontBold });
                page.drawText(`${numeroasiento}`, { x: 485, y: 765, size: 10, font: fontBold  });
                page.drawText(`${formattedDate}`, { x: 475, y: 750, size: 10, font: fontBold  });
                page.drawText(`${conceptoOperacion}`, { x: 85, y: 688, size: 10 });
                page.drawText(`${tipocomprobante}`, { x: 305, y: 719, size: 13, font: fontBold  });

                // Agregar detalles de la cuenta
                page.drawText(`${codigocuenta}`, { x: 85, y: 625, size: 8 });
                page.drawText(`${nombrecuenta}`, { x: 130, y: 627, size: 6 });
                page.drawText(`${debe}`, { x: 463, y: 627, size: 8 });
                page.drawText(`${haber}`, { x: 530, y: 627, size: 8 });
                page.drawText(`${descripcion}`, { x: 130, y: 618, size: 7 });

                // Si 'debe' y 'haber' son valores individuales
                let totalDebe = parseFloat(debe) || 0;
                let totalHaber = parseFloat(haber) || 0;

                // Mostrar los totales en el PDF
                page.drawText(`CIEN 00/100 Bolivianos`, { x: 33, y: 138, size: 6, font: fontBold });
                page.drawText(`${totalDebe.toFixed(2)}`, { x: 463, y: 163, size: 8, font: fontBold });
                page.drawText(`${totalHaber.toFixed(2)}`, { x: 530, y: 163, size: 8, font: fontBold });

                // Guardar el PDF generado
                const pdfBytes = await pdfDoc.save();
                const blob = new Blob([pdfBytes], { type: "application/pdf" });
                const blobUrl = URL.createObjectURL(blob);

                // Abrir el PDF en una nueva pestaña
                window.open(blobUrl, '_blank');
            } else {
                swal("Error", objData.msg, "error");
            }
        }
    };
}

// Función para formatear la fecha en formato dd-mm-yyyy
function formatDate(dateString) {
    const date = new Date(dateString);
    const day = ("0" + date.getDate()).slice(-2);
    const month = ("0" + (date.getMonth() + 1)).slice(-2);
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
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
                // Limpiar el cuerpo de la tabla antes de agregar nuevos datos
                var tableBody = document.querySelector("#comprobanteDetailsBody");
                tableBody.innerHTML = '';

                // Mostrar los detalles principales
                var details = [
                    { label: "ID", value: objData.data.idAsiento },
                    { label: "NRO.CBTE", value: objData.data.numeroasiento },
                    { label: "FECHA", value: objData.data.fechaAsiento },
                    { label: "DETALLE", value: objData.data.conceptoOperacion },
                    { label: "TIPO CBTE", value: objData.data.tipocomprobante },
                    { label: "ESTADO", value: objData.data.estadotransaccion },
                    { label: "USUARIO", value: objData.data.idUsuarios },
                    { label: "STATUS", value: objData.data.status == 1 ? '<span class="badge badge-success">Activo</span>' : '<span class="badge badge-danger">Inactivo</span>' },
                    { label: "Código Cuenta", value: objData.data.codigocuenta },
                    { label: "Nombre Cuenta", value: objData.data.nombrecuenta },
                    { label: "Debe", value: objData.data.debe },
                    { label: "Haber", value: objData.data.haber },
                    { label: "Descripción Lidiario", value: objData.data.descripcion }
                ];

                // Agregar filas estáticas
                details.forEach(function(item) {
                    var row = document.createElement("tr");
                    row.innerHTML = "<td>" + item.label + ":</td><td>" + item.value + "</td>";
                    tableBody.appendChild(row);
                });

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


