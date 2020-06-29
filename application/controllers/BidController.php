<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class BidController extends CI_Controller {

    function __construct(){
        parent::__construct();
    }
    //BidItem
    public function insertBidItem(){
        $table = 'bid_item';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchBidItems(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getBidItems($data);
        $this->setOutput($result);
    }

    public function fetchBidItem(){
        $table = 'bid_item';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }

    public function getOtherBidItems(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getOtherBidItems($data);
        $this->setOutput($result);
    }
    //BidItemDetail
    public function insertBidItemDetail(){
        $table = 'bid_item_detail';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchBidItemDetail(){
        $table = 'bid_item_detail';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }

    public function getBidItemDetails(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getBidItemDetails($data);
        $this->setOutput($result);
    }

    public function getOthersBidItemDetails(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getOthersBidItemDetails($data);
        $this->setOutput($result);
    }

    public function getBiddersSuggestedItem(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getBiddersSuggestedItem($data);
        $this->setOutput($result);
    }
    //BidItemManager
    public function insertBidItemManager(){
        $table = 'bid_manager';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchBidItemManager(){
        $table = 'bid_manager';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //Bidders
    public function insertBidder(){
        $table = 'bidders';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchBidder(){
        $table = 'bidders';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }

    public function fetchBidders(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getBidders($data);
        $this->setOutput($result);
    }
    //BidChatTable
    public function insertBidChat(){
        $table = 'bid_chat_area';
        $result = $this->insertData($table);
        $this->setOutput($result);
    }

    public function fetchBidChats(){
        $table = 'bid_chat_area';
        $result = $this->fetchData($table);
        $this->setOutput($result);
    }
    //getUsersbyLocation
    public function fetchUsersbyLocation(){
        $data = $this->input->post();
        $result = $this->ProcedureModel->getUsersByLocation($data);
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