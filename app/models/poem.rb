class Poem < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :title

  validates :body, presence: true
end
