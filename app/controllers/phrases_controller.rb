class PhrasesController < ApplicationController
	
	def destroy
		@sentance = Sentance.find(params[:reading_id])
    @phrase = @sentance.phrases.find(params[:id])
    @phrase.destroy
	end

	# def sort
	#   params[:phrases].each_with_index do |id, index|
	#     Phrase.update_all(['position=?', index+1], ['id=?', id])
	# 	end
	#   render :nothing => true
	# end
end