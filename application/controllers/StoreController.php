<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class StoreController extends CI_Controller{

    function __construct(){
        parent::__construct();
    }
    //Store
    public function insertStore(){
        $table = 'store';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchStore(){
        $table = 'store';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //GioLocation
    public function insertGioLocation(){
        $table = 'gio_address';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchGioLocation(){
        $table = 'gio_address';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Item
    public function insertItem(){
        $table = 'item';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchItem(){
        $table = 'item';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //ItemRating
    public function insertItemRating(){
        $table = 'item_rating';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchItemRating(){
        $table = 'item_rating';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }

    public function fetchStoreItemRating(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getStoreItemRate($data);
        $this->setOutput($result);
    }
    //ItemReviews
    public function insertItemReview(){
        $table = 'item_reviews';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchItemReview(){
        $table = 'item_reviews';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }

    public function fetchStoreItemReviews(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getStoreItemReviews($data);
        $this->setOutput($result);
    }
    //StoreItem
    public function insertStoreItem(){
        $table = 'storeitem';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }
    public function fetchStoreItem(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getStoreItem($data);
        $this->setOutput($result);
    }
    //Item Category
    public function fetchCategory(){
        $table = 'item_category';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Item Tags
    public function fetchTags(){
        $table = 'item_tags';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Address
    public function fetchAddress(){
        $table = 'zip_code';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Data crud Util
    private function insertData($table){
        $data = $this->input->post();
        if(array_key_exists('id',$data)){
            $result = $this->TableModel->updateData($table,$data);
        } else {
            $result = $this->TableModel->insertData($table,$data);
        }
        return $result;
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