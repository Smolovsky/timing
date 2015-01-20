require 'test_helper'

class SessionOfTimersControllerTest < ActionController::TestCase
  setup do
    @session_of_timer = session_of_timers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:session_of_timers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session_of_timer" do
    assert_difference('SessionOfTimer.count') do
      post :create, session_of_timer: { date: @session_of_timer.date, day_id: @session_of_timer.day_id, time_in_work: @session_of_timer.time_in_work }
    end

    assert_redirected_to session_of_timer_path(assigns(:session_of_timer))
  end

  test "should show session_of_timer" do
    get :show, id: @session_of_timer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @session_of_timer
    assert_response :success
  end

  test "should update session_of_timer" do
    patch :update, id: @session_of_timer, session_of_timer: { date: @session_of_timer.date, day_id: @session_of_timer.day_id, time_in_work: @session_of_timer.time_in_work }
    assert_redirected_to session_of_timer_path(assigns(:session_of_timer))
  end

  test "should destroy session_of_timer" do
    assert_difference('SessionOfTimer.count', -1) do
      delete :destroy, id: @session_of_timer
    end

    assert_redirected_to session_of_timers_path
  end
end
