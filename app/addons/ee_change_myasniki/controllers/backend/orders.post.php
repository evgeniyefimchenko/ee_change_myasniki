<?php
if ($mode == 'details') {
	$order_info = Tygh::$app['view']->getTemplateVars('order_info');
	$arr = $order_info['products'];
	fn_array_sort_by_key($arr, 'product_code');
	$order_info['products'] = $arr;
	Tygh::$app['view']->assign('order_info', $order_info);
}
