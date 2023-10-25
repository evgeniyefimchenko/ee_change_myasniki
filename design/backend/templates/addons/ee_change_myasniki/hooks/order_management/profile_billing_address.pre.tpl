{if $runtime.mode == "add" && $user_data.user_type == "A"}
	{$user_data = false scope=parent}
{/if}
{if $addons.ee_change_myasniki.ee_change_myasniki_active == "Y"}
	{literal}
		<script>
			$(document).ready(function() {
				// Проверяем текущее время с интервалом
				var currentTime = new Date();
				var currentHours = currentTime.getHours();
				var currentMinutes = currentTime.getMinutes();
				var currentTimeInMinutes = currentHours * 60 + currentMinutes;
				var timeOn = "{/literal}{$addons.ee_change_myasniki.timeon}{literal}".split(":");
				var timeOnInMinutes = parseInt(timeOn[0]) * 60 + parseInt(timeOn[1]);
				var timeOff = "{/literal}{$addons.ee_change_myasniki.timeoff}{literal}".split(":");
				var timeOffInMinutes = parseInt(timeOff[0]) * 60 + parseInt(timeOff[1]);
				if (currentTimeInMinutes >= timeOnInMinutes && currentTimeInMinutes <= timeOffInMinutes) {
					$.ceNotification('show', {
					  type: 'N',
					 title: 'Предупреждение',
					 message: 'Редактирование заказов невозможно до ' + "{/literal}{$addons.ee_change_myasniki.timeoff}{literal}"
					});
				}
			});
		</script>
	{/literal}
{/if}