class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :password_edit, :password_update, :confirm_destroy]
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy, :password_edit, :password_update, :confirm_destroy]

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "Account created"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Account updated"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: "Account deleted"
  end

  def password_edit
  end

  def password_update
    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        redirect_to user_path(@user), notice: "Password changed"
      else
        render :password_edit
      end
    else
      @user.errors.add(:current_password, "is incorrect")
      render :password_edit
    end
  end

  def confirm_destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :age, :password, :password_confirmation)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    unless @user == current_user
      redirect_to tasks_path, alert: "Not authorized"
    end
  end
end
