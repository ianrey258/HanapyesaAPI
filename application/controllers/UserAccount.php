<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class UserAccount extends CI_Controller {

    function __contruct(){
        parent::__contruct();
    }

	public function index()
	{
        //$method = $this->input->$_SERVER("REQUEST_METHOD");
    }

    public function fetchUserImage(){
        $data = $this->input->post();
        if(!empty($data)){
            $result = $this->UserImageModel->searchUserImage($data);
        } else {
            $result = $this->UserImageModel->getUserImages();
        }
        $this->setOutput($result);
    }
    
    public function fetchUser(){
        $data = $this->input->post();
        if(!empty($data)){
            $result = $this->UserModel->searchUser($data);
        } else {
            $result = $this->UserModel->getUsers();
        }
        $this->setOutput($result);
    }

    public function fetchUserAccount(){
        $data = $this->input->post();
        if(!empty($data)){
            $result = $this->UserAccountModel->searchUserAccount($data);
        } else {
            $result = $this->UserAccountModel->getUsersAccount();
        }
        $this->setOutput($result);
    }

    public function fecthUserId(){
        $data = $this->input->post();
        $result = $this->UserModel->searchData();
        $this->setOutput($result);
    }

    public function fecthUserAccountId(){
        $data = $this->input->post();
        $result = $this->UserAccountModel->searchData();
        $this->setOutput($result);
    }

    public function insertUserImage(){
        $data = $this->input->post();
        if(array_key_exists("id",$data)){
            $oldImg = $this->UserImageModel->searchUserImage(array('id' => $data['id']));
            $this->updateUserImg($oldImg);
            $result = $this->UserImageModel->updateUserImage($data);
        } else {
            if(array_key_exists("binaryfile",$data)){
                $this->uploadUserImg();
            }
            $result = $this->UserImageModel->insertUserImage($data);
        }
        $this->setOutput($result);
    }

    public function insertUser(){
        $data = $this->input->post();
        if(array_key_exists("id",$data)){
            $result = $this->UserModel->updateUser($data);
        } else {
            $result = $this->UserModel->insertUser($data);
        }
        $this->setOutput($result);
    }

    public function insertUserAccount(){
        $data = $this->input->post();
        if(array_key_exists("id",$data)){
            $result = $this->UserAccountModel->updateUserAccount($data);
        } else {
            $result = $this->UserAccountModel->insertUserAccount($data);
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

    public function deleteUserImage($image){
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