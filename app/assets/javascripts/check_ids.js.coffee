# submit ids when click on the check order button
$ ->
	$("#checkOrder").click (e) ->
		e.preventDefault();

		reading_id = $(@).attr('title');
		absolute_ids = $(".getId")
			.map ->
				return this.id
			.get();
		
		relative_ids = {}
		paragraphs = $('.reading').children('p')
		for paragraph in paragraphs
			paragraph_id = $(paragraph).attr('id')
			sentences = $(paragraph).children('span')
			sentence_ids = {}
			for sentence in sentences
				sentence_id = $(sentence).attr('id')
				phrases = $(sentence).children('span')
				phrase_ids = []
				for phrase in phrases
					phrase_id = $(phrase).attr('id')
					phrase_ids.push(phrase_id)
				sentence_ids[sentence_id] = phrase_ids
			relative_ids[paragraph_id] = sentence_ids
			

			#myMap[keyVal] = objVal
		#relative_ids_json = JSON.stringify(relative_ids);

    # @relative_ids = { "paragraph_id_1" => { "sentence_id_1" => ["phrase_id_1", "phrase_id_2", "phrase_id_3"], "sentence_id_2" => ["phrase_id_4"] }, "paragraph_id_2" =>  }
    # @relative_ids[0] = "paragraph_id_1"
    # @relative_ids[0][0] = "setntence_id_1"
    # @relative_ids[0][0][0] = "phrase_id_1"
    # @relative_ids[0][0][1] = "phrase_id_2"

		$.post '/check_order',
			reading_id: reading_id
			absolute_ids: absolute_ids
			relative_ids: relative_ids
