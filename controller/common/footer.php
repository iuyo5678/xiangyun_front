<?php
class ControllerCommonFooter extends Controller {
	public function index() {

		$data = array();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/common/footer.tpl', $data);
		}
	}
}