require 'test_helper'

class MoviesControllerTest < ActionController::TestCase

  def setup
    @movie = Movie.last
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get(:show, { 'id' => @movie.id })
    assert_response :success
  end

end
