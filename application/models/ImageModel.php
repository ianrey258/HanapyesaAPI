<?php

class ImageModel extends CI_Model{

    public function __contruct(){
        parent::__contruct();
    }

    public function getImages($table){
        return $this->db->get($table)->result();
    }

    public function searchImage($table,$data){
        $query = $this->db->get_where($table,$data);
        return $query->result();
    }

    public function insertImage($table,$data){
        $fdata = array('parentId' => $data['parentId'],'filename' => $data['filename']);
        $this->db->insert($table,$fdata);
        return $this->searchImage($table,$fdata);
    }

    public function updateImage($table,$data){
        $fdata = array('parentId' => $data['parentId'],'filename' => $data['filename']);
        $this->db->where('id',$data['id']);
        $this->db->update($table,$fdata);
        return $this->searchImage($table,$fdata);
    }
}