class UsersController < ApplicationController
  load_and_authorize_resource class: 'User'

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def request_validation
    @user = User.find params[:user_id]
    authorize! :request_validation, @user
    @user.request_validation!
    redirect_to user_path(@user), notice: 'Validation requested.'
  end
end
