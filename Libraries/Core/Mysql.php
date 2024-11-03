<?php 

class Mysql extends Conexion
{
    private $conexion;
    private $strquery;
    private $arrValues;

    function __construct()
    {
        $this->conexion = new Conexion();
        $this->conexion = $this->conexion->conect();
    }

    // Insertar un registro
    public function insert(string $query, array $arrValues)
    {
        $this->strquery = $query;
        $this->arrValues = $arrValues; // Cambié 'arrVAlues' a 'arrValues' para mantener la consistencia
        $insert = $this->conexion->prepare($this->strquery);
        $resInsert = $insert->execute($this->arrValues);

        if ($resInsert) {
            return $this->conexion->lastInsertId();
        } else {
            return 0; // Retorna 0 si no se inserta
        }
    }

    // Busca un registro
    public function select(string $query)
    {
        $this->strquery = $query;
        $result = $this->conexion->prepare($this->strquery);
        $result->execute();
        return $result->fetch(PDO::FETCH_ASSOC);
    }

    // Devuelve todos los registros
    public function select_all(string $query)
    {
        $this->strquery = $query;
        $result = $this->conexion->prepare($this->strquery);
        $result->execute();
        return $result->fetchAll(PDO::FETCH_ASSOC); // Cambié 'fetchall' a 'fetchAll' (mayúscula)
    }

    // Actualiza registros
    public function update(string $query, array $arrValues)
    {
        $this->strquery = $query;
        $this->arrValues = $arrValues; // Cambié 'arrVAlues' a 'arrValues'
        $update = $this->conexion->prepare($this->strquery);
        return $update->execute($this->arrValues); // Simplificado
    }

    // Elimina un registro
    public function delete(string $query)
    {
        $this->strquery = $query;
        $result = $this->conexion->prepare($this->strquery);
        return $result->execute(); // Simplificado
    }

    // Devuelve el último error de la conexión
    public function getLastError()
    {
        return $this->conexion->errorInfo();
    }
}

?>
