class Phrase < ActiveRecord::Base
  belongs_to :sentance
  attr_accessible :position, :text

  acts_as_list scope: :sentance
end
