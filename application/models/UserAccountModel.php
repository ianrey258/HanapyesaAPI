<?php

class UserAccountModel extends CI_Model{

    public function __contruct(){
        parent::__contruct();
    }

    public function getUserAccount(){
        return $this->db->query('select * from user_account')->result();
    }

    public function insertUser($data){
        //$this->db->insert('user',$data);
        return $this->db->get_where('user',$data)->row('id');
    }

}
