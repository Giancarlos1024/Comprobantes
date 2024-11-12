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
                                    // Recargar la tabla de comprobantes
                                    $('#tableComprobantes').DataTable().ajax.reload();
                                    // Cerrar el modal y resetear el formulario
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
    
    // Limpiar las filas de la tabla de detalles
    let detalleBody = document.querySelector('#detalleBody');
    detalleBody.innerHTML = '';  // Elimina todas las filas de la tabla de detalles

    // Reiniciar los totales de "Debe" y "Haber"
    document.querySelector('#totalDebe').innerText = '0.00';
    document.querySelector('#totalHaber').innerText = '0.00';

    // Habilitar el campo de número de asiento al abrir el modal para crear uno nuevo
    document.querySelector("#txtNumeroAsiento").disabled = false;
    document.querySelector("#listStatus").disabled = false;

    // Mostrar el modal para crear el nuevo comprobante
    $('#modalFormComprobantes').modal('show');
}


function fntEditInfo(idAsiento) {
    document.querySelector('#titleModalUpdate').innerHTML = "Actualizar Comprobante";
    document.querySelector('.modal-header').classList.replace("headerRegister", "headerUpdate");
    document.querySelector('#btnActionFormUpdate').classList.replace("btn-primary", "btn-info");
    document.querySelector('#btnTextUpdate').innerHTML = "Actualizar";
    
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function() {
        if (request.readyState == 4 && request.status == 200) {
            var objData = JSON.parse(request.responseText);
            if (objData.status) {
                var data = objData.data;
                var mainData = data[0];
                
                document.querySelector("#txtNumeroAsientoUpdate").value = mainData.numeroasiento;
                document.querySelector("#txtFechaAsientoUpdate").value = mainData.fechaAsiento;
                document.querySelector("#txtConceptoOperacionUpdate").value = mainData.conceptoOperacion;
                document.querySelector("#listComprobanteUpdate").value = mainData.tipocomprobante;
                document.querySelector("#listStatusUpdate").value = mainData.status;

                document.querySelector("#txtNumeroAsientoUpdate").disabled = true;
                document.querySelector("#listStatusUpdate").disabled = true;

                var lidiarioTableBody = document.querySelector("#detalleBodyUpdate");
                lidiarioTableBody.innerHTML = '';

                data.forEach(function(ld, index) {
                    var row = document.createElement("tr");
                    row.innerHTML = `
                        <td>${index + 1}</td>
                        <td>${ld.codigocuenta}</td>
                        <td>${ld.nombrecuenta}</td>
                        <td><input type="text" class="form-control debe-input" value="${ld.debe}"></td>
                        <td><input type="text" class="form-control haber-input" value="${ld.haber}"></td>
                        <td><input type="text" class="form-control" value="${ld.descripcion}"></td>
                    `;
                    lidiarioTableBody.appendChild(row);
                });

                // Agregar eventos de cambio a los inputs de debe y haber
                document.querySelectorAll('.debe-input, .haber-input').forEach(function(input) {
                    input.addEventListener('input', calculateTotalsUpdate);
                });

                calculateTotalsUpdate();

                $('#modalFormComprobantesUpdate').modal('show');
            } else {
                swal("Error", objData.msg, "error");
            }
        }
    }
}

