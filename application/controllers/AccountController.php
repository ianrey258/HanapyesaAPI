<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AccountController extends CI_Controller {

    function __construct(){
        parent::__construct();
    }

	public function index(){
        //$method = $this->input->$_SERVER("REQUEST_METHOD");
        echo 'warrap mananap!!';
    }
    //User
    public function insertUser(){
        $table = 'user';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }
    
    public function fetchUser(){
        $table = 'user';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //UserAccount
    public function insertUserAccount(){
        $table = 'user_account';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchUserAccount(){
        $table = 'user_account';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Notification
    public function insertNotification(){
        $table = 'user_notification';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchNotification(){
        $table = 'user_notification';
        $result = $this->fetchData($table);
        $this->setOutput($result);
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