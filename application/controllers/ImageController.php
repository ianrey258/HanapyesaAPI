<?php

class ImageController extends CI_Controller{

    //Store Apporval Image
    public function insertStoreApprovalImage(){
        $table = 'store_veriification_img';
        $path = './assets/StoreApprovalImage/';
        $result =  $this->insertImage($table,$path);
        $this->setOutput($result);
    }

    public function fetchStoreApprovalImage(){
        $table = 'store_veriification_img';
        $result =  $this->fecthImage($table);
        $this->setOutput($result);
    }

    public function removeStoreApprovalImage(){
        $data = $this->input->post();
        $path = './assets/StoreApprovalImage/';
        $result = $this->TableModel->deleteData($data);
        $this->deleteImage($data['filename'],$path);
    }

    //StoreImage
    public function insertStoreImage(){
        $table = 'store_img';
        $path = './assets/StoreImage/';
        $result =  $this->insertImage($table,$path);
        $this->setOutput($result);
    }

    public function fetchStoreImage(){
        $table = 'store_img';
        $result =  $this->fecthImage($table);
        $this->setOutput($result);
    }

    public function removeStoreImage(){
        $data = $this->input->post();
        $path = './assets/StoreImage/';
        $result = $this->TableModel->deleteData($data);
        $this->deleteImage($data['filename'],$path);
    }

    //ItemImage
    public function insertItemImage(){
        $table = 'item_img';
        $path = './assets/ItemImage/';
        $result =  $this->insertImage($table,$path);
        $this->setOutput($result);
    }

    public function fetchItemImage(){
        $table = 'item_img';
       $result =  $this->fecthImage($table);
        $this->setOutput($result);
    }

    public function removeItemImage(){
        $data = $this->input->post();
        $path = './assets/ItemImage/';
        $result = $this->TableModel->deleteData($data);
        $this->deleteImage($data['filename'],$path);
    }

    //UserImage
    public function insertUserImage(){
        $table = 'user_img';
        $path = './assets/UserImage/';
        $result =  $this->insertImage($table,$path);
        $this->setOutput($result);
    }

    public function fetchUserImage(){
        $table = 'user_img';
        $result =  $this->fecthImage($table);
        $this->setOutput($result);
    }


    //Image Crud Functions
    private function insertImage($table,$path){
        $data = $this->input->post();
        if(array_key_exists("id",$data)){
            $oldImg = $this->ImageModel->searchImage($table,array('id' => $data['id']));
            $this->updateImage($oldImg,$path);
            $result = $this->ImageModel->updateImage($table,$data);
        } else {
            if(array_key_exists("binaryfile",$data)){
                $this->uploadImage($path);
            }
            $result = $this->ImageModel->insertImage($table,$data);
        }
        return $result;
    }

    private function fecthImage($table){
        $data = $this->input->post();
        if(!empty($data)){
            $result = $this->ImageModel->searchImage($table,$data);
        } else {
            $result = $this->ImageModel->getImages($table);
        }
        return $result;
    }

    //Image Crud Util Functions
    private function uploadImage($path){
        $data = $this->input->post();
        $image = base64_decode($data['binaryfile']);
        file_put_contents($path.''.$data['filename'],$image);
    }

    private function updateImage($oldImgdata,$path){
        $convertedimg = json_decode(json_encode($oldImgdata[0]),true);
        if($convertedimg['filename'] !=  'null'){
            $this->deleteUserImage($convertedimg['filename']);
        }
        $this->uploadUserImg($path);
    }

    private function deleteImage($image,$path){
        unlink($path.''.$image);
    }
    // Array to Json Output
    private function setOutput($request){
        return $this->output
                    ->set_content_type('application/json')
                    ->set_output(json_encode($request));
    }
}