require 'test_helper'

module PleskKit
  class ResellerAccountsControllerTest < ActionController::TestCase
    setup do
      @reseller_account = reseller_accounts(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:reseller_accounts)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create reseller_account" do
      assert_difference('ResellerAccount.count') do
        post :create, reseller_account: { cname: @reseller_account.cname, login: @reseller_account.login, passwd: @reseller_account.passwd, pname: @reseller_account.pname }
      end
  
      assert_redirected_to reseller_account_path(assigns(:reseller_account))
    end
  
    test "should show reseller_account" do
      get :show, id: @reseller_account
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @reseller_account
      assert_response :success
    end
  
    test "should update reseller_account" do
      put :update, id: @reseller_account, reseller_account: { cname: @reseller_account.cname, login: @reseller_account.login, passwd: @reseller_account.passwd, pname: @reseller_account.pname }
      assert_redirected_to reseller_account_path(assigns(:reseller_account))
    end
  
    test "should destroy reseller_account" do
      assert_difference('ResellerAccount.count', -1) do
        delete :destroy, id: @reseller_account
      end
  
      assert_redirected_to reseller_accounts_path
    end
  end
end
