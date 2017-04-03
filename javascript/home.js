(function($) {
	'use strict';

	function markTask() {
		var $this = $(this);
		var $label = $this.closest('label');

		if ($this.prop('checked')) {
			$label.addClass('text-muted struck');
		}
		else {
			$label.removeClass('text-muted').removeClass('struck');
		}
	}

	$(function() {
		$('.done').change(markTask);

		$('#tasks').sortable({
			handle: '.glyphicon'
		});
	});
	
})(jQuery);
