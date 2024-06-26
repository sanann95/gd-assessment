class UsersController < ApplicationController
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
	  @user = User.find(params[:id])
	  if @user.update(user_params)
	    redirect_to users_path, notice: 'User was successfully updated.'
	  else
	    render :edit
	  end
	end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    
    if @user.articles.empty? && @user.comments.empty?
      @user.destroy
      redirect_to users_url, notice: 'User was successfully deleted.'
    elsif @user.articles.any?
      redirect_to users_url, alert: 'User has associated articles and cannot be deleted.'
    else
      redirect_to users_url, alert: 'User has associated comments and cannot be deleted.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :date_of_birth)
    end
end
