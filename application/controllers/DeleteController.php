<?php

class DeleteController extends CI_Controller{

    public function index(){

    }
    
    public function deleteTable(){
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $this->TableModel->deleteData($data);
        } else {
            $this->TableModel->deleteAllData($data);
        }
    }
}