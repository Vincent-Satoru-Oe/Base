class UsersController < ApplicationController

  before_filter :signed_in_user,  only: [:edit, :update]
  before_filter :correct_user,    only: [:edit, :update]
  
  def index #needs to be for a specific group!!!!!!
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
    
   def new
    @user = User.new
     unless !signed_in?
       flash[:notice] = "Already signed in"
       redirect_to root_path
     end
   end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Update Successful!"
      redirect_to @user
    else
      render 'edit'
    end
  end

private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_url, notice: "Please sign in"
  end
end

def correct_user
  @user = User.find(params[:id])
  unless current_user?(@user)
    store_location
    redirect_to users_path, notice: 'Cannot access another users information'
  end
end

end