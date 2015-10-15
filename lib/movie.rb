class Movie
  attr_accessor :title, :release_date, :director, :summary

  MOVIES = []

  def initialize(title, release_date, director, summary)
    self.title = title
    self.release_date = release_date
    self.director = director
    self.summary = summary
    self.class.all << self
  end

  def url
    "#{title.downcase.gsub(' ', '_').gsub('\'',"")}.html"
  end

  def self.all
    MOVIES
  end

  def self.recent
    self.all.select {|movie| movie.release_date >= 2012}
  end

  def self.reset_movies!
    self.all.clear
  end

  def self.parse_movie_list
    file = File.read('spec/fixtures/movies.txt')
    file.each_line.map do |line|
      split_line = line.split(' - ')
      {
        title: split_line[0],
        release_date: split_line[1].to_i,
        director: split_line[2],
        summary: split_line[3].chomp
      }
    end
  end

  def self.make_movies!
    parse_movie_list.each do |movie_data|
      Movie.new(movie_data[:title],
                movie_data[:release_date],
                movie_data[:director],
                movie_data[:summary])
    end
  end

end