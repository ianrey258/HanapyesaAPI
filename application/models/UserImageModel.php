<?php

class UserImageModel extends CI_Model{

    public function __contruct(){
        parent::__contruct();
    }

    public function getUserImages(){
        return $this->db->query('select * from user_img')->result();
    }

    public function searchUserImage($data){
        $query = $this->db->get_where('user_img',$data);
        return $query->result();
    }

    public function insertUserImage($data){
        $fdata = array('accountId' => $data['accountId'],'filename' => $data['filename']);
        $this->db->insert('user_img',$fdata);
        return $this->searchUserImage($fdata);
    }

    public function updateUserImage($data){
        $fdata = array('id'=> $data['id'],'accountId' => $data['accountId'],'filename' => $data['filename']);
        $this->db->replace('user_img',$fdata);
        return $this->searchUserImage($fdata);
    }
}