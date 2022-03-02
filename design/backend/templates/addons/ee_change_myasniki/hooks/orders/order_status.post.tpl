{if $addons.ee_change_myasniki.ee_change_myasniki_active == "Y"}
	{literal}
		<script>
			$(document).ready(function() {
				$('[name="notify_department"]').click();
				$('[name="__notify_department"], [name="notify_department"]').parent().parent().hide();
				//$('[id^="select_"][name="__notify_user"]').click();
			});
		</script>
	{/literal}
{/if}