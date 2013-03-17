namespace :db do
  desc "Erase and fill database with sample data"
  task populate: :environment do
    make_users
    make_libraries
    make_readings
  end
end

def make_users
  10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password
                 )
  end
end

def make_libraries
  users = User.all(limit: 6)
  10.times do |n|
    name  = "Awesome Library"
    description = Faker::Lorem.sentence(3)
    users.each do |user|
      user.libraries.create!(
                            name:name,
                            description:description
                            )
    end
  end
end

def make_readings
  libraries = Library.all
  30.times do |n|
    title  = "Awesome Reading #{n}"
    content = Faker::Lorem.paragraphs
    author = Faker::Name.name
    summary = Faker::Lorem.paragraph
    rating = 5
    sentencely = true
    phrasely = true
    paragraphly = true

    libraries.each do |library|
      library.readings.create!(
                 title:title,
                 content:content,
                 author:author,
                 summary:summary,
                 rating:rating,
                 sentencely:sentencely,
                 phrasely:phrasely,
                 paragraphly:paragraphly
                 )
    end
  end
end