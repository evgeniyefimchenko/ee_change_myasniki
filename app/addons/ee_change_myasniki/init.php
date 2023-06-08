<?php

if (!defined('BOOTSTRAP')) { die('Access denied'); }

fn_register_hooks (
	'products_sorting',
	'get_products_pre',
	'update_cart_products_post',
	'update_cart_products_pre',
	'calculate_cart_items'
);
