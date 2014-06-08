require 'test_helper'

class DonorsControllerTest < ActionController::TestCase
  setup do
    @donor = donors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donor" do
    assert_difference('Donor.count') do
      post :create, donor: { age: @donor.age, blood_type: @donor.blood_type, email: @donor.email, latitude: @donor.latitude, longitude: @donor.longitude, name: @donor.name, password: @donor.password, phone_number: @donor.phone_number }
    end

    assert_redirected_to donor_path(assigns(:donor))
  end

  test "should show donor" do
    get :show, id: @donor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @donor
    assert_response :success
  end

  test "should update donor" do
    put :update, id: @donor, donor: { age: @donor.age, blood_type: @donor.blood_type, email: @donor.email, latitude: @donor.latitude, longitude: @donor.longitude, name: @donor.name, password: @donor.password, phone_number: @donor.phone_number }
    assert_redirected_to donor_path(assigns(:donor))
  end

  test "should destroy donor" do
    assert_difference('Donor.count', -1) do
      delete :destroy, id: @donor
    end

    assert_redirected_to donors_path
  end
end
