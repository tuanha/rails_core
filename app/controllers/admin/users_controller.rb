class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :destroy, :update, :assign_role]

  def index
    if params[:query].present?
      @users = User.search params[:query], operator: "or", fields: [:email], order: {created_at: :desc}
    else
      @users = User.all.order("created_at DESC")
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = "User was successfully created."
        format.html { redirect_to admin_user_path(@user) }
      else
        flash.now[:danger] = @user.errors.full_messages
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_check_password(user_params)
        flash[:success] = "User was successfully updated."
        format.html { redirect_to admin_user_path(@user) }
      else
        flash.now[:danger] = @user.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      flash[:success] = "User was successfully destroyed."
      format.html { redirect_to admin_users_path }
    end
  end

  def assign_role
    if @user.update(role: params[:role])
      render json: {success: 'successfully'}
    else
      render json: {error: @user.errors.full_messages}
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) rescue nil
    redirect_to admin_users_path, :flash => {danger: "User does not exist"} unless @user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :role)
  end

end
