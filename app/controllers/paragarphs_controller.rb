class ParagraphsController < ApplicationController

	def index
  	@paragraphs = Paragraph.all(:order => 'position')
	end

	def destroy
		@reading = Reading.find(params[:reading_id])
    @paragraph = @reading.paragraphs.find(params[:id])
    @paragraph.destroy
	end
end
