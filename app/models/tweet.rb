class Tweet < ActiveRecord::Base
  validates :content, length: { minimum: 2 }
  belongs_to :user
end
