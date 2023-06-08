<?php
if (!defined('BOOTSTRAP')) { die('Access denied'); }

use Tygh\Registry;
use Tygh\Debugger;

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

function fn_ee_change_myasniki_update_cart_products_pre(&$cart, $product_data, $auth) {	
	if (isset($_REQUEST['dispatch']) && $_REQUEST['dispatch'] == 'order_management.update_totals' && $_REQUEST['result_ids'] == 'om_ajax_*') {
		// file_put_contents(__DIR__ . '/logs_pre.txt', 'update_cart_products_pre1:' . PHP_EOL . 'CART:' . PHP_EOL . var_export($cart['products'], true) . PHP_EOL .'PRODUCT DATA:' . PHP_EOL . var_export($product_data, true) . PHP_EOL);
		$cart['recalculate'] = true;	
		/*foreach ($product_data as $k => $item) {
			$cart['products'][$k]['discount'] = 0;
			$cart['products'][$k]['display_price'] = (float)$item['base_price'];
			$cart['products'][$k]['discount_prc'] = 0;
			$cart['products'][$k]['promotions'] = [];
			$cart['product_groups'][0]['products'][$k]['discount'] = 0;
			$cart['product_groups'][0]['products'][$k]['discount_prc'] = 0;
			$cart['product_groups'][0]['products'][$k]['display_price'] = $cart['products'][$k]['base_price'];
		}
		$cart['discount'] = 0;*/
	}
}
function fn_ee_change_myasniki_update_cart_products_post(&$cart, $product_data, $auth) {	
	if (isset($_REQUEST['dispatch']) && $_REQUEST['dispatch'] == 'order_management.update_totals' && $_REQUEST['result_ids'] == 'om_ajax_*') {
		/*foreach ($product_data as $k => $item) {
			$cart['products'][$k]['discount'] = 0;
			$cart['products'][$k]['display_price'] = (float)$item['base_price'];
			$cart['products'][$k]['discount_prc'] = 0;
			$cart['product_groups'][0]['products'][$k]['discount'] = 0;
			$cart['product_groups'][0]['products'][$k]['discount_prc'] = 0;
			$cart['product_groups'][0]['products'][$k]['display_price'] = $cart['products'][$k]['base_price'];
		}
		$cart['discount'] = 0;*/
	}
}

function fn_ee_change_myasniki_calculate_cart_items($cart, &$cart_products, $auth, $apply_cart_promotions) {
	/*
	if (isset($_REQUEST['dispatch']) && $_REQUEST['dispatch'] == 'order_management.update_totals' && $_REQUEST['result_ids'] == 'om_ajax_*') {
		foreach ($cart_products as $k => $v) {
			unset($cart_products[$k]['discount']);
			unset($cart_products[$k]['discount_prc']);
			$cart_products[$k]['price'] = $cart_products[$k]['original_price'];
			$cart_products[$k]['out_of_stock_actions'] = 'N';
		}
	}
	*/
}

/**
* Сортируем массив по ключу product_code
*/
function fn_ee_sort_cart_products($cart_products) {
	fn_array_sort_by_key($cart_products, 'product_code');
	// fn_calculate_cart_content ??? Нужны старые данные
	return $cart_products;
}

function fn_array_sort_by_key(&$array, $key, $direction = 'desc') {
    uasort($array, function($a, $b) use ($key, $direction) {
        $valueA = $a[$key];
        $valueB = $b[$key];

        if ($valueA == $valueB) {
            return 0;
        }
        
        if ($direction == 'asc') {
            return ($valueA < $valueB) ? -1 : 1;
        } else {
            return ($valueA > $valueB) ? -1 : 1;
        }
    });
}