<?php

class Configuracion extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
		}
		getPermisos(3);
	}

	public function Configuracion()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Configuracion";
		$data['page_name'] = "configuracion";
		$data['page_title'] = "Configuracion <small> Sistema Web Contable</small>";
		$data['page_functions_js'] = "functions_configuracion.js";
		$this->views->getView($this, "configuracion", $data);
	}

	public function getConfiguracion()
	{
		$arrData = $this->model->selectConfiguracion();
		// dep($arrData);
		// exit();

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
				$btnView = '<button class="btn btn-secondary btn-sm" onClick="fntViewInfo(' . $arrData[$i]['idconfigura'] . ')" title="Ver Configuracion"><i class="fas fa-eye"></i></button>';
			}

			if ($_SESSION['permisosMod']['u']) {
				$btnEdit = '<button class="btn btn-primary btn-sm" onClick="fntEditInfo(' . $arrData[$i]['idconfigura'] . ')" title="Editar Configuracion"><i class="fas fa-pencil-alt"></i></button>';
			}

			if ($_SESSION['permisosMod']['d']) {
				$btnDelete = '<button class="btn btn-danger btn-sm" onClick="fntDeltInfo(' . $arrData[$i]['idconfigura'] . ')" title="Eliminar Configuracion"><i class="fas fa-trash-alt"></i></button>';
			}

			$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
		}
		echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		die();
	}

	public function getConfigura($idconfigura)
	{
		$intConfigura = intval($idconfigura);
		$arrData = $this->model->selectConfigura($intConfigura);
		//dep($arrData);exit();


		if ($intConfigura > 0) {
			$arrData = $this->model->selectConfigura($intConfigura);
			// dep($arrData);exit();

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
			dep($_POST);exit();
			
			if (empty($_POST['txtNit']) || empty($_POST['txtRazonSocial']) || empty($_POST['txtNombreRepLegal']) || empty($_POST['txtDireccion']) || empty($_POST['txtFechainicio']) || empty($_POST['txtFechafin']) || empty($_POST['listStatus']) ) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
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

				if ($idUsuario == 0) {
					$option = 1;
					$strPassword =  empty($_POST['txtPassword']) ? passGenerator() : $_POST['txtPassword'];
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
					$strPassword =  empty($_POST['txtPassword']) ? "" : hash("SHA256", $_POST['txtPassword']);
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

				if ($request_user > 0) {
					if ($option == 1) {
						$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
						$nombreUsuario = $strNombre . ' ' . $strApellido;
						$dataUsuario = array(
							'nombreUsuario' => $nombreUsuario,
							'email' => $strEmail,
							'password' => $strPassword,
							'asunto' => 'Bienvenido a tu tienda en línea'
						);
						sendEmail($dataUsuario, 'email_bienvenida');
					} else {
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}
				} else if ($request_user == 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}
