require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request" do
    assert_difference('Request.count') do
      post :create, request: { blood_bags: @request.blood_bags, blood_type: @request.blood_type, contact_name: @request.contact_name, due_date: @request.due_date, email: @request.email, hospital_adress: @request.hospital_adress, hospital_phone: @request.hospital_phone, national_id: @request.national_id, patient_name: @request.patient_name, req_type: @request.req_type }
    end

    assert_redirected_to request_path(assigns(:request))
  end

  test "should show request" do
    get :show, id: @request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request
    assert_response :success
  end

  test "should update request" do
    put :update, id: @request, request: { blood_bags: @request.blood_bags, blood_type: @request.blood_type, contact_name: @request.contact_name, due_date: @request.due_date, email: @request.email, hospital_adress: @request.hospital_adress, hospital_phone: @request.hospital_phone, national_id: @request.national_id, patient_name: @request.patient_name, req_type: @request.req_type }
    assert_redirected_to request_path(assigns(:request))
  end

  test "should destroy request" do
    assert_difference('Request.count', -1) do
      delete :destroy, id: @request
    end

    assert_redirected_to requests_path
  end
end
