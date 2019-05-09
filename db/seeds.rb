#define rights here
rights = [
  {name: "View Article", description: "Can view articles"},
  {name: "Edit Article", description: "Can edit articles"},
  {name: "Destroy Article", description: "Can destroy articles"},
  {name: "Create Article", description: "Can create articles"},
  {name: "Create User", description: "Can create users"},
  {name: "Edit User", description: "Can edit users"}
]

rights.each{|right| Right.create(right)}

#define user roles 
roles = ["admin", "editor", "user"]
roles.each do |r|
  role = Role.find_or_create_by(name: r)
  if r == "user"
    right_names = ["View Article"]
  elsif r == "editor"
    right_names = ["View Article", "Edit Article", "Destroy Article", "Create Article"]
  elsif r == "admin"
    right_names = ["Create User", "Edit User"]
  end 

  Right.where(name: right_names).each{|right| RoleRight.create(role: role, right: right)}

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
      content: Faker::Lorem.paragraphs(10).join(" "),
      category: category,
      created_at: Faker::Date.between(1.year.ago, Date.today)
    )
  end 
end

