
user1 = User.create(email: 'test@foggy.com', password: 'password')
user2 = User.create(email: 'test2@foggy.com', password: 'password')

user1.lists.create(name: 'list1')
user2.lists.create(name: 'list2')


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
