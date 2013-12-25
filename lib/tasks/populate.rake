require 'faker'

def create_node_by category
  node = Node.new
  node.title = Faker::Lorem.sentence(rand(5..16))
  node.description = Faker::Lorem.paragraph
  node.contact = contact
  node.category = category
  node.email = Faker::Internet.email
  node.city = eskisehir
  node.status = "published"
  node.save
  node
end

def eskisehir
  City.find_by name: "Eskişehir"
end

def contact
  [Faker::Address.street_address,
  Faker::Address.street_name,
  Faker::Address.secondary_address,
  Faker::Address.zip_code,
  Faker::Address.city,
  Faker::Address.building_number].join(" ")
end

desc "Populate database"
task :populate => :environment do
    
  p Rails.env

  Category.all.each do |category|
    rand(1..100).times do
      p create_node_by category
    end
  end

end
