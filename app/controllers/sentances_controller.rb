class SentancesController < ApplicationController
	
	def destroy
		@reading = Reading.find(params[:reading_id])
    @paragraph = @reading.paragraphs.find(params[:id])
    @paragraph.destroy
	end

	# def sort
	#   params[:sentances].each_with_index do |id, index|
	#     Sentance.update_all(['position=?', index+1], ['id=?', id])
	# 	end
	#   render :nothing => true
	# end
end