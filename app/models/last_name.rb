class LastName < ActiveRecord::Base
  # Remember to create a migration!
  has_many :entries
  has_many :users, through: :entries

  validates :last_name, uniqueness: true
end
