<?php

class TableModel extends CI_Model{

    public function getDatas($table){
        return $this->db->get($table)->result();
    }

    public function getData($table,$data){
        return $this->db->get_where($table,$data)->result();
    }

    public function insertData($table,$data){
        $this->db->insert($table,$data);
        return $this->getData($table,$data);
        
    }

    public function updateData($table,$data){
        $this->db->where('id',$data['id']);
        $this->db->update($table,$data);
        return $this->getData($table,$data);
    }

    public function deleteData($data){
        $this->db->delete($data['table'],array('id'=>$data['id']));
        return $this->getDatas($data['table']);
    }

    public function deleteAllData($data){
        $this->db->empty_table($data['table']);
        return $this->getDatas($data['table']);
    }

}