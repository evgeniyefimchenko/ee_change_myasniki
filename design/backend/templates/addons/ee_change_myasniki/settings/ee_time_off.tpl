<script>
	(function(_, $) {		
		$.ceEvent('on', 'ce.commoninit', function(context) {			
			var $timePickerInputs = $('input[id*="addon_option_ee_change_myasniki_timeon_"], input[id*="addon_option_ee_change_myasniki_timeoff_"]', context);
			if ($timePickerInputs.length) {
				$timePickerInputs.attr('type', 'time');
			}
		});
	}(Tygh, Tygh.$));	
</script>