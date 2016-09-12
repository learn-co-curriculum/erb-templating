require 'spec_helper'

describe 'Movie' do
  let(:title) { 'The Matrix' }
  let(:release_date) { 1999 }
  let(:director) { 'The Wachowski Brothers' }
  let(:summary) { 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.' }
  let(:the_matrix) { Movie.new(title, release_date, director, summary) }
  let(:pans_labyrinth) {Movie.new("Pan's Labyrinth", 2006, "Guillermo del Toro", "In the fascist Spain of 1944, the bookish young stepdaughter of a sadistic army officer escapes into an eerie but captivating fantasy world.")}
  let(:titles) {[
    "The Matrix",
    "The Lego Movie",
    "RoboCop",
    "The Wolf of Wall Street",
    "Frozen",
    "Logan's Run",
    "A Fish Called Wanda",
    "The Godfather",
    "Apocalypse Now",
    "The Sting",
    "Temple Grandin",
    "Gravity",
    "Empire of the Sun",
    "The Big Lebowski",
    "Pan's Labyrinth",
    "Unbreakable",
    "Gattaca",
    "The Dark Knight",
    "Donnie Darko",
    "Rescue Dawn",
    "The Prestige",
    "Memento",
    "Avatar",
    "Killing Them Softly",
    "300"
  ]}
  let(:release_dates) {[
    1999, 2014, 2014, 2013, 2013,
    1976, 1988, 1972, 1979, 1973,
    2010, 2013, 1987, 1998, 2006,
    2000, 1997, 2008, 2001, 2006,
    2006, 2000, 2009, 2012, 2006
  ]}
  let(:directors) {[
    "The Wachowski Brothers",
    "Phil Lord and Christopher Miller",
    "Jose Padilha",
    "Martin Scorsese",
    "Chris Buck and Jennifer Lee",
    "Michael Anderson",
    "Charles Crichton",
    "Francis Ford Coppola",
    "Francis Ford Coppola",
    "George Roy Hill",
    "Mick Jackson",
    "Alfonso Cuaron",
    "Steven Spielberg",
    "Joel and Ethan Coen",
    "Guillermo del Toro",
    "M. Night Shyamalan",
    "Andrew Niccol",
    "Christopher Nolan",
    "Richard Kelly",
    "Werner Herzog",
    "Christopher Nolan",
    "Christopher Nolan",
    "James Cameron",
    "Andrew Dominik",
    "Zack Snyder"
  ]}
  let(:recent_movies) {[
    "The Lego Movie",
    "RoboCop",
    "The Wolf of Wall Street",
    "Frozen",
    "Gravity",
    "Killing Them Softly"
  ]}

  context 'attributes' do
    it 'has a title' do
      expect(the_matrix.title).to eq(title)
    end

    it 'has a release date' do
      expect(the_matrix.release_date).to eq(release_date)
    end

    it 'has a director' do
      expect(the_matrix.director).to eq(director)
    end

    it 'has a summary' do
      expect(the_matrix.summary).to eq(summary)
    end
  end

  describe '#url' do
    it 'gives a url-friendly version of the title with the .html extension' do
      urls = ['the_matrix.html', 'the%20matrix.html']
      expect(urls).to include(the_matrix.url)
    end

    it 'makes URLs without using unsafe characters' do 
      pans_urls = ['pans_labyrinth.html','pan%27s_labyrinth.html', 'pan%27s%20labyrinth.html']
      expect(pans_urls).to include(pans_labyrinth.url)
    end
  end

  describe '::all' do
    before do
      @the_matrix = Movie.new(title, release_date, director, summary)
    end

    it 'returns all movie instances' do
      expect(Movie.all).to include(@the_matrix)
    end
  end

  describe '::reset_movies!' do
    before do
      @the_matrix = Movie.new(title, release_date, director, summary)
    end

    it 'resets the movie count to zero' do
      Movie.reset_movies!
      expect(Movie.all.size).to eq(0)
    end
  end

  describe '::make_movies!' do
    before(:all) do
      Movie.make_movies!
    end

    it 'parses a file with a list of movies into movie instances' do
      expect(Movie.all.size).to eq(25)
    end

    it 'correctly assigns titles' do
      expect(Movie.all.map {|movie| movie.title}).to match_array(titles)
    end

    it 'correctly assigns release dates' do
      expect(Movie.all.map {|movie| movie.release_date}).to match_array(release_dates)
    end

    it 'correctly assigns directors' do
      expect(Movie.all.map {|movie| movie.director}).to match_array(directors)
    end
  end

  describe '::recent' do
    before(:all) do
      Movie.reset_movies!
      Movie.make_movies!
    end
    it 'returns movies released during or after 2012' do
      recent_titles = Movie.recent.map {|movie| movie.title}
      expect(recent_titles).to match_array(recent_movies)
    end
  end
end
