getIds = () -> 
	Ids = $(".getId")
		.map ->
			return this.id
		.get(); 