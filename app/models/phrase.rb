class Phrase < ActiveRecord::Base
  belongs_to :sentance
  attr_accessible :position, :text, :sentance_id

  acts_as_list :scope => :sentance

  def sort
  	params[:phrases].each_with_index do |id, index|
  		Phrase.update_all(['position=?', index+1], ['id=?', id])
  	end
  	render nothing: true
  end
end
