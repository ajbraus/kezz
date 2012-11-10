class Paragraph < ActiveRecord::Base
  belongs_to :reading
  has_many :sentences, dependent: :destroy
  attr_accessible :position, :reading_id

  acts_as_list scope: :reading

  def sort
  	params[:paragraphs].each_with_index do |id, index|
  		Paragraph.update_all(['position=?', index+1], ['id=?', id])
  	end
  	render nothing: true
  end

end
