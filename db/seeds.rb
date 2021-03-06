# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
for i in 1..50
  name = Faker::Name.first_name
  email = Faker::Internet.safe_email(name)
  message = Faker::TvShows::BojackHorseman.tongue_twister

  user = User.new
  user.name = name
  user.email = email

  if user.save
    p "Saved user ##{i}: #{name} (#{email})"
    for ii in 1..50
      article = Article.new
      article.title = Faker::Book.title
      article.user = user
      article.content = Faker::Lorem.paragraph
      if article.save
        p "Article ##{ii} saved for #{name}"
      else
        p article.errors
      end
    end
  else
    p user.errors
  end

  for iii in 1..10
    comment = Comment.new
    comment.user = user
    comment.article = article
    comment.message = message
    if comment.save
      p "Comment ##{iii} saved for #{article} and #{name}"
    else
      p comment.errors
    end
  end
end

