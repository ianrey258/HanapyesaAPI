<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class StoreController extends CI_Controller{

    function __construct(){
        parent::__construct();
    }

    public function insertStore(){
        $table = 'store';
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        $this->setOutput($result);
    }
    
    public function fetchStore(){
        $table = 'store';
        $data = $this->input->post();
        if(empty($data)){
            $result = $this->TableModel->getDatas($table);
        } else {
            $result = $this->TableModel->getData($table,$data);
        }
        $this->setOutput($result);
    }

    public function insertGioLocation(){
        $table = 'gio_address';
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        $this->setOutput($result);
    }

    public function fetchGioLocation(){
        $table = 'gio_address';
        $data = $this->input->post();
        if(empty($data)){
            $result = $this->TableModel->getDatas($table);
        } else {
            $result = $this->TableModel->getData($table,$data);
        }
        $this->setOutput($result);
    }

    public function insertItem(){
        $table = 'item';
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        $this->setOutput($result);
    }

    public function fetchItem(){
        $table = 'item';
        $data = $this->input->post();
        if(empty($data)){
            $result = $this->TableModel->getDatas($table);
        } else {
            $result = $this->TableModel->getData($table,$data);
        }
        $this->setOutput($result);
    }

    public function insertStoreImage(){
        $table = 'store_img';
        $data = $this->input->post();
        if(array_key_exists("id",$data)){
            $oldImg = $this->ImageModel->searchImage($table,array('id' => $data['id']));
            $this->updateStoreImg($oldImg);
            $result = $this->ImageModel->updateImage($table,$data);
        } else {
            if(array_key_exists("binaryfile",$data)){
                $this->uploadStoreImg();
            }
            $result = $this->ImageModel->insertImage($table,$data);
        }
        $this->setOutput($result);
    }

    public function fetchStoreImage(){
        $table = 'store_img';
        $data = $this->input->post();
        if(!empty($data)){
            $result = $this->ImageModel->searchImage($table,$data);
        } else {
            $result = $this->ImageModel->getImages($table);
        }
        $this->setOutput($result);
    }

    public function removeStoreImage(){
        $data = $this->input->post();
        $result = $this->TableModel->deleteData($data);
        $this->deleteStoreImage($data['filename']);
    }

    public function insertStoreApprovalImage(){
        $table = 'store_veriification_img';
        $data = $this->input->post();
        if(array_key_exists("id",$data)){
            //$oldImg = $this->ImageModel->searchImage($table,array('id' => $data['id']));
            //$this->updateUserImg($oldImg);
            $result = $this->ImageModel->updateImage($table,$data);
        } else {
            if(array_key_exists("binaryfile",$data)){
                //$this->uploadUserImg();
            }
            $result = $this->ImageModel->insertImage($table,$data);
        }
        $this->setOutput($result);
    }

    public function fetchStoreApprovalImage(){
        $table = 'store_veriification_img';
        $data = $this->input->post();
        if(!empty($data)){
            $result = $this->ImageModel->searchImage($table,$data);
        } else {
            $result = $this->ImageModel->getImages($table);
        }
        $this->setOutput($result);
    }

    private function uploadStoreImg(){
        $data = $this->input->post();
        $image = base64_decode($data['binaryfile']);
        file_put_contents('./assets/StoreImage/'.$data['filename'],$image);
    }

    private function updateStoreImg($oldImgdata){
        $convertedimg = json_decode(json_encode($oldImgdata[0]),true);
        if($convertedimg['filename'] !=  'null'){
            $this->deleteUserImage($convertedimg['filename']);
        }
        $this->uploadUserImg();
    }

    private function deleteStoreImage($image){
        unlink('./assets/StoreImage/'.$image);
    }

    private function setOutput($request){
        return $this->output
                    ->set_content_type('application/json')
                    ->set_output(json_encode($request));
    }

}