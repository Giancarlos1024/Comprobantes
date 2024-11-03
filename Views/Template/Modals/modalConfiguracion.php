<!-- Modal -->
<div class="modal fade" id="modalFormConfiguracion" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nueva Configuracion</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="formConfiguracion" name="formConfiguracion" class="form-horizontal">
          <input type="hidden" id="idConfigura" name="idConfigura" value="">
          <p class="text-primary">Todos los campos son obligatorios.</p>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtID">ID</label>
              <input type="text" class="form-control" id="txtID" name="txtID" required="">
            </div>
            <div class="form-group col-md-6">
              <label for="txtNit">NIT</label>
              <input type="text" class="form-control" id="txtNit" name="txtNit" required="">
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtRazonSocial">Razon Social</label>
              <input type="text" class="form-control valid validText" id="txtRazonSocial" name="txtRazonSocial" required="">
            </div>
            <div class="form-group col-md-6">
              <label for="txtNombreRepLegal">Nombre Rep. legal</label>
              <input type="text" class="form-control valid validText" id="txtNombreRepLegal" name="txtNombreRepLegal" required="">
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtDireccion">Direccion</label>
              <input type="text" class="form-control valid validNumber" id="txtDireccion" name="txtDireccion" required="" onkeypress="return controlTag(event);">
            </div>
            <div class="form-group col-md-3">
              <label for="txtFechainicio">Fecha Inicio</label>
              <input type="text" class="form-control valid" id="txtFechainicio" name="txtFechainicio" required="">
            </div>
            <div class="form-group col-md-3">
              <label for="txtFechafin">Fecha Fin</label>
              <input type="text" class="form-control valid" id="txtFechafin" name="txtFechafin" required="">
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="listStatus">Status</label>
              <select class="form-control selectpicker" id="listStatus" name="listStatus" required>
                <option value="1">Activo</option>
                <option value="2">Inactivo</option>
              </select>
            </div>
          </div>
          <div class="tile-footer">
            <button id="btnActionForm" class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i><span id="btnText">Guardar</span></button>&nbsp;&nbsp;&nbsp;
            <button class="btn btn-danger" type="button" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cerrar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalViewConfigura" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Datos de la Empresa</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <td>ID:</td>
              <td id="celIdconfigura"></td>
            </tr>
            <tr>
              <td>NIT:</td>
              <td id="celNit"></td>
            </tr>
            <tr>
              <td>Razon Social:</td>
              <td id="celrazonsocial"></td>
            </tr>
            <tr>
              <td>Nomb. Rep. Legal:</td>
              <td id="celreplegal"></td>
            </tr>
            <tr>
              <td>Direccion:</td>
              <td id="celdireccion"></td>
            </tr>
            <tr>
              <td>Fecha Inicio:</td>
              <td id="celfechainicio"></td>
            </tr>
            <tr>
              <td>Fecha Final:</td>
              <td id="celfechafinal"></td>
            </tr>
            <tr>
              <td>Estado:</td>
              <td id="estado"></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>