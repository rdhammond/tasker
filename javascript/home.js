(function($) {
	'use strict';

	function serialize($task) {
		return {
			_id: $task.data('id'),
			text: $task.find('.text').text(),
			done: $task.find('.done').is(':checked')
		};
	}

	function post(task, cb) {
		$.ajax({
			contentType: 'application/json',
			data: JSON.stringify(task),
			method: 'POST',
			success: cb,
			url: '/tasks'
		});
	}

	function put(task, cb) {
		$.ajax({
			contentType: 'application/json',
			data: JSON.stringify(task),
			method: 'PUT',
			success: cb,
			url: '/tasks/' + task._id
		});
	}

	function del(ids, cb) {
		$.ajax({
			contentType: 'application/json',
			data: JSON.stringify(ids),
			method: 'DELETE',
			success: cb,
			url: '/tasks'
		});
	}

	function addTask(task) {
		post(task, function(newTask) {
			$('#taskList').loadTemplate(
				$('#task-template'),
				newTask,
				{ append: true }
			);

			$('#tasks').removeClass('hidden');
			$('#no-tasks').addClass('hidden');
			$('.delete-finished').removeClass('hidden');
		});
	}

	function updateTask($task) {
		var task = serialize($task);

		put(task, function() {
			var $label = $task.find('label');

			if (task.done)
				$label.addClass('text-muted struck');
			else
				$label.removeClass('text-muted struck');
		});
	}

	function deleteTasks($tasks) {
		var ids = $tasks.map(function() {
			return $(this).data('id');
		})
		.get();

		del(ids, function() {
			$tasks.remove();

			if ($('#taskList .task').size() === 0) {
				$('#tasks').addClass('hidden');
				$('#no-tasks').removeClass('hidden');
				$('.delete-finished').addClass('hidden');
			}
		});
	}

	function onAjaxStart() {
		$('#error').addClass('hidden');
	}

	function onAjaxError() {
		$('#error').removeClass('hidden');
	}

	function onDoneChanged() {
		updateTask($(this).closest('.task'));
	}

	function onAddModalShow() {
		$('#task-description').val('');
	}

	function onConfirmAddClicked() {
		addTask({
			text: $('#task-description').val(),
			done: false
		});
		$('#add-task-modal').modal('hide');
	}

	function onConfirmDeleteClicked() {
		var $tasks = $('#taskList').children('.task')
			.has('.done:checked');

		deleteTasks($tasks);
		$('#confirm-delete-modal').modal('hide');
	}

	$(function() {
		$(document).ajaxStart(onAjaxStart)
			.ajaxError(onAjaxError);

		$('#taskList').sortable({handle: '.glyphicon'});
		$('#taskList').on('change', '.done', onDoneChanged);
		$('#add-task-modal').on('show.bs.modal', onAddModalShow);
		$('#confirm-add').click(onConfirmAddClicked);
		$('#confirm-delete').click(onConfirmDeleteClicked);
	});
	
})(jQuery);
