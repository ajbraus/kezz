class Sentance < ActiveRecord::Base
  belongs_to :paragraph
  has_many :phrases, dependent: :destroy
  attr_accessible :position, :paragraph_id

  acts_as_list scope: :paragraph

  def sort
  	params[:sentances].each_with_index do |id, index|
  		Sentance.update_all(['position=?', index+1], ['id=?', id])
  	end
  	render nothing: true
  end

  def uncapitalize
    self[0, 1].downcase + self[1..-1]
  end


end
