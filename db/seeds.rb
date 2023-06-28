require "faker"

puts "Creating previous data..."

Like.delete_all
Tweet.delete_all
User.delete_all

puts "Database cleared."

ActiveRecord::Base.connection.reset_pk_sequence!('likes')
ActiveRecord::Base.connection.reset_pk_sequence!('tweets')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

puts "Reseted ids"

puts "Seeding users and tweets..."

5.times do |index|

    user = User.new(email: "user#{index}@gmail.com",
                  username: Faker::Internet.unique.username(specifier:(1..16)),
                  name: Faker::Name.name,
                  password: "#{Faker::Internet.password(min_length: 6)}#{rand(1..9)}",
                  role: 0)

  user.avatar.attach(io: URI.open(Faker::Avatar.unique.image(size: "100x100", format: "jpg")), filename: "#{index}.jpg")
  p user.errors.full_messages unless user.save

  tweet = Tweet.create(body: Faker::Hacker.say_something_smart, user_id: user.id)

end

puts "Seeding of 5 users and 5 tweets completed."

puts "Seeding replies..."

Tweet.all.each do |tweet|
  users = User.all.to_a
  users.each do |user|
    reply = Tweet.create(body: Faker::Quote.matz, user_id: user.id)
    tweet.replies.push(reply)
  end
end
puts "Seeding of replies completed."

User.all.each do |user|
    liked_tweets = Tweet.all.sample(4)
    liked_tweets.each do |tweet|
      Like.create(user_id: user.id, tweet_id: tweet.id)
    end

end