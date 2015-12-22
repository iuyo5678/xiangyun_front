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
}