class sentencesController < ApplicationController

	def index
  	@sentences = sentence.all(:order => &rsquo;position&rsquo;)
	end

	def destroy
		@reading = Reading.find(params[:reading_id])
    @paragraph = @reading.paragraphs.find(params[:id])
    @paragraph.destroy
	end

	# def sort
	#   params[:sentences].each_with_index do |id, index|
	#     sentence.update_all(['position=?', index+1], ['id=?', id])
	# 	end
	#   render :nothing => true
	# end
end