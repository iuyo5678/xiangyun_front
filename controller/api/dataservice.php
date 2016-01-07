<?php
/**
 * Created by PhpStorm.
 * User: zhangguhua
 * Date: 15/12/16
 * Time: 下午4:05
 */
class ControllerApiDataService extends Controller {
    public function get()
    {
        $json = array();
        if (isset($this->request->post['key'])) {
            $json['data'] = $this->redis->get($this->request->post['key']);
            $json['successe'] = "success";
        }else{
            $json['error'] = "should post a key";

        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput($json);
    }

    public function set()
    {
        $json = array();
        if (isset($this->request->post['key'])) {
            $this->redis->set($this->request->post['key'], $this->request->post['value'], 1, 'h');
            $json['successe'] = "success";
        }else{
            $json['error'] = "should post a key";

        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput($json);
    }
    public function process()
    {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $input_str =  $this->request->post['process_input'];
            $process_type = $this->request->post['process_type'];
            $process_func = $this->request->post['process_func'];
            $json = array();

            $json['successe'] = "success";
            $json['process_type'] = $process_type;
            $json['process_func'] = $process_func;

            $process_func = '#!/usr/bin/env python\n
# -*- coding: utf-8 -*-
'.$process_func;

            $procss_file = fopen("/Applications/XAMPP/htdocs/xiangyun_front/controller/api/process_func.py", "w") or die("Unable to open file!");
            fwrite($procss_file, htmlspecialchars_decode($process_func));
            fclose($procss_file);


            $command = escapeshellcmd('/Applications/XAMPP/htdocs/xiangyun_front/controller/api/data_process_wrap.py ');
            $output = shell_exec($command);

            $json['result'] = $output;


            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));
        }
    }
}