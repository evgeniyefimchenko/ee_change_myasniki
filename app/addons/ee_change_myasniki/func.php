<?php
if (!defined('BOOTSTRAP')) { die('Access denied'); }

use Tygh\Registry;

function fn_ee_change_myasniki_install() {
	/*
	*Проверка на существование доп полей в существующих таблицах
	$db_name = Registry::get("config.db_name");
	$external_id = false;
	$external_id = db_get_field('SELECT 101 FROM INFORMATION_SCHEMA.COLUMNS WHERE `table_name` = "?:product_features" AND `table_schema` = "' . $db_name . '" AND `column_name` = "external_id"'); 	
	if (!$external_id) {
		db_query('ALTER TABLE `?:product_features` ADD `external_id` varchar(255) NULL DEFAULT NULL');	
	}*/
}

function fn_ee_change_myasniki_uninstall() {
	return true;
}
