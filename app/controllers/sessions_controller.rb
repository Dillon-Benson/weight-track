require 'bcrypt'

class SessionsController < ApplicationController
  def new           # GET /login      renders a form for a user to be logged in
    if current_user       # if user is already logged in
      redirect_to :controller => "workouts", :action => "all"     # show all workouts
    end
  end

  def create        # POST /login      create a new session for a user
  	@user = User.where(:username => params[:username])[0]    # find user by username
  	if !@user.nil? && BCrypt::Password.new(@user.password) == params[:password]     # check if password meets hash algorithm and username was found
  		session[:current_user_id] = @user.id            # create user session
  		redirect_to "/"       # redirect to home
  	else
  		render :action => "new"     # bad login
  	end
  end

  def destroy     # GET(should be DELETE) /logout      destroys a user session
    if current_user       # only if a user is already logged in
      session[:current_user_id] = nil     # destroy session
      redirect_to "/"     # redirect to home
    else          # user isn't logged in
      render :action => "new"     # send user to login
    end
  end
end
