class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true
  validates_associated :tweets
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    all.find{|a| a.slug == slug}
  end

end
