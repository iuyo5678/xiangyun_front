<?php
/**
 * Created by PhpStorm.
 * User: zhangguhua
 * Date: 15/12/4
 * Time: 下午4:47
 */
class ControllerBdoorMassage extends Controller {
    public function index() {

        $this->document->setTitle("订单分发-按摩统计");

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

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/bdoor/massage.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/bdoor/massage.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/bdoor/massage.tpl', $data));
        }
    }
}