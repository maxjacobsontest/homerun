courses = [
  "English 3",
  "English 4",
  "Environmental Science",
  "French 3",
  "American Government/Civics",
  "Spanish 1"
]

courses.each do |course_name|
  course = Course.where(name: course_name).first || Course.create(name: course_name)
end

categories = [
  "Essay",
  "Quiz",
  "Test",
  "Assignment",
  "Speaking",
  "Discussion"
]

categories.each do |cat_name|
  category = Category.where(name: cat_name).first || Category.create(name: cat_name)
end

120.times do
  t = Task.new
  t.course = Course.all.sample
  t.category = Category.all.sample
  t.name = Faker::Lorem.sentence
  t.points = rand(10)
  t.save!
end

