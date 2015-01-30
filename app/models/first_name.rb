class FirstName < ActiveRecord::Base
  # Remember to create a migration!
  has_many :entries
  has_many :users, through: :entries

  validates :first_name, uniqueness: true
end
