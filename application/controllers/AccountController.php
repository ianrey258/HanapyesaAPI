<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AccountController extends CI_Controller {

    function __construct(){
        parent::__construct();
    }

	public function index(){
        //$method = $this->input->$_SERVER("REQUEST_METHOD");
        echo 'warrap!!';
    }

    public function insertUser(){
        $table = 'user';
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        $this->setOutput($result);
    }
    
    public function fetchUser(){
        $table = 'user';
        $data = $this->input->post();
        if(empty($data)){
            $result = $this->TableModel->getDatas($table);
        } else {
            $result = $this->TableModel->getData($table,$data);
        }
        $this->setOutput($result);
    }
    
    public function insertUserAccount(){
        $table = 'user_account';
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        $this->setOutput($result);
    }

    public function fetchUserAccount(){
        $table = 'user_account';
        $data = $this->input->post();
        if(empty($data)){
            $result = $this->TableModel->getDatas($table);
        } else {
            $result = $this->TableModel->getData($table,$data);
        }
        $this->setOutput($result);
    }

    public function insertNotification(){
        $table = 'item';
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        $this->setOutput($result);
    }

    public function insertUserImage(){
        $table = 'user_img';
        $data = $this->input->post();
        if(array_key_exists("id",$data)){
            $oldImg = $this->ImageModel->searchImage($table,array('id' => $data['id']));
            $this->updateUserImg($oldImg);
            $result = $this->ImageModel->updateImage($table,$data);
        } else {
            if(array_key_exists("binaryfile",$data)){
                $this->uploadUserImg();
            }
            $result = $this->ImageModel->insertImage($table,$data);
        }
        $this->setOutput($result);
    }

    public function fetchUserImage(){
        $table = 'user_img';
        $data = $this->input->post();
        if(!empty($data)){
            $result = $this->ImageModel->searchImage($table,$data);
        } else {
            $result = $this->ImageModel->getImages($table);
        }
        $this->setOutput($result);
    }

    private function uploadUserImg(){
        $data = $this->input->post();
        $image = base64_decode($data['binaryfile']);
        file_put_contents('./assets/UserImage/'.$data['filename'],$image);
    }

    private function updateUserImg($oldImgdata){
        $convertedimg = json_decode(json_encode($oldImgdata[0]),true);
        if($convertedimg['filename'] !=  'null'){
            $this->deleteUserImage($convertedimg['filename']);
        }
        $this->uploadUserImg();
    }

    private function deleteUserImage($image){
        unlink('./assets/UserImage/'.$image);
    }

    // public function ImageUpload(){
    //     $this->load->view('imageUpload');
    // }

    // public function uploadPicture(){
    //     $data = $this->input->post();
    //     $config['upload_path'] = './assets/UserImage/';
    //     $config['allowed_types'] = 'gif|jpg|png|jpeg';
    //     $config['max_size']  = '100';
    //     $config['max_width']  = '1024';
    //     $config['max_height']  = '768';

    //     $this->load->library('upload', $config);
        
    //     if (!$this->upload->do_upload('fileToUpload')){
    //         $error = array('error' => $this->upload->display_errors());
    //         echo "Error";
    //     }
    //     else{
    //         $image = array('upload_data' => $this->upload->data());
    //         $imagename = $this->upload->data();
    //         echo($imagename['file_name']);
    //         echo "success";
    //     }
    //     var_dump($data);
    // }

    private function setOutput($request){
        return $this->output
                    ->set_content_type('application/json')
                    ->set_output(json_encode($request));
    }
}