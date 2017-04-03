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

	function addToList(data) {
		$('#tasks').loadTemplate(
			$('#task-template'),
			data,
			{ append: true }
		);
	}

	function checkAnyTasks() {
		var $tasks = $('#tasks');

		if ($tasks.children('.task').length < 1) {
			$tasks.addClass('hidden');
			$('#no-tasks').removeClass('hidden');
		}
		else {
			$tasks.removeClass('hidden');
			$('#no-tasks').addClass('hidden');
		}
	}

	function addTask() {
		var data = {
			id: 12,
			text: $('#task-description').val()
		};

		addToList(data);
		checkAnyTasks();
		$('#add-task-modal').modal('hide');
	}

	function deleteCompleted() {
		$('#tasks').find('.done:checked')
			.closest('.task')
			.remove();

		checkAnyTasks();
		$('#confirm-delete-modal').modal('hide');
	}

	$(function() {
		$('#tasks').on('click', '.done', markTask);
		$('#confirm-add').click(addTask);
		$('#confirm-delete').click(deleteCompleted);
		$('#tasks').sortable({handle: '.glyphicon'});
	});
	
})(jQuery);
