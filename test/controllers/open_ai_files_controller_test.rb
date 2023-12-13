require "test_helper"

class OpenAiFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @open_ai_file = open_ai_files(:one)
  end

  test "should get index" do
    get open_ai_files_url, as: :json
    assert_response :success
  end

  test "should create open_ai_file" do
    assert_difference("OpenAiFile.count") do
      post open_ai_files_url, params: { open_ai_file: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show open_ai_file" do
    get open_ai_file_url(@open_ai_file), as: :json
    assert_response :success
  end

  test "should update open_ai_file" do
    patch open_ai_file_url(@open_ai_file), params: { open_ai_file: {  } }, as: :json
    assert_response :success
  end

  test "should destroy open_ai_file" do
    assert_difference("OpenAiFile.count", -1) do
      delete open_ai_file_url(@open_ai_file), as: :json
    end

    assert_response :no_content
  end
end
