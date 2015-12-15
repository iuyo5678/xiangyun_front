<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		$data['title'] = $this->document->getTitle();

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();
		$data['name'] = $this->config->get('config_name');

        if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
            $data['icon'] = $server . 'view/img/' . $this->config->get('config_icon');
        } else {
            $data['icon'] = '';
        }
		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'view/img/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}
		$data['class'] = 'common-home';


		$data['yp_collect'] = $this->url->link('yp/collect');
		$data['yp_repair'] = $this->url->link('yp/repair');
		$data['yp_move'] = $this->url->link('yp/move');
		$data['yp_clean'] = $this->url->link('yp/clean');
		$data['yp_multi'] = $this->url->link('yp/multi');

		$data['bdoor_collect'] = $this->url->link('bdoor/collect');
		$data['bdoor_nail'] = $this->url->link('bdoor/nail');
		$data['bdoor_massage'] = $this->url->link('bdoor/massage');
		$data['bdoor_peccancy'] = $this->url->link('bdoor/peccancy');
		//$data['bdoor_carwash'] = $this->url->link('bdoor/carwash');

		$data['payment_collect'] = $this->url->link('payment/collect');
		$data['payment_telecom'] = $this->url->link('payment/telecom');



		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/common/header.tpl', $data);
		} else {
			return $this->load->view('default/common/header.tpl', $data);
		}
	}
}