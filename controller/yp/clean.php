<?php
/**
 * Created by PhpStorm.
 * User: zhangguhua
 * Date: 15/12/4
 * Time: 下午4:46
 */
class ControllerYpClean extends Controller {
    public function index() {

        $this->document->setTitle("黄页保洁PV UV 点击统计");

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => "",
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => "",
            'href' => $this->url->link('')
        );

        $data['header'] = $this->load->controller('common/header');

        $data['footer'] = $this->load->controller('common/footer');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/yp/clean.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/yp/clean.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/yp/clean.tpl', $data));
        }
    }
}