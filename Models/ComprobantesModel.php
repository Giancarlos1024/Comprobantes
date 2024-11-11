<?php  

class ComprobantesModel extends Mysql
{
    private $intIdAsiento;
    private $strNumeroAsiento;
    private $strFechaAsiento;
    private $strConceptoOperacion;
    private $strTipoComprobante;
    private $intEstadoTransaccion;
    private $intIdUsuarios;
    private $intStatus;
    private $model;
    public function __construct()
    {
        parent::__construct();
    }
    public function insertComprobante(string $numeroAsiento, string $fechaAsiento, string $conceptoOperacion, string $tipoComprobante, int $estadoTransaccion, int $idUsuarios, int $status = 1) {
        try {
            // Verifica si el número de asiento ya existe
            $sql = "SELECT * FROM conceptooperacion WHERE numeroasiento = ?";
            $request = $this->select_all($sql, [$numeroAsiento]);
            error_log("Consulta para verificar existencia de asiento: " . $sql . " | Parámetros: " . json_encode([$numeroAsiento]));
            error_log("Resultado de la verificación de existencia: " . json_encode($request));
            if (empty($request)) {
                // Inserta en conceptooperacion
                $query_insert = "INSERT INTO conceptooperacion (numeroasiento, fechaAsiento, conceptoOperacion, tipocomprobante, estadotransaccion, idUsuarios, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
                $arrData = array(
                    $numeroAsiento,
                    $fechaAsiento,
                    $conceptoOperacion,
                    $tipoComprobante,
                    $estadoTransaccion,
                    $idUsuarios,
                    $status
                );
                error_log("Consulta de inserción en conceptooperacion: " . $query_insert . " | Parámetros: " . json_encode($arrData));
                $request_insert = $this->insert($query_insert, $arrData);
    
                // Captura el ID del último comprobante insertado
                if ($request_insert) {
                    $idAsiento = $this->getLastId();
                    error_log("Comprobante insertado correctamente con ID: " . $idAsiento);
                    return ["status" => true, "idAsiento" => $idAsiento, "message" => "Comprobante insertado correctamente."];
                } else {
                    error_log("Error al insertar comprobante en conceptooperacion.");
                    return ["status" => false, "message" => "Error al insertar comprobante."];
                }
            } else {
                error_log("El asiento ya existe.");
                return ["status" => false, "message" => "El asiento ya existe."];
            }
        } catch (PDOException $e) {
            error_log("Error en insertComprobante: " . $e->getMessage()); // Guarda el error en el log
            return ["status" => false, "message" => "Error en la base de datos: " . $e->getMessage()];
        } catch (Exception $e) {
            error_log("Error en insertComprobante: " . $e->getMessage());
            return ["status" => false, "message" => "Error: " . $e->getMessage()];
        }
    }
    public function getLastId() {
        try {
            $query = "SELECT MAX(idAsiento) AS last_id FROM conceptooperacion";
            $result = $this->conexion->query($query);
            $lastId = $result->fetchColumn(); // Devuelve directamente la columna
            error_log("Último ID obtenido en getLastId: " . $lastId);
            return $lastId;
        } catch (PDOException $e) {
            error_log("Error en getLastId: " . $e->getMessage());
            return null; // O maneja el error según sea necesario
        }
    }
    public function getOrInsertCuenta(int $codigoCuenta, string $nombreCuenta, int $idUsuario) {
        try {
            error_log("Parámetros recibidos en getOrInsertCuenta: codigoCuenta = $codigoCuenta, nombreCuenta = $nombreCuenta, idUsuario = $idUsuario");
            $sql = "SELECT idCcontables FROM plancuentas WHERE codigocuenta = ?";
            $request = $this->select($sql, [$codigoCuenta]);
            error_log("Consulta para verificar cuenta existente: " . $sql . " | Parámetros: " . json_encode([$codigoCuenta]));
            if (!empty($request)) {
                error_log("La cuenta ya existe con idCcontables: " . $request['idCcontables']);
                return ["status" => true, "idCcontables" => $request['idCcontables']];
            } else {
                $status = 1; // Activo
                $query_insert = "INSERT INTO plancuentas (codigocuenta, nombrecuenta, idUsuario, status, fechaderegistro, fechaactualizacion) 
                                 VALUES (?, ?, ?, ?, NOW(), NOW())";
                $arrData = array($codigoCuenta, $nombreCuenta, $idUsuario, $status); // Usa la variable para status
    
                // Log para verificar la consulta de inserción
                error_log("Consulta de inserción en plancuentas: " . $query_insert . " | Parámetros: " . json_encode($arrData));
    
                $request_insert = $this->insert($query_insert, $arrData);
                
                if ($request_insert) {
                    error_log("Cuenta insertada correctamente con idCcontables: " . $request_insert);
                    return ["status" => true, "idCcontables" => $request_insert];
                } else {
                    error_log("Error al insertar la cuenta en plancuentas.");
                    return ["status" => false, "message" => "Error al insertar la cuenta en plancuentas."];
                }
            }
        } catch (PDOException $e) {
            error_log("Error en getOrInsertCuenta: " . $e->getMessage());
            return ["status" => false, "message" => "Error en la base de datos: " . $e->getMessage()];
        }
    }
    public function insertDetalleLidiario(int $idAsiento, int $idCcontables, float $debe, float $haber, string $descripcion, int $idUsuario) {
        try {
            $estado = 1; // Activo
            $status = 1; // Activo
            error_log("Parámetros recibidos en insertDetalleLidiario: idAsiento = $idAsiento, idCcontables = $idCcontables, debe = $debe, haber = $haber, descripcion = $descripcion, idUsuario = $idUsuario, status=$status");
    
            $query_insert = "INSERT INTO lidiario 
                                (idAsiento, idCcontables, debe, haber, descripcion, estado, fechacreacion, fechaactualizado, idUsuario, status) 
                             VALUES 
                                (?, ?, ?, ?, ?, ?, NOW(), NOW(), ?, ?)";
            $arrData = array($idAsiento, $idCcontables, $debe, $haber, $descripcion, $estado, $idUsuario, $status);
            error_log("Consulta de inserción en lidiario: " . $query_insert . " | Parámetros: " . json_encode($arrData));
            $request_insert = $this->insert($query_insert, $arrData);
            
            if ($request_insert) {
                error_log("Detalle insertado correctamente en lidiario.");
                return ["status" => true, "message" => "Detalle insertado correctamente en lidiario."];
            } else {
                error_log("Error al insertar el detalle en lidiario.");
                return ["status" => false, "message" => "Error al insertar el detalle en lidiario."];
            }
        } catch (PDOException $e) {
            error_log("Error en insertDetalleLidiario: " . $e->getMessage());
            return ["status" => false, "message" => "Error en la base de datos: " . $e->getMessage()];
        }
    }
    public function selectComprobantes()
    {
        $sql = "SELECT * FROM conceptooperacion WHERE status != 0";
        $request = $this->select_all($sql);
        return $request;
    }
    public function selectPlanCuentas() {
        $sql = "SELECT codigocuenta, nombrecuenta FROM plancuentas";
        return $this->select_all($sql);
    }
    
