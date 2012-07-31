class Reading < ActiveRecord::Base
  belongs_to :library
  attr_accessible :author, :content, :rating, :summary, :title

  validates :author, :content, :title, presence: true
end
