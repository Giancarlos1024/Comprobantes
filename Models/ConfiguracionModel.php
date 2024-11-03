
<?php
class ConfiguracionModel extends Mysql
{
    public $intIdConfigura;
    public function __construct()
    {
        parent::__construct();
    }

    public function selectConfiguracion()
    {
        //EXTRAE configuracion
        $sql = "SELECT * FROM configuraempresa WHERE status != 0";
        $request = $this->select_all($sql);
        return $request;
    }

    public function selectConfigura(int $idConfigura)
    {
        //EXTRAE un elemento de Configuracion
        $this->intIdConfigura= $idConfigura;
        $sql = "SELECT * FROM configuraempresa WHERE idconfigura = $this->intIdConfigura";
        $request = $this->select($sql);
        return $request;
    }

}


?>
