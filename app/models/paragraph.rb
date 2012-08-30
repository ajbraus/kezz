class Paragraph < ActiveRecord::Base
  belongs_to :reading
  attr_accessible :position

  acts_as_list scope: :reading
end
