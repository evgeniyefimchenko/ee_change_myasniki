{literal}
	<script>
		$(document).ready(function() {
				setInterval(function() {
					$('[name="__notify_department"]').parent().parent().hide();
					$('[name="__notify_user"]').prop('checked', false);
				}
				, 500);
		});
	</script>
{/literal}