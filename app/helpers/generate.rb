def generate_first
  max = FirstName.count
  random_name_obj = FirstName.find(rand(1..max))
  random_name_obj.first_name
end

def generate_last
  max = LastName.count
  random_name_obj = LastName.find(rand(1..max))
  random_name_obj.last_name
end
