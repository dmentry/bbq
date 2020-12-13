class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # respond_to do |format|
      if @user.update(user_params)
        redirect_to @user, notice: I18n.t('controllers.users.updated')
        # format.html { redirect_to @user, notice: 'User was successfully updated.' }
        # format.json { render :show, status: :ok, location: @user }
      else
        render :edit
        # format.html { render :edit }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    redirect_to users_url, notice: I18n.t('controllers.users.destroyed')
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private

  def set_current_user
    @user = current_user
  end
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