    public function selectComprobante(int $idAsiento)
    {
        $this->intIdAsiento = $idAsiento;
        // Obtén todos los registros que coinciden con el idAsiento
    $query = "SELECT 
    co.idAsiento, 
    co.numeroasiento, 
    co.fechaAsiento, 
    co.conceptoOperacion, 
    co.tipocomprobante, 
    co.estadotransaccion, 
    co.idUsuarios, 
    co.status, 
    ld.idLidiario, 
    ld.debe, 
    ld.haber, 
    ld.descripcion, 
    pc.codigocuenta, 
    pc.nombrecuenta 
    FROM conceptooperacion AS co 
    LEFT JOIN lidiario AS ld ON co.idAsiento = ld.idAsiento 
    LEFT JOIN plancuentas AS pc ON ld.idCcontables = pc.idCcontables 
    WHERE co.idAsiento = $this->intIdAsiento";

    // Usa select_all en lugar de select
    $request = $this->select_all($query); // Esto devolverá todos los resultados como un arreglo


    // Log de la respuesta de la consulta
    error_log("Respuesta de la consulta: " . print_r($request, true));

    if (empty($request)) {
        $arrResponse = array('status' => false, 'msg' => 'Comprobante no encontrado.');
    } else {
        $arrResponse = array('status' => true, 'data' => $request);  // Asegúrate de que 'data' sea un arreglo
    }

    // Log de la respuesta final
    error_log("Respuesta final enviada al frontend: " . print_r($arrResponse, true));

    echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
    die();
}

    
public function selectConfiguraEmpresa() {
    try {
        // Consulta para obtener los datos de la tabla configuraempresa
        $sql = "SELECT direccion, fechafinfiscal, fechainiciofiscal, idconfigura, nit, nombrereplegal, razonsocial, status FROM configuraempresa";
        $request = $this->select_all($sql);

        // Log para verificar el resultado de la consulta
        error_log("Resultado de la consulta selectConfiguraEmpresa: " . json_encode($request));

        return $request; // Retorna los datos obtenidos de la consulta
    } catch (PDOException $e) {
        error_log("Error en selectConfiguraEmpresa: " . $e->getMessage());
        return ["status" => false, "message" => "Error en la base de datos: " . $e->getMessage()];
    }
}




