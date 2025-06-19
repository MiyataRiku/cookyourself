class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
    def create
    end
    def new
      @users = User.all
    end
  
    def show
      @user = User.find(params[:id]) 
    end
end
