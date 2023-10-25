<?php

use Tygh\Registry;

if (in_array($mode, ['update_details', 'update_status', 'm_delete', 'm_update', 'delete', 'remove_cc_info', 'modify_invoice'])) {
    $addon_settings = Registry::get('addons.ee_change_myasniki');
    if ($addon_settings['ee_change_myasniki_active'] == 'Y') {
        // Извлекаем текущее время
        $current_time = time();
        // Конвертируем timeon и timeoff в timestamp
        list($hour_on, $minute_on) = explode(':', $addon_settings['timeon']);
        $time_on = mktime($hour_on, $minute_on, 0);
        list($hour_off, $minute_off) = explode(':', $addon_settings['timeoff']);
        $time_off = mktime($hour_off, $minute_off, 0);
        // Проверяем, попадает ли текущее время в интервал
        if ($current_time >= $time_on && $current_time <= $time_off) {
            fn_set_notification('W', __('warning'), __('Редактирование заказов невозможно до ') . $addon_settings['timeoff']);
			return array(CONTROLLER_STATUS_REDIRECT, 'order_management.update');
        }
    }
}
