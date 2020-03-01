<?php

class UserAccountModel extends CI_Model{

    public function __contruct(){
        parent::__contruct();
    }

    public function getUsersAccount(){
        return $this->db->query('select * from user_account')->result();
    }

    public function searchUserAccount($data){
        $query = $this->db->get_where('user_account',$data);
        return $query->result();
    }

    public function insertUserAccount($data){
        $this->db->insert('user_account',$data);
        return $this->searchUserAccount($data);
    }

    public function updateUserAccount($data){
        $table = 'user_account';
        $this->db->replace($table,$data);
        return $data['id'];
    }

}
