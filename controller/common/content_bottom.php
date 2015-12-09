<?php
class ControllerCommonContentBottom extends Controller {
	public function index() {
		$data = array();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/common/content_bottom.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/common/content_bottom.tpl', $data);
		} else {
			return $this->load->view('default/common/content_bottom.tpl', $data);
		}
	}
}