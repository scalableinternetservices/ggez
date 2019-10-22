class UsersController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user.id)
      redirect_to @user, notice: 'Account was successfully created.'
    else
      render :new
    end

  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.resumes.each(&:destroy)
    @user.destroy
    log_out
    redirect_to root_path, notice: 'Account was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path if !logged_in? || @user != current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :industry, :password, :password_confirmation)
    end
end
