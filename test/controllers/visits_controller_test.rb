require 'test_helper'

class VisitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visit = visits(:one)
  end

  test "should get index" do
    get visits_url, as: :json
    assert_response :success
    json_response=JSON.parse(response.body)
    assert_equal 2,json_response["firstURL"]
  end

  # test "should create visit" do
  #   assert_difference('Visit.count') do
  #     post visits_url, params: { visit: { bounce: @visit.bounce, browser: @visit.browser, country: @visit.country, device: @visit.device, ip: @visit.ip, keyword: @visit.keyword, referer: @visit.referer, retention: @visit.retention, domain: @visit.domain, version: @visit.version } }, as: :json
  #   end

  #   assert_response 201
  # end

  test "should show visit" do
    get visit_url(@visit), as: :json
    assert_response :success
  end

  test "should update visit" do
    patch visit_url(@visit), params: { visit: { bounce: @visit.bounce, browser: @visit.browser, country: @visit.country, device: @visit.device, ip: @visit.ip, keyword: @visit.keyword, referer: @visit.referer, retention: @visit.retention, domain: @visit.domain, version: @visit.version } }, as: :json
    assert_response 200
  end

  test "should destroy visit" do
    assert_difference('Visit.count', -1) do
      delete visit_url(@visit), as: :json
    end

    assert_response 204
  end
end
