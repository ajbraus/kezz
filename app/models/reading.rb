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
	    errors.add(:base, "You must pick at least one parser")
	  end
	end

  # def shuffle_p_and_s(r)
  #   r.paragraphs.shuffle.each do |p|
  #     p.sentances.shuffle
  #   end
  # end

  # def shuffle_p_and_ph(r)
  #   r.paragraphs.shuffle.each do |p|
  #     p.sentances.phrases.shuffle
  #   end
  # end

  # def shuffle_s_and_ph(r)
  #   r.paragraphs.each do |p|
  #     p.sentances.shuffle.each do |s|
  #       s.phrases.shuffle
  #     end
  #   end
  # end

  # def shuffle_all(r)
  #   r.paragraphs.shuffle.each do |p|
  #     p.sentances.shuffle.each do |s|
  #       s.phrases.shuffle
  #     end
  #   end
  # end

    # count how many elements and save that as a range in the session

    # scramble those element
end
