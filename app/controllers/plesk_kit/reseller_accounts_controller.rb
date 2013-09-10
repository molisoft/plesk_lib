require_dependency "plesk_kit/application_controller"

module PleskKit
  class ResellerAccountsController < ApplicationController
    # GET /reseller_accounts
    # GET /reseller_accounts.json
    def index
      @reseller_accounts = ResellerAccount.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @reseller_accounts }
      end
    end
  
    # GET /reseller_accounts/1
    # GET /reseller_accounts/1.json
    def show
      @reseller_account = ResellerAccount.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @reseller_account }
      end
    end
  
    # GET /reseller_accounts/new
    # GET /reseller_accounts/new.json
    def new
      @reseller_account = ResellerAccount.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @reseller_account }
      end
    end
  
    # GET /reseller_accounts/1/edit
    def edit
      @reseller_account = ResellerAccount.find(params[:id])
    end
  
    # POST /reseller_accounts
    # POST /reseller_accounts.json
    def create
      @reseller_account = ResellerAccount.new(params[:reseller_account])
  
      respond_to do |format|
        if @reseller_account.save
          format.html { redirect_to @reseller_account, notice: 'Reseller account was successfully created.' }
          format.json { render json: @reseller_account, status: :created, location: @reseller_account }
        else
          format.html { render action: "new" }
          format.json { render json: @reseller_account.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /reseller_accounts/1
    # PUT /reseller_accounts/1.json
    def update
      @reseller_account = ResellerAccount.find(params[:id])
  
      respond_to do |format|
        if @reseller_account.update_attributes(params[:reseller_account])
          format.html { redirect_to @reseller_account, notice: 'Reseller account was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @reseller_account.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /reseller_accounts/1
    # DELETE /reseller_accounts/1.json
    def destroy
      @reseller_account = ResellerAccount.find(params[:id])
      @reseller_account.destroy
  
      respond_to do |format|
        format.html { redirect_to reseller_accounts_url }
        format.json { head :no_content }
      end
    end
  end
end
