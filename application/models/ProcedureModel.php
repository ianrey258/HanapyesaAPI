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

    public function getBidItems($data){
        return $this->db->query('call  getBidItem(?)',$data)->result();
    }

    public function getBidItemDetails($data){
        return $this->db->query('call  getBidItemDetails(?)',$data)->result();
    }

    public function getOthersBidItemDetails($data){
        return $this->db->query('call  getOthersBidItemDetails(?)',$data)->result();
    }

    public function getBiddersSuggestedItem($data){
        return $this->db->query('call  getOthersBidItemDetails(?)',$data)->result();
    }

    public function getOtherBidItems($data){
        return $this->db->query('call  getOtherBidItems(?)',$data)->result();
    }

    public function getBidItemImages($data){
        return $this->db->query('call  getBidItemImages(?)',$data)->result();
    }

    public function getBidders($data){
        return $this->db->query('call  getBidders(?)',$data)->result();
    }

    public function getAddresses(){
        return $this->db->query('call  getAddresses()')->result();
    }

    public function getUsersByLocation($data){
        return $this->db->query('call  getUsersByLocation(?)',$data)->result();
    }

    public function getStores($data){
        return $this->db->query('call getStores(?)',$data)->result();
    }
}