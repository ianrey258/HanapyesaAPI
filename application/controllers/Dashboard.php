<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard extends CI_controller{
    
    function __construct(){
        parent::__construct();
    }

    public function index(){
        $this->load->view('template/header');
        $this->load->view('template/dashboard');
        $this->load->view('template/footer');
    }

    public function loadNewUser(){
        $this->load->view('template/header');
        $this->load->view('imageUpload');
        $this->load->view('template/footer');
    }

    
}