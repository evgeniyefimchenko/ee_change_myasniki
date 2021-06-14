{literal}
	<script>
		$(document).ready(function() {
			$('[name="notify_department"]').click();
			$('[name="__notify_department"], [name="notify_department"]').parent().parent().hide();
			$('[name="__notify_user"]').click();
		});
	</script>
{/literal}