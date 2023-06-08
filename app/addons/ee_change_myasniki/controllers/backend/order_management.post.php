<?php
if ($mode == 'update' || $mode == 'add') {
	// Создаем массив, содержащий значения, которые нужно отсортировать
	// Так нельзя, ломается пересчёт при добавлении товара
	/*$product_codes = array_column($cart_products, 'product_code');

	// Создаем массив, определяющий порядок сортировки
	$sort_order = SORT_DESC;

	// Сортируем массив $cart_products по значению поля product_code в порядке убывания
	array_multisort($product_codes, $sort_order, $cart_products);*/
}