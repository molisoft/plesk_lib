require 'test_helper'

module PleskKit
  class ServersControllerTest < ActionController::TestCase
    setup do
      @server = servers(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:servers)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create server" do
      assert_difference('Server.count') do
        post :create, server: { environment: @server.environment, ghostname: @server.ghostname, host: @server.host, password: @server.password, username: @server.username }
      end
  
      assert_redirected_to server_path(assigns(:server))
    end
  
    test "should show server" do
      get :show, id: @server
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @server
      assert_response :success
    end
  
    test "should update server" do
      put :update, id: @server, server: { environment: @server.environment, ghostname: @server.ghostname, host: @server.host, password: @server.password, username: @server.username }
      assert_redirected_to server_path(assigns(:server))
    end
  
    test "should destroy server" do
      assert_difference('Server.count', -1) do
        delete :destroy, id: @server
      end
  
      assert_redirected_to servers_path
    end
  end
end
