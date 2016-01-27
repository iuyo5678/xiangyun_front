<?php
/**
 * Created by PhpStorm.
 * User: zhangguhua
 * Date: 15/12/4
 * Time: 下午5:00
 */
class ControllerPaymentOfashion extends Controller {
    public function index() {
        $this->document->setTitle('ofashion');

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

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/payment/ofashion.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/payment/ofashion.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/payment/ofashion.tpl', $data));
        }
    }
}