unless user = User.find_by(email: 'test@foggy.com')
  user = User.create(email: 'test@foggy.com', password: 'password')
end

# [
#   "Scuba",
#   "Burningman",
#   "Hiking",
#   "Snowboarding"
# ].each do |list_name|
#   List.create!(
#     name: list_name,
#     user: user
#   )
# end
