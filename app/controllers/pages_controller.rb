class PagesController < ApplicationController
	def home
    @poem = Poem.new
    @in_progress = []
    @trending = []
    @recent = []
    
    @reading = Reading.find(1)

    @id_array = []
    @reading.paragraphs.each do |p| 
      @id_array.push(p.id)
      p.sentences.each do |s| 
        @id_array.push(s.id)
        s.phrases.each do |ph|
          @id_array.push(ph.id)
        end
      end
    end

	end
	def about
	end
	def contact
	end
end
