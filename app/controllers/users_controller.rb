class UsersController < ApplicationController
  add_flash_types :info, :error, :warning

  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
  end

  def update
      if @user.update(user_params)
        redirect_to @user, notice: I18n.t('controllers.users.updated')
      else
        render :edit
      end
  end

  # DELETE /users/1
  def destroy
    message = { notice: I18n.t('controllers.users.destroyed') }
      @user.destroy

    redirect_to root_path, message
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
