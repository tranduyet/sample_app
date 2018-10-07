class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :find_user, except: %i(new create index)

  def show; end

  def index
    @users = User.page(params[:page]).per Settings.controllers.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      flash[:danger] = t ".failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".des"
    else
      flash[:danger] = t ".dele_fail"
    end
     redirect_to users_url
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".please_login"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by params[:id]
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found_user"
    redirect_to users_url
  end
end
