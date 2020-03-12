<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class StoreController extends CI_Controller{

    function __construct(){
        parent::__construct();
    }
    //Store
    public function insertStore(){
        $table = 'store';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchStore(){
        $table = 'store';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //GioLocation
    public function insertGioLocation(){
        $table = 'gio_address';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchGioLocation(){
        $table = 'gio_address';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Item
    public function insertItem(){
        $table = 'item';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchItem(){
        $table = 'item';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Data crud Util
    private function insertData($table){
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        $this->setOutput($result);
    }

    private function fetchData($table){
        $data = $this->input->post();
        if(empty($data)){
            $result = $this->TableModel->getDatas($table);
        } else {
            $result = $this->TableModel->getData($table,$data);
        }
        return $result;
    }
    //array to Json
    private function setOutput($request){
        return $this->output
                    ->set_content_type('application/json')
                    ->set_output(json_encode($request));
    }

}