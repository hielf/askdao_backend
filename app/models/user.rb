class User < ActiveRecord::Base
  has_many :messages
  has_many :videos
  has_many :articles
end
