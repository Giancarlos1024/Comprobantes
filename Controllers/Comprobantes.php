<?php
class Comprobantes extends Controllers
{
	private $comprobantesModel; // Instancia de ComprobantesModel
    public function __construct()
    {
        parent::__construct();
        $this->comprobantesModel = new ComprobantesModel(); // Inicializar el modelo
        session_start();
        if (empty($_SESSION['login'])) {
            header('Location: ' . base_url() . '/login');
        }
        getPermisos(5);
    }
	public function Comprobantes()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Comprobantes";
		$data['page_name'] = "comprobantes";
		$data['page_title'] = "Comprobantes <small> Sistema Web Contable</small>";
		$data['page_functions_js'] = "functions_comprobantes.js";
		$this->views->getView($this, "comprobantes", $data);
	}
	public function getComprobantes()
	{
		$arrData = $this->model->selectComprobantes();
		for ($i = 0; $i < count($arrData); $i++) {
			$btnView = '';
			$btnEdit = '';
			$btnDelete = '';
			if ($arrData[$i]['status'] == 1) {
				$arrData[$i]['status'] = '<span class="badge badge-success">Activo</span>';
			} else {
				$arrData[$i]['status'] = '<span class="badge badge-danger">Inactivo</span>';
			}
			if ($_SESSION['permisosMod']['r']) {
				$btnView = '<button class="btn btn-secondary btn-sm" onClick="fntViewInfo(' . $arrData[$i]['idAsiento'] . ')" title="Ver Comprobante"><i class="fas fa-eye"></i></button>';
			}
			if ($_SESSION['permisosMod']['u']) {
				$btnEdit = '<button class="btn btn-primary btn-sm" onClick="fntEditInfo(' . $arrData[$i]['idAsiento'] . ')" title="Editar Comprobante"><i class="fas fa-pencil-alt"></i></button>';
			}
			if ($_SESSION['permisosMod']['d']) {
				$btnDelete = '<button class="btn btn-danger btn-sm" onClick="fntDeltInfo(' . $arrData[$i]['idAsiento'] . ')" title="Eliminar Comprobante"><i class="fas fa-trash-alt"></i></button>';
			}
			$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
		}
		echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		die();
	}
	public function getComprobante($idAsiento)
	{
		$arrData = $this->model->selectComprobante($idAsiento);
		
		if (empty($arrData)) {
			$arrResponse = array('status' => false, 'msg' => 'Comprobante no encontrado.');
		} else {
			// Puedes procesar $arrData si necesitas estructurarlo de una forma específica
			$arrResponse = array('status' => true, 'data' => $arrData);
		}
		echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		die();
	}
	public function getConfigura($idconfigura)
	{
		$intConfigura = intval($idconfigura);
		$arrData = $this->model->selectConfigura($intConfigura);
		if ($intConfigura > 0) {
			$arrData = $this->model->selectConfigura($intConfigura);
			if (empty($arrData)) {
				$arrResponse = array('status' => false, 'msg' => 'Datos no encontrados.');
			} else {
				$arrResponse = array('status' => true, 'data' => $arrData);
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}  // el objeto json sera enviado al archivo JS
		die();
	}
	public function setConfigura()
	{
		if ($_POST) {
			// Validación de entradas
			$requiredFields = ['txtNit', 'txtRazonSocial', 'txtNombreRepLegal', 'txtDireccion', 'txtFechainicio', 'txtFechafin', 'listStatus'];
			foreach ($requiredFields as $field) {
				if (empty($_POST[$field])) {
					echo json_encode(array("status" => false, "msg" => 'Faltan datos: ' . $field));
					die();
				}
			}
			$idUsuario = intval($_POST['idUsuario']);
			$strIdentificacion = strClean($_POST['txtIdentificacion']);
			$strNombre = ucwords(strClean($_POST['txtNombre']));
			$strApellido = ucwords(strClean($_POST['txtApellido']));
			$intTelefono = intval(strClean($_POST['txtTelefono']));
			$strEmail = strtolower(strClean($_POST['txtEmail']));
			$strNit = strClean($_POST['txtNit']);
			$strNomFiscal = strClean($_POST['txtNombreFiscal']);
			$strDirFiscal = strClean($_POST['txtDirFiscal']);
			$intTipoId = 7;

			// Guardar o actualizar usuario
			if ($idUsuario == 0) {
				$option = 1;
				$strPassword = empty($_POST['txtPassword']) ? passGenerator() : $_POST['txtPassword'];
				$strPasswordEncript = hash("SHA256", $strPassword);
				$request_user = $this->model->insertCliente(
					$strIdentificacion,
					$strNombre,
					$strApellido,
					$intTelefono,
					$strEmail,
					$strPasswordEncript,
					$intTipoId,
					$strNit,
					$strNomFiscal,
					$strDirFiscal
				);
			} else {
				$option = 2;
				$strPassword = empty($_POST['txtPassword']) ? "" : hash("SHA256", $_POST['txtPassword']);
				$request_user = $this->model->updateCliente(
					$idUsuario,
					$strIdentificacion,
					$strNombre,
					$strApellido,
					$intTelefono,
					$strEmail,
					$strPassword,
					$strNit,
					$strNomFiscal,
					$strDirFiscal
				);
			}
			// Respuesta
			if ($request_user > 0) {
				$arrResponse = array('status' => true, 'msg' => $option == 1 ? 'Datos guardados correctamente.' : 'Datos Actualizados correctamente.');
				if ($option == 1) {
					$nombreUsuario = $strNombre . ' ' . $strApellido;
					$dataUsuario = array(
						'nombreUsuario' => $nombreUsuario,
						'email' => $strEmail,
						'password' => $strPassword,
						'asunto' => 'Bienvenido a tu tienda en línea'
					);
					sendEmail($dataUsuario, 'email_bienvenida');
				}
			} else if ($request_user == 'exist') {
				$arrResponse = array('status' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');
			} else {
				$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
	public function setComprobante() {
		// Validación de campos requeridos
		$requiredFields = ['txtNumeroAsiento', 'txtFechaAsiento', 'listComprobante', 'listStatus', 'txtConceptoOperacion', 'idUsuario'];
		foreach ($requiredFields as $field) {
			if (empty($_POST[$field])) {
				echo json_encode(array("status" => false, "msg" => 'Faltan datos: ' . $field));
				die();
			}
		}
	
		$strNumeroAsiento = strClean($_POST['txtNumeroAsiento']);
		$strFechaAsiento = strClean($_POST['txtFechaAsiento']);
		$strConceptoOperacion = strClean($_POST['txtConceptoOperacion']);
		$strTipoComprobante = strClean($_POST['listComprobante']);
		$intEstadoTransaccion = intval($_POST['listStatus']);
		$intIdUsuario = intval($_POST['idUsuario']);
		$status = 1; // O cualquier otro valor que necesites
		error_log("Datos recibidos: " . json_encode($_POST));
	
		$insertResponse = $this->model->insertComprobante(
			$strNumeroAsiento,
			$strFechaAsiento,
			$strConceptoOperacion,
			$strTipoComprobante,
			$intEstadoTransaccion,
			$intIdUsuario,
			$status 
		);
	
		if ($insertResponse['status'] && isset($insertResponse['idAsiento'])) {
			$idAsiento = $insertResponse['idAsiento'];
	
			// Procesar detalles
			if (!empty($_POST['codigoCuenta'])) {
				$uniqueCodes = array_unique($_POST['codigoCuenta']); // Asegúrate de que los códigos sean únicos
				foreach ($uniqueCodes as $key => $codigoCuenta) { // Usar $key para indexar
					$strNombreCuenta = strClean($_POST['nombreCuenta'][$key]); // Accede por índice
					$intIdCcontables = $this->model->getOrInsertCuenta($codigoCuenta, $strNombreCuenta, $intIdUsuario);
					
					if ($intIdCcontables['status']) {
						$debe = floatval(strClean($_POST['debe'][$key])); // Accede por índice
						$haber = floatval(strClean($_POST['haber'][$key])); // Accede por índice
						$descripcion = strClean($_POST['descripcion'][$key]); // Accede por índice
	
						$this->model->insertDetalleLidiario($idAsiento, $intIdCcontables['idCcontables'], $debe, $haber, $descripcion, $intIdUsuario);
					} else {
						ob_clean(); // Limpiar el buffer para evitar salida previa
						echo json_encode(array("status" => false, "msg" => $intIdCcontables['message']));
						die();
					}
				}
			}
	
			// Crear la respuesta JSON para la inserción exitosa
			$response = ["status" => true, "idAsiento" => $idAsiento, "message" => "Comprobante insertado correctamente."];
			error_log("Respuesta JSON a enviar: " . json_encode($response));
			
			ob_clean(); // Limpiar el buffer para evitar salida previa
			echo json_encode($response); // Enviar respuesta JSON
		} else {
			ob_clean(); // Limpiar el buffer para evitar salida previa
			echo json_encode(array("status" => false, "msg" => $insertResponse['message']));
		}
	}
	
	
	
	public function setUpdateComprobante()
	{
		if ($_POST) {
			// Validación de campos requeridos
			$requiredFields = ['idAsiento', 'txtNumeroAsiento', 'txtFechaAsiento', 'txtConceptoOperacion', 'listComprobante', 'listStatus'];
			foreach ($requiredFields as $field) {
				if (empty($_POST[$field])) {
					echo json_encode(array("status" => false, "msg" => 'Faltan datos: ' . $field));
					die();
				}
			}
	
			$idAsiento = intval($_POST['idAsiento']);
			$strNumeroAsiento = strClean($_POST['txtNumeroAsiento']);
			$strFechaAsiento = strClean($_POST['txtFechaAsiento']);
			$strConceptoOperacion = strClean($_POST['txtConceptoOperacion']);
			$strTipoComprobante = strClean($_POST['listComprobante']);
			$intEstadoTransaccion = intval($_POST['listStatus']);
			$intIdUsuario = intval($_POST['idUsuario']);
			$updateResponse = $this->model->updateComprobante($idAsiento, $strNumeroAsiento, $strFechaAsiento, $strConceptoOperacion, $strTipoComprobante, $intEstadoTransaccion, $intIdUsuario);
	
			echo json_encode($updateResponse);
			die();
		}
	}
	public function setDeleteComprobante()
	{
		if ($_POST) {
			$idAsiento = intval($_POST['idAsiento']); // Asegúrate de que el ID sea un entero
			if ($idAsiento > 0) {
				$requestDelete = $this->model->deleteComprobante($idAsiento);
				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Comprobante eliminado correctamente.');
				} else {
					$arrResponse = array('status' => false, 'msg' => 'No se pudo eliminar el comprobante.');
				}
			} else {
				$arrResponse = array('status' => false, 'msg' => 'ID de comprobante no válido.');
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}
