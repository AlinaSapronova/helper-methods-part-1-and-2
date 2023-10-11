desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  pp "started create"
  Movie.destroy_all
  10.times do
  movie = Movie.new
  movie.title = Faker::Movie.title
  movie.description = Faker::Movie.quote
  movie.save
end
pp "created"
end
