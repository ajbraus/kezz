class ParagraphsController < ApplicationController
	
	def destroy
		@reading = Reading.find(params[:reading_id])
    @paragraph = @reading.paragraphs.find(params[:id])
    @paragraph.destroy
	end
end
