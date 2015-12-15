<?php
/**
 * Created by PhpStorm.
 * User: zhangguhua
 * Date: 15/12/4
 * Time: 下午4:59
 */
class ControllerBdoorCollect extends Controller {
    public function index() {
        $this->document->setTitle("订单分发-汇总统计");

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

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/bdoor/collect.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/bdoor/collect.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/bdoor/collect.tpl', $data));
        }
    }
}