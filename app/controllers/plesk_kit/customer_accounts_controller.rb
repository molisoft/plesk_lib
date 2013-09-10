require_dependency "plesk_kit/application_controller"

module PleskKit
  class CustomerAccountsController < ApplicationController
    # GET /customer_accounts
    # GET /customer_accounts.json
    def index
      @customer_accounts = CustomerAccount.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @customer_accounts }
      end
    end
  
    # GET /customer_accounts/1
    # GET /customer_accounts/1.json
    def show
      @customer_account = CustomerAccount.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @customer_account }
      end
    end
  
    # GET /customer_accounts/new
    # GET /customer_accounts/new.json
    def new
      @customer_account = CustomerAccount.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @customer_account }
      end
    end
  
    # GET /customer_accounts/1/edit
    def edit
      @customer_account = CustomerAccount.find(params[:id])
    end
  
    # POST /customer_accounts
    # POST /customer_accounts.json
    def create
      @customer_account = CustomerAccount.new(params[:customer_account])
  
      respond_to do |format|
        if @customer_account.save
          format.html { redirect_to @customer_account, notice: 'Customer account was successfully created.' }
          format.json { render json: @customer_account, status: :created, location: @customer_account }
        else
          format.html { render action: "new" }
          format.json { render json: @customer_account.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /customer_accounts/1
    # PUT /customer_accounts/1.json
    def update
      @customer_account = CustomerAccount.find(params[:id])
  
      respond_to do |format|
        if @customer_account.update_attributes(params[:customer_account])
          format.html { redirect_to @customer_account, notice: 'Customer account was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @customer_account.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /customer_accounts/1
    # DELETE /customer_accounts/1.json
    def destroy
      @customer_account = CustomerAccount.find(params[:id])
      @customer_account.destroy
  
      respond_to do |format|
        format.html { redirect_to customer_accounts_url }
        format.json { head :no_content }
      end
    end
  end
end
