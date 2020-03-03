<?php

class UserModel extends CI_Model{

    public function __contruct(){
        parent::__contruct();
    }

    public function getUsers(){
        return $this->db->query('select * from user')->result();
    }

    public function searchUser($data){
        $query = $this->db->get_where('user',$data);
        return $query->result();
    }

    public function insertUser($data){
        $this->db->insert('user',$data);
        return $this->searchUser($data);
    }

    public function updateUser($data){
        $this->db->replace('user',$data);
        return $this->searchUser($data);
    }
}