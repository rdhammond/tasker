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

	function deleteCompleted() {
		$('#tasks')
			.find('.done:checked')
			.closest('.task')
			.remove();

		$('#confirm-delete-modal').modal('hide');
	}

	$(function() {
		$('.done').change(markTask);
		$('#confirm-delete').click(deleteCompleted);

		$('#tasks').sortable({
			handle: '.glyphicon'
		});
	});
	
})(jQuery);
