<?php
if (!defined('BOOTSTRAP')) { die('Access denied'); }

use Tygh\Registry;

function fn_ee_change_myasniki_install() {	
	return true;
}

function fn_ee_change_myasniki_uninstall() {
	return true;
}

function fn_ee_change_myasniki_products_sorting(&$sorting, $simple_mode) {
	$sorting['code'] = array('description' => 'code', 'default_order' => 'desc');
}

function fn_ee_change_myasniki_get_products_pre(&$params, $items_per_page, $lang_code) {
	$params['match'] = 'all';
}