function calculateTotalsUpdate() {
    var totalDebe = 0;
    var totalHaber = 0;

    document.querySelectorAll('#detalleBodyUpdate tr').forEach(function(row) {
        var debe = parseFloat(row.cells[3].querySelector('input').value) || 0;
        var haber = parseFloat(row.cells[4].querySelector('input').value) || 0;
        totalDebe += debe;
        totalHaber += haber;
    });

    document.querySelector('#totalDebeUpdate').textContent = totalDebe.toFixed(2);
    document.querySelector('#totalHaberUpdate').textContent = totalHaber.toFixed(2);
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
            <select name="nombreCuenta[]" class="form-control" id="nombreCuentaSelect${existingRows.length}" disabled>
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

function removeRow(button) {
    let row = button.parentNode.parentNode;
    row.parentNode.removeChild(row);
    updateTotals();
}

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

                console.log('Datos recibidos:', data);

                // Eliminar duplicados
                let uniqueData = [...new Map(data.map(item => [item.codigocuenta, item])).values()];

                console.log('Datos únicos:', uniqueData);

                let codigoSelect = document.getElementById(`codigoCuentaSelect${rowIndex}`);
                let nombreSelect = document.getElementById(`nombreCuentaSelect${rowIndex}`);
                
                uniqueData.forEach(cuenta => {
                    let codigoOption = document.createElement('option');
                    codigoOption.value = cuenta.codigocuenta;
                    codigoOption.text = cuenta.codigocuenta;
                    codigoSelect.appendChild(codigoOption);
                });

                // Guardar datos en el select para usarlos posteriormente
                codigoSelect.dataset.cuentas = JSON.stringify(uniqueData);

                // Añadir evento para actualizar nombreCuenta automáticamente
                codigoSelect.addEventListener('change', function() {
                    updateNombreCuenta(rowIndex);
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
    console.log(`Código seleccionado (row ${rowIndex}):`, selectedCodigo);
    
    let data = JSON.parse(codigoSelect.dataset.cuentas); // Obtener los datos guardados
    console.log('Datos para la actualización:', data);

    const cuenta = data.find(item => item.codigocuenta == selectedCodigo); // Utilizar '==' para comparar valores numéricos y cadenas
    console.log('Cuenta encontrada:', cuenta);

    if (cuenta) {
        nombreSelect.innerHTML = `<option value="${cuenta.nombrecuenta}">${cuenta.nombrecuenta}</option>`;
        nombreSelect.disabled = false; // Habilitar el select de nombre de cuenta
        console.log(`Nombre de cuenta actualizado (row ${rowIndex}):`, cuenta.nombrecuenta);
    } else {
        nombreSelect.innerHTML = '<option value="">Selecciona Nombre de Cuenta</option>';
        nombreSelect.disabled = true; // Deshabilitar el select de nombre de cuenta si no se encuentra
        console.log(`Nombre de cuenta no encontrado para el código (row ${rowIndex}):`, selectedCodigo);
    }
}



// Función para convertir un número en letras (simplificado)
function numeroALetras(num) {
    const unidades = ["", "UN", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE"];
    const decenas = ["", "", "VEINTE", "TREINTA", "CUARENTA", "CINCUENTA", "SESENTA", "SETENTA", "OCHENTA", "NOVENTA"];
    const especiales = ["DIEZ", "ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE", "DIECISEIS", "DIECISIETE", "DIECIOCHO", "DIECINUEVE"];
    const centenas = ["", "CIENTO", "DOSCIENTOS", "TRESCIENTOS", "CUATROCIENTOS", "QUINIENTOS", "SEISCIENTOS", "SETECIENTOS", "OCHOCIENTOS", "NOVECIENTOS"];
    const miles = ["", "MIL"];

    if (num === 100) return "CIEN"; // Para el número 100
    if (num < 10) return unidades[num];
    if (num < 20) return especiales[num - 10];
    if (num < 100) {
        const unidad = num % 10;
        return `${decenas[Math.floor(num / 10)]}${unidad ? " Y " + unidades[unidad] : ""}`;
    }
    if (num < 1000) {
        const decena = num % 100;
        const centena = Math.floor(num / 100);
        return `${centenas[centena]}${decena ? " " + numeroALetras(decena) : ""}`;
    }
    if (num < 100000) {
        const mil = Math.floor(num / 1000);
        const resto = num % 1000;
        return `${numeroALetras(mil)} MIL${resto ? " " + numeroALetras(resto) : ""}`;
    }
    // Agregar más casos si es necesario (para números más grandes)
    return "";
}

function convertirMontoALetras(monto) {
    const enteros = Math.floor(monto);
    const decimales = Math.round((monto - enteros) * 100);  // Asegurarse de que los decimales sean 2 dígitos
    const parteEnteraEnLetras = numeroALetras(enteros);

    // Si el monto es entero y no tiene decimales, poner '00/100'
    const decimalesTexto = decimales < 10 ? `0${decimales}` : decimales.toString();

    return `${parteEnteraEnLetras} ${decimalesTexto}/100 Bolivianos`;
}


async function generatePDF(idAsiento) {
    try {
        // Obtener configuración de la empresa
        const empresaData = await fetchEmpresaConfig();

        // Solicitud para obtener el comprobante
        const request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
        const ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
        request.open("GET", ajaxUrl, true);
        request.send();

        request.onreadystatechange = async function() {
            if (request.readyState == 4 && request.status == 200) {
                const objData = JSON.parse(request.responseText);
                if (objData.status) {
                    // Cargar PDF base y configurar
                    const existingPdfUrl = base_url + '/Assets/pdf_actualizado.pdf';
                    const existingPdfBytes = await fetch(existingPdfUrl).then(res => res.arrayBuffer());
                    const pdfDoc = await PDFLib.PDFDocument.load(existingPdfBytes);
                    const page = pdfDoc.getPage(0);

                    // Fuente
                    const fontBold = await pdfDoc.embedFont(PDFLib.StandardFonts.Helvetica);

                    // Datos de empresa
                    const { direccion, nit, nombrereplegal, razonsocial } = empresaData[0];
                    page.drawText(`${razonsocial}`, { x: 22, y: 763, size: 12, font: fontBold });
                    page.drawText(`${nombrereplegal}`, { x: 37, y: 751, size: 8, font: fontBold });
                    page.drawText(`${nit}`, { x: 38, y: 742, size: 8, font: fontBold });
                    page.drawText(`${direccion}`, { x: 22, y: 732, size: 8, font: fontBold });

                    // Datos del comprobante
                    const firstComprobante = objData.data[0];
                    const { numeroasiento, fechaAsiento, conceptoOperacion, tipocomprobante } = firstComprobante;
                    const formattedDate = formatDate(fechaAsiento);

                    page.drawText(`${numeroasiento}`, { x: 485, y: 764, size: 9, font: fontBold });
                    page.drawText(`${formattedDate}`, { x: 475, y: 750, size: 9, font: fontBold });
                    page.drawText(` BS. 6.96 x USD`, { x: 485, y: 736, size: 9, font: fontBold });
                    page.drawText(`${conceptoOperacion}`, { x: 85, y: 686, size: 10 });
                    page.drawText(`${tipocomprobante}`, { x: 303, y: 720, size: 12, font: fontBold });

                    // Detalles del comprobante
                    let yOffset = 665;
                    objData.data.forEach((comprobante) => {
                        const { codigocuenta, nombrecuenta, debe, haber, descripcion } = comprobante;
                        page.drawText(`${codigocuenta}`, { x: 85, y: yOffset - 45, size: 8 });
                        page.drawText(`${nombrecuenta}`, { x: 130, y: yOffset - 43, size: 6 });
                        page.drawText(`${debe}`, { x: 463, y: yOffset - 43, size: 8 });
                        page.drawText(`${haber}`, { x: 530, y: yOffset - 43, size: 8 });
                        page.drawText(`${descripcion}`, { x: 130, y: yOffset - 52, size: 7 });
                        yOffset -= 20;
                    });

                    // Totales
                    let totalDebe = 0, totalHaber = 0;
                    objData.data.forEach((comprobante) => {
                        totalDebe += parseFloat(comprobante.debe) || 0;
                        totalHaber += parseFloat(comprobante.haber) || 0;
                    });

                    // Convertir los totales a letras
                    const totalDebeEnLetras = convertirMontoALetras(totalDebe);
                    const totalHaberEnLetras = convertirMontoALetras(totalHaber);

                    // Agregar los totales en letras en el PDF
                    page.drawText(totalDebeEnLetras, { x: 33, y: 135.5, size: 7, font: fontBold });  // Total 'Debe' en letras
                    // page.drawText(totalHaberEnLetras, { x: 33, y: 125.5, size: 7, font: fontBold }); // Total 'Haber' en letras

                    // Agregar los totales numéricos en el PDF
                    page.drawText(`${totalDebe.toFixed(2)}`, { x: 463, y: 163, size: 8, font: fontBold });
                    page.drawText(`${totalHaber.toFixed(2)}`, { x: 530, y: 163, size: 8, font: fontBold });

                    // Guardar el PDF generado
                    const pdfBytes = await pdfDoc.save();
                    const blob = new Blob([pdfBytes], { type: "application/pdf" });
                    const blobUrl = URL.createObjectURL(blob);
                    window.open(blobUrl, '_blank');
                } else {
                    swal("Error", objData.msg, "error");
                }
            }
        };
    } catch (error) {
        console.error("Error al generar el PDF:", error);
        swal("Error", "No se pudo obtener la configuración de la empresa.", "error");
    }
}

// Función para formatear la fecha en formato dd-mm-yyyy
function formatDate(dateString) {
    const date = new Date(dateString);
    const day = ("0" + date.getDate()).slice(-2);
    const month = ("0" + (date.getMonth() + 1)).slice(-2);
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
}


async function fetchEmpresaConfig() {
    const request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    const ajaxUrl = base_url + '/Comprobantes/getConfiguraEmpresa';
    request.open("GET", ajaxUrl, true);
    request.send();

    return new Promise((resolve, reject) => {
        request.onreadystatechange = function() {
            if (request.readyState == 4 && request.status == 200) {
                const objData = JSON.parse(request.responseText);
                if (objData.status) {
                    resolve(objData.data);
                } else {
                    reject("No se pudo obtener la configuración de la empresa.");
                }
            }
        };
    });
}



function fntViewInfo(idAsiento) {
    var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    var ajaxUrl = base_url + '/Comprobantes/getComprobante/' + idAsiento;
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function() {
        if (request.readyState == 4 && request.status == 200) {
            var objData = JSON.parse(request.responseText);
            console.log(objData);  // Verifica la respuesta del servidor

            if (objData.status) {
                // Limpiar los cuerpos de las tablas antes de agregar nuevos datos
                var mainTableBody = document.querySelector("#comprobanteMainDetails");
                var lidiarioTableBody = document.querySelector("#comprobanteLidiarioDetails");
                mainTableBody.innerHTML = '';
                lidiarioTableBody.innerHTML = '';

                // Mostrar los detalles principales
                var details = [
                    { label: "ID", value: objData.data[0].idAsiento },
                    { label: "NRO.CBTE", value: objData.data[0].numeroasiento },
                    { label: "FECHA", value: objData.data[0].fechaAsiento },
                    { label: "DETALLE", value: objData.data[0].conceptoOperacion },
                    { label: "TIPO CBTE", value: objData.data[0].tipocomprobante },
                    { label: "ESTADO", value: objData.data[0].estadotransaccion },
                    { label: "USUARIO", value: objData.data[0].idUsuarios },
                    { label: "STATUS", value: objData.data[0].status == 1 ? '<span class="badge badge-success">Activo</span>' : '<span class="badge badge-danger">Inactivo</span>' }
                ];

                // Agregar filas estáticas para los detalles principales
                details.forEach(function(item) {
                    var row = document.createElement("tr");
                    row.innerHTML = "<td><strong>" + item.label + ":</strong></td><td>" + item.value + "</td>";
                    mainTableBody.appendChild(row);
                });

                // Verificar si hay registros en lidiario
                if (Array.isArray(objData.data)) {
                    objData.data.forEach(function(ld) {
                        // Crear una fila con los datos de cada registro de lidiario
                        var row = document.createElement("tr");
                        row.innerHTML = `
                            <td>${ld.codigocuenta}</td>
                            <td>${ld.nombrecuenta}</td>
                            <td>${ld.debe}</td>
                            <td>${ld.haber}</td>
                            <td>${ld.descripcion}</td>
                        `;
                        lidiarioTableBody.appendChild(row);
                    });
                } else {
                    // Si no hay registros de lidiario, muestra un mensaje
                    var row = document.createElement("tr");
                    row.innerHTML = "<td colspan='5'>No hay registros de Lidiario disponibles.</td>";
                    lidiarioTableBody.appendChild(row);
                }

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

