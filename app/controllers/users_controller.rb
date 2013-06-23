class UsersController < ApplicationController
  
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

end

