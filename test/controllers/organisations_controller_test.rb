# frozen_string_literal: true

require 'test_helper'

class OrganisationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organisation = organisations(:one)
  end

  test 'should get index' do
    get organisations_url, as: :json
    assert_response :success
  end

  test 'should create organisation' do
    assert_difference('Organisation.count') do
      post organisations_url, params: { organisation: { id: @organisation.id, org_name: @organisation.org_name } },
                              as: :json
    end

    assert_response :created
  end

  test 'should show organisation' do
    get organisation_url(@organisation), as: :json
    assert_response :success
  end

  test 'should update organisation' do
    patch organisation_url(@organisation),
          params: { organisation: { id: @organisation.id, org_name: @organisation.org_name } }, as: :json
    assert_response :success
  end

  test 'should destroy organisation' do
    assert_difference('Organisation.count', -1) do
      delete organisation_url(@organisation), as: :json
    end

    assert_response :no_content
  end
end
