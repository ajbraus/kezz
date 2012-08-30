class Reading < ActiveRecord::Base
  belongs_to :library
  has_many :paragraphs
  has_many :sentances
  has_many :phrases
  
  attr_accessible :author, :content, :rating, :summary, :title

  validates :author, :content, :title, presence: true


  def create_reading(reading)
  	if reading.phrasely?
  		reading.content.split(/\,|\;|but|for|and|nor|or|yet|so|\(/) #split on commas, semicolons, and coordinating conjunctions

  		# not splitting on dashes (something to do with Unicode blah blah blah)
  		# what the fuck to do with oxfor commas!?
  	end

  	if reading.sentancely?
  		reading.content.split(/.\|\?/) #split on periods
    end
    
    if reading.paragraphly?
    	reading.content.split(/\n|\s/) #split on new line
    end

    #save in db as this cut up array
    #readings#show
    #add randomly id'ed html elements to it to identify its parts
    #log the array of random ids
    #jumble it up and display this in the view
    #coffee script and jquery to drag and drop
    
    #@reading_sentancely.collect { |rs| } #attach html tags to array elements
    #a.concat(a2) will concatinate two arrays together    

                                
  end

end
