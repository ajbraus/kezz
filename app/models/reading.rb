class Reading < ActiveRecord::Base
  belongs_to :library
  has_many :paragraphs, dependent: :destroy
  
  attr_accessible :author, 
  								:content, 
  								:rating, 
  								:summary, 
  								:title, 
  								:paragraphly, 
  								:sentancely,
  								:phrasely

  validates :author, :content, :title, presence: true

  validate :at_least_one

	def at_least_one
	  if %w(paragraphly sentancely phrasely).all?{|attr| self[attr].blank?}
	    errors.add(:base, "message")
	  end
	end

  def reading_puzzle(reading)
    reading.paragraphs.each do |p|
      if reading.paragraphly
        scramble(p)
      else
        p.sentances.each do |s|
          if reading.sentancely
            scramble(s)
          else
            s.phrases.each do |ph|
              if reading.phrasely
                scramble(ph)
              end
            end
          end
        end
      end
    end
  end

  def reading_puzzle(reading)
    if reading.paragraphly
      reading.paragraphs.scramble
    elsif reading.sentancely
      reading.paragraphs.sentances.scramble
    elsif reading.phrasely
      reading.paragraphs.sentances.phrases.scramble
    elsif reading.paragraphly && reading.sentancely
      reading.scramble_p_and_s(reading)
    elsif reading.paragraphly && reading.phrasely
      reading.scramble_p_and_ph(reading)
    elsif reading.sentancely && reading.phrasely
      reading.scramble_s_and_ph(reading)
    end
  end

  def scramble_p_and_s(r)
    r.paragraphs.scramble.each do |p|
      p.sentances.scramble
    end
  end

  def scramble_p_and_ph(r)
    r.paragraphs.scramble.each do |p|
      p.sentances.phrases.scramble
    end
  end

  def scramble_s_and_ph(r)
    r.paragraphs.each do |p|
      p.sentances.scramble.each do |s|
        s.phrases.scramble
      end
    end
  end

  def scramble
    #take each element provided and fuck up its position
    #when do I log its real position? - upon create duh! 
    #so if I just compare ids to a range => 0..reading.paragraphs.count
  end

    # count how many elements and save that as a range in the session

    # scramble those element
end
