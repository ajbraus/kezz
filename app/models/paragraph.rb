class Paragraph < ActiveRecord::Base
  belongs_to :reading
  has_many :sentances, dependent: :destroy
  attr_accessible :position, :reading_id

  acts_as_list scope: :reading
end
