<div class="modal fade" id="modalFormComprobantes" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Comprobante</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="formComprobantes" name="formComprobantes" class="form-horizontal">
          
          
          <p class="text-primary">Todos los campos son obligatorios.</p>
          <div class="form-row">
            <div class="form-group col-md-2">
              <label for="txtNumeroAsiento">Número Asiento</label>
              <input type="text" class="form-control" id="txtNumeroAsiento" name="txtNumeroAsiento" required="">
            </div>
            <div class="form-group col-md-3">
              <label for="txtFechaAsiento">Fecha Asiento</label>
              <input type="date" class="form-control" id="txtFechaAsiento" name="txtFechaAsiento" required="">
            </div>
            <div class="form-group col-md-3">
              <label for="listComprobante">Tipo de Comprobante</label>
              <select class="form-control" id="listComprobante" name="listComprobante" required>
                <option value="INGRESO">Ingreso</option>
                <option value="EGRESO">Egreso</option>
                <option value="TRASPASO">Traspaso</option>
                <option value="DIARIO">Diario</option>
              </select>
            </div>
            <div class="form-group col-md-3">
              <label for="listStatus">Estado</label>
              <select class="form-control" id="listStatus" name="listStatus" required>
                <option value="1">Activo</option>
                <option value="2">Inactivo</option>
              </select>
            </div>
            <div class="form-group col-md-12">
              <label for="txtConceptoOperacion">Concepto Operación</label>
              <input type="text" class="form-control" id="txtConceptoOperacion" name="txtConceptoOperacion" required="">
            </div>
          </div>
          <div class="table-responsive mt-4">
            <table class="table table-bordered" id="detalleTable">
              <thead class="thead-dark">
                <tr>
                  <th>Nro. Fila</th>
                  <th>Código Cuenta</th>
                  <th>Nombre Cuenta</th>
                  <th>Debe</th>
                  <th>Haber</th>
                  <th>Descripción</th>
                  <th>Acción</th>
                </tr>
              </thead>
              <tbody id="detalleBody">  
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="3" class="text-right"><strong>Totales:</strong></td>
                  <td id="totalDebe">0.00</td>
                  <td id="totalHaber">0.00</td>
                  <!-- <div id="alertMessage" style="display:none; color: red;"></div> -->
                  <td colspan="2"></td>
                </tr>
              </tfoot>
            </table>
          </div>
          <button type="button" class="btn btn-success" id="addRow">Agregar Fila</button>
          <div class="tile-footer mt-3">
            <button id="btnActionForm" class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i><span id="btnText">Guardar</span></button>&nbsp;&nbsp;&nbsp;
            <button class="btn btn-danger" type="button" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cerrar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="modalViewComprobante" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Detalles del Comprobante</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody id="comprobanteDetailsBody">
            <!-- Aquí se agregarán las filas dinámicamente -->
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf-lib/1.17.1/pdf-lib.min.js"></script>
