class Department < ActiveRecord::Base
  belongs_to :division
  belongs_to :user
  has_many :users
end
