<?php

class ProcedureModel extends CI_Model{

    public function getStoreItem($data){
        return $this->db->query('call  getStoreItem(?)',$data)->result();
    }

    public function getStoreItemImage($data){
        return $this->db->query('call  getStoreItemImage(?)',$data)->result();
    }

    public function getStoreItemRate($data){
        return $this->db->query('call  getStoreItemRate(?)',$data)->result();
    }

    public function getStoreItemReviews($data){
        return $this->db->query('call  getStoreItemReviews(?)',$data)->result();
    }
}