class Sentance < ActiveRecord::Base
  belongs_to :paragraph
  has_many :phrases, dependent: :destroy
  attr_accessible :position

  acts_as_list scope: :paragraph
end