    public function updateComprobante($idAsiento, $numeroAsiento, $fechaAsiento, $conceptoOperacion, $tipoComprobante, $estadoTransaccion, $idUsuarios)
{
    try {
        // Comprobación de si el número de asiento está vacío o no se proporciona
        if (empty($numeroAsiento)) {
            error_log("Error: El número de asiento no está definido.");
            return ["status" => false, "message" => "Faltan datos: txtNumeroAsiento"];
        }

        // Log del número de asiento recibido
        error_log("Número de asiento recibido: $numeroAsiento");

        error_log("Iniciando actualización del comprobante ID: $idAsiento."); // Agregado para depuración

        // Preparación de la consulta de actualización
        $query_update = "UPDATE conceptooperacion SET numeroasiento = ?, fechaAsiento = ?, conceptoOperacion = ?, tipocomprobante = ?, estadotransaccion = ?, idUsuarios = ? WHERE idAsiento = ?";
        $arrData = array($numeroAsiento, $fechaAsiento, $conceptoOperacion, $tipoComprobante, $estadoTransaccion, $idUsuarios, $idAsiento);
        
        // Log de consulta y parámetros
        error_log("Consulta: $query_update");
        error_log("Parámetros: " . json_encode($arrData));

        // Ejecución de la actualización
        $request_update = $this->update($query_update, $arrData);
        
        // Verificación del resultado de la actualización
        if ($request_update) {
            error_log("Comprobante ID: $idAsiento actualizado correctamente.");
            return ["status" => true, "message" => "Comprobante actualizado correctamente."];
        } else {
            error_log("Error al actualizar el comprobante ID: $idAsiento.");
            return ["status" => false, "message" => "Error al actualizar el comprobante."];
        }
    } catch (PDOException $e) {
        error_log("Error en la actualización: " . $e->getMessage()); // Log de errores
        return ["status" => false, "message" => "Error: " . $e->getMessage()];
    }
}



    public function deleteComprobante(int $idAsiento)
    {
        $this->intIdAsiento = $idAsiento;
        $query_delete = "UPDATE conceptooperacion SET status = ? WHERE idAsiento = ?";
        $arrData = array(0, $this->intIdAsiento); // Cambiando el estado a inactivo
        $request_delete = $this->update($query_delete, $arrData);
        return $request_delete;
    } 
}
