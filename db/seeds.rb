require 'csv'

CSV.foreach('db/last_names.csv') do |name|
  LastName.create(last_name: "#{name[0]}")
end

CSV.foreach('db/first_names.csv') do |name|
  FirstName.create(first_name: "#{name[0]}")
end
