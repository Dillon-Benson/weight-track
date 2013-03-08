class WorkoutsController < ApplicationController
  def new           # GET /workouts/new     renders form for a new workout
  	if current_user        # if a user is logged in
  		@current_user = current_user      # store their information in an instance variable
  		@workout = Workout.new        # set up a new workout
  	else
  		redirect_to :controller => "sessions", :action => "new"       # redirect user to login screen
  	end
  end

  def create            # POST /workouts/new     creates an new workout
  	@workout = Workout.new(params[:workout])         # assign attributes to a new workout
  	@workout.user_id = current_user.id               # set owner of workout
  	if @workout.save                 # if a new workout can be saved
  		redirect_to "/"                # redirect to home
  	else
  		render :action => "new"       # bad workout created
  	end
  end

  def all         # GET /wokrouts/all    shows all workouts
  	if current_user        # if a user is logged in
  		@current_user = current_user        # store their information in a n instance variable
  	else
  		redirect_to :controller => "sessions", :action => "new"     # send user to login screen
  	end
  end

  def show        # GET /workouts/show/:id    shows a single workout
  	if current_user        # if user is logged in
  		@current_user = current_user      # store their information in an instance variable
      @workout = Workout.find(params[:id])
  	else
  		redirect_to :controller => "sessions", :action => "new"       # send user to login screen
  	end
  end

  def update      # GET /workouts/update/:id
    if current_user         # check if user is logged in
      @current_user = current_user        # store current_user information in a variable
      @workout = Workout.find(params[:id])          # find workout by id
    else          # user isn't logged in
      redirect_to :controller => "sessions", :actions => "new"        # send user to login screen
    end
  end

  def change      # PUT /workouts/update/:id
    # update each attribute
    @workout = Workout.find(params[:id])
    @workout.name = params[:workout][:name]
    @workout.weight = params[:workout][:weight]
    @workout.reps = params[:workout][:reps]
    @workout.sets = params[:workout][:sets]
    @workout.last_plateau_date = params[:workout][:last_plateau_date]
    if @workout.save        # if workout can be saved
      redirect_to root_url        # redirect to home
    else          # if workout cannot be saved
      render :action => "update"        # try again
    end
  end
end
