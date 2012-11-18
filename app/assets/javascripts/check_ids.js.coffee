# submit ids when click on the check order button
$ ->
	$("#checkOrder").click (e) ->
		e.preventDefault();

		reading_id = $(@).attr('title');
		ids = $(".getId")
			.map ->
				return this.id
			.get(); 

		$.post '/check_order',
			reading_id: reading_id
			ids: ids

