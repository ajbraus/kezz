class sentence < ActiveRecord::Base
  belongs_to :paragraph
  has_many :phrases, dependent: :destroy
  attr_accessible :position, :paragraph_id

  acts_as_list scope: :paragraph

  def sort
  	params[:sentences].each_with_index do |id, index|
  		sentence.update_all(['position=?', index+1], ['id=?', id])
  	end
  	render nothing: true
  end

end
