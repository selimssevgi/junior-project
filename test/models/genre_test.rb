require 'test_helper'

class GenreTest < ActiveSupport::TestCase

  def setup 
    @genre = Genre.new(genre: "Drama")
  end

  test "genre name should be valid" do
    assert @genre.valid?
  end

  test "genre name should be present" do
    @genre.genre = "  "
    assert_not @genre.valid?
  end

  test "genre name should be unique" do
    duplicate_genre = @genre.dup
    duplicate_genre.genre = @genre.genre.upcase
    @genre.save
    assert_not duplicate_genre.valid?
  end
end
