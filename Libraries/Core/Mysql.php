<?php 

class Mysql extends Conexion
{
    protected $conexion;
    private $strquery;
    private $arrValues;

    function __construct()
    {
        try {
            $this->conexion = new Conexion();
            $this->conexion = $this->conexion->conect();
        } catch (PDOException $e) {
            die("Error de conexión: " . $e->getMessage());
        }
    }

    // Insertar un registro
    public function insert(string $query, array $arrValues): int
    {
        try {
            $this->strquery = $query;
            $this->arrValues = $arrValues;
            $insert = $this->conexion->prepare($this->strquery);
            $resInsert = $insert->execute($this->arrValues);

            if ($resInsert) {
                return $this->conexion->lastInsertId();
            } else {
                throw new Exception("Error al insertar el registro.");
            }
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return 0; // Podrías considerar lanzar la excepción en vez de retornarla
        }
    }

    // Busca un registro
    public function select(string $query): ?array
    {
        try {
            $this->strquery = $query;
            $result = $this->conexion->prepare($this->strquery);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return null;
        }
    }

    // Devuelve todos los registros
    public function select_all(string $query): array
    {
        try {
            $this->strquery = $query;
            $result = $this->conexion->prepare($this->strquery);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return [];
        }
    }

    // Actualiza registros
    public function update(string $query, array $arrValues): bool
    {
        try {
            $this->strquery = $query;
            $this->arrValues = $arrValues;
            $update = $this->conexion->prepare($this->strquery);
            return $update->execute($this->arrValues);
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return false;
        }
    }

    // Elimina un registro
    public function delete(string $query): bool
    {
        try {
            $this->strquery = $query;
            $result = $this->conexion->prepare($this->strquery);
            return $result->execute();
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return false;
        }
    }

    // Devuelve el último error de la conexión
    public function getLastError(): array
    {
        return $this->conexion->errorInfo();
    }

    // // Cierra la conexión (opcional)
    // public function closeConnection(): void
    // {
    //     $this->conexion = null;
    // }
}

?>
