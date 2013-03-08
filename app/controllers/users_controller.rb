require 'bcrypt'

class UsersController < ApplicationController
  def new         # GET /users/new       renders form for a new user
    if current_user       # if a user is logged in
      redirect_to :controller => "sessions", :action => "destroy"     # destroy their session
    end
  	@user = User.new
  end

  def create      # POST /users/new       creates a new user
  	@user = User.new(params[:user])      # assign attributes to a new user
    @user.password = BCrypt::Password.create(params[:password])     # create a hashed password
  	if @user.save            # if a new user can be saved
      session[:current_user_id] = @user.id            # create user session
  		redirect_to "/"       # redirect to home
  	else
  		render :action => "new"       # bad user created
  	end
  end

  def update       # GET /users/update      updates currently logged in user
    if current_user       # check if user is logged in
      @user = User.find(current_user.id)        # find the user by the current_user's id
    else
      redirect_to :controller => "sessions", :action => "new"         # send user to login screen
    end
  end

  def change
    @user = User.find(current_user.id)      # find the user by the current_user's id
    if params[:password] != ""              # if user wants to change password
      if BCrypt::Password.new(@user.password) == params[:oldpassword]         # check if they know the old password
        @user.password = BCrypt::Password.create(params[:password])           # create a new password hash
      else
        render :action => "update"            # wrong old password
        return                # end method call to avoid multiple render and / or redirect_to
      end
    elsif params[:user][:avatar]        # if user wants to update their avatar
      @user.avatar = params[:user][:avatar]       # set avatar to new image
    end
    if @user.save           # if user can be saved
      redirect_to root_url  # redirect to home
    else            # cannot save user
      render :action => "update"        # try again
    end
  end
end
