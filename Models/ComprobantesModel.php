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
    public function __construct()
    {
        parent::__construct();
    }
    public function insertComprobante(string $numeroAsiento, string $fechaAsiento, string $conceptoOperacion, string $tipoComprobante, int $estadoTransaccion, int $idUsuarios, int $status) {
        try {
            $sql = "SELECT * FROM conceptooperacion WHERE numeroasiento = '{$numeroAsiento}'";
            $request = $this->select_all($sql);
    
            if (empty($request)) {
                // Insertar en conceptooperacion
                $query_insert = "INSERT INTO conceptooperacion(numeroasiento, fecchaAsiento, conceptoOperacion, tipocomprobante, estadotransaccion, idUsuarios, status) 
                                 VALUES (?, ?, ?, ?, ?, ?, ?)";
                $arrData = array(
                    $numeroAsiento,
                    $fechaAsiento,
                    $conceptoOperacion,
                    $tipoComprobante,
                    $estadoTransaccion,
                    $idUsuarios,
                    $status // Asegúrate de pasar el status aquí
                );
                $request_insert = $this->insert($query_insert, $arrData);
                if ($request_insert) {
                    return ["status" => true, "message" => "Comprobante insertado correctamente."];
                } else {
                    return ["status" => false, "message" => "Error al insertar comprobante."];
                }
            } else {
                return ["status" => "exist", "message" => "El asiento ya existe."];
            }
        } catch (PDOException $e) {
            return ["status" => false, "message" => "Error al insertar comprobante: " . $e->getMessage()];
        }
    }
    
    public function getLastId()
    {
        $sql = "SELECT LAST_INSERT_ID() AS id";
        $request = $this->select($sql);
        return $request ? $request['id'] : null;
    }
    public function selectComprobantes()
    {
        $sql = "SELECT * FROM conceptooperacion WHERE status != 0";
        $request = $this->select_all($sql);
        return $request;
    }
    public function selectComprobante(int $idAsiento)
    {
        $this->intIdAsiento = $idAsiento;
        $sql = "SELECT 
                    co.idAsiento, 
                    co.numeroasiento, 
                    co.fecchaAsiento, 
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
        $request = $this->select($sql);
        return $request;
    }
    public function updateComprobante($idAsiento, $numeroAsiento, $fechaAsiento, $conceptoOperacion, $tipoComprobante, $estadoTransaccion, $idUsuarios)
    {
        try {
            $query_update = "UPDATE conceptooperacion SET numeroasiento = ?, fecchaAsiento = ?, conceptoOperacion = ?, tipocomprobante = ?, estadotransaccion = ?, idUsuarios = ? WHERE idAsiento = ?";
            $arrData = array($numeroAsiento, $fechaAsiento, $conceptoOperacion, $tipoComprobante, $estadoTransaccion, $idUsuarios, $idAsiento);
            $request_update = $this->update($query_update, $arrData);
            
            if ($request_update) {
                return ["status" => true, "message" => "Comprobante actualizado correctamente."];
            } else {
                return ["status" => false, "message" => "Error al actualizar el comprobante."];
            }
        } catch (PDOException $e) {
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
