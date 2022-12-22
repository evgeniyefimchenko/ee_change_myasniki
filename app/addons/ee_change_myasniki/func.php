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

function fn_ee_change_myasniki_update_cart_products_post(&$cart, $product_data, $auth) {	
	if (isset($_REQUEST['dispatch']) && $_REQUEST['dispatch'] == 'order_management.update_totals' && $_REQUEST['result_ids'] == 'om_ajax_*') {
		foreach ($product_data as $k => $item) {
			$cart['products'][$k]['discount'] = 0;
			$cart['products'][$k]['display_price'] = (float)$item['base_price'];
			$cart['products'][$k]['discount_prc'] = 0;
			$cart['product_groups'][0]['products'][$k]['discount'] = 0;
			$cart['product_groups'][0]['products'][$k]['discount_prc'] = 0;
			$cart['product_groups'][0]['products'][$k]['display_price'] = $cart['products'][$k]['base_price'];
		}
		$cart['discount'] = 0;
	}
}

function fn_ee_change_myasniki_calculate_cart_items($cart, &$cart_products, $auth, $apply_cart_promotions) {
	if (isset($_REQUEST['dispatch']) && $_REQUEST['dispatch'] == 'order_management.update_totals' && $_REQUEST['result_ids'] == 'om_ajax_*') {
		foreach ($cart_products as $k => $v) {
			unset($cart_products[$k]['discount']);
			unset($cart_products[$k]['discount_prc']);
			$cart_products[$k]['price'] = $cart_products[$k]['original_price'];
			$cart_products[$k]['out_of_stock_actions'] = 'N';
		}
	}
}