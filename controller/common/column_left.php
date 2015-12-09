<?php
class ControllerCommonColumnLeft extends Controller {
	public function index() {
		$data = array();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/common/column_left.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/common/column_left.tpl', $data);
		} else {
			return $this->load->view('default/common/column_left.tpl', $data);
		}
	}
}