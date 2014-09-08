class Reading < ActiveRecord::Base
  belongs_to :library
  has_many :paragraphs, dependent: :destroy
  
  attr_accessible :author, 
  								:content, 
  								:rating, 
  								:summary, 
  								:title, 
  								:paragraphly, 
  								:sentencely,
  								:phrasely,
                  :source,
                  :library_id

  validates :author, :content, :title, presence: true

  validate :at_least_one

	def at_least_one
	  if %w(paragraphly sentencely phrasely).all?{|attr| self[attr].blank?}
	    errors.add(:base, "You must pick at least one parser")
	  end
	end

  def scramble
    @paragraphs = self.content.split(/\n/) #split on new line
    @paragraphs.each do |p| 
      if p.length > 1
        p.chomp
        @paragraph = self.paragraphs.build(reading_id: self.id)
        if @paragraph.save
          @sentences = p.split(/(?<=\. )|(?<=\? )|(?<=\! )|(?<=\" )/)
          @sentences.each do |s|
            @psentence = Paragraph.find(@paragraph.id)
            @sentence = @psentence.sentences.build(paragraph_id: @psentence.id)
            if @sentence.save
              @phrases = s.split(/(?<=\, )|(?<=\; )|(?<=\- )|(?<=\: )/)
              @phrases.each do |ph|
                while ph.start_with?(' ') do
                  ph = ph[1..-1]
                end
                #ph[0] = ph[0].downcase
                ph.chomp
                @sphrase = Sentence.find(@sentence.id)
                @phrase = @sphrase.phrases.build(text: ph, sentence_id: @sphrase.id)
                unless @phrase.save
                  return nil #phrase not saved
                end
              end
            else 
              return nil #sentance not saved
            end
          end
        else 
          return nil #paragraph not saved
        end
      end
    end
  end

  # def shuffle_p_and_s(r)
  #   r.paragraphs.shuffle.each do |p|
  #     p.sentences.shuffle
  #   end
  # end

  # def shuffle_p_and_ph(r)
  #   r.paragraphs.shuffle.each do |p|
  #     p.sentences.phrases.shuffle
  #   end
  # end

  # def shuffle_s_and_ph(r)
  #   r.paragraphs.each do |p|
  #     p.sentences.shuffle.each do |s|
  #       s.phrases.shuffle
  #     end
  #   end
  # end

  # def shuffle_all(r)
  #   r.paragraphs.shuffle.each do |p|
  #     p.sentences.shuffle.each do |s|
  #       s.phrases.shuffle
  #     end
  #   end
  # end

    # count how many elements and save that as a range in the session

    # scramble those element
end
