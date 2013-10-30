require 'test_helper'

class SheetfilesControllerTest < ActionController::TestCase
  setup do
    @sheetfile = sheetfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sheetfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sheetfile" do
    assert_difference('Sheetfile.count') do
      post :create, sheetfile: { day: @sheetfile.day }
    end

    assert_redirected_to sheetfile_path(assigns(:sheetfile))
  end

  test "should show sheetfile" do
    get :show, id: @sheetfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sheetfile
    assert_response :success
  end

  test "should update sheetfile" do
    patch :update, id: @sheetfile, sheetfile: { day: @sheetfile.day }
    assert_redirected_to sheetfile_path(assigns(:sheetfile))
  end

  test "should destroy sheetfile" do
    assert_difference('Sheetfile.count', -1) do
      delete :destroy, id: @sheetfile
    end

    assert_redirected_to sheetfiles_path
  end
end
