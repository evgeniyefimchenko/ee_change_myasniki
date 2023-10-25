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
	// $sorting['code'] = array('description' => 'code', 'default_order' => 'desc');
}

function fn_ee_change_myasniki_get_products_pre(&$params, $items_per_page, $lang_code) {
	$params['match'] = 'all';
}

function fn_ee_change_myasniki_update_cart_products_pre(&$cart, &$product_data, $auth) {	
	// fn_print_die($product_data);
}

function fn_ee_change_myasniki_update_cart_products_post(&$cart, &$product_data, $auth) {
	// $cart['products'] = $product_data;
	// fn_print_die($cart);
	// fn_print_die($product_data); Тут скидка ещё есть! Посмотреть в foreach ($group['chosen_shippings'] as $shipping_key => $shipping) {
}

function fn_ee_change_myasniki_calculate_cart_items($cart, &$cart_products, $auth, $apply_cart_promotions) {
	
}


/**
* Сортируем массив по ключу product_code
*/
function fn_ee_sort_cart_products($cart_products) {
	fn_array_sort_by_key($cart_products, 'product_code');
	return $cart_products;
}

function fn_array_sort_by_key(&$array, $key) {
    uasort($array, function($a, $b) use ($key) {
        $valueA = (string)$a[$key];
        $valueB = (string)$b[$key];
        if ($valueA == $valueB) {
            return 0;
        }
		return strcmp($valueA, $valueB);
    });
}