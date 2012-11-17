$ ->
	capitalizeFirstLetter (string) ->
	return string.charAt(0).toUpperCase() + string.slice(1);
	
	phrases = $('.shandle').next().children().next(); #returns array
	
	for phrase in phrases
		phraseText = phrase.text();
		capitalizeFirstLetter(phraseText)
