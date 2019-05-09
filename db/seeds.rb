#define rights here

#define user roles 
roles = ["admin", "editor", "user"]
roles.each do |r|
  role = Role.find_or_create_by(name: r)
  #add correct rights here 

  #create a dummy user for this role
  user = User.find_or_initialize_by(email: "#{r}@test.com")
  user.attributes = {
    password: "Testtest123!",
    password_confirmation: "Testtest123!",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }
  user.save 
  UserRole.create(role: role, user: user)
end

#define categories
author = User.find_by(email: "editor@test.com")
categories = ["Lash Training", "Beauty Tips", "Product News"]
categories.each do |c| 
  category = Category.find_or_create_by(name: c)
  #add 10 articles per category
  10.times.each do |i| 
    Article.create(
      user: author,
      title: Faker::Lorem.words(4).join(" "),
      content: Faker::Lorem.paragraphs(10).join("<br />"),
      category: category,
      created_at: Faker::Date.between(1.year.ago, Date.today)
    )
  end 
end

