require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views

  # it "show action should render show template" do
  #   get :show, :id => User.first
  #   response.should render_template(:show)
  # end

  # it "edit action should render edit template" do
  #   get :edit, :id => User.first
  #   response.should render_template(:edit)
  # end

  # it "update action should render edit template when model is invalid" do
  #   User.any_instance.stubs(:valid?).returns(false)
  #   put :update, :id => User.first
  #   response.should render_template(:edit)
  # end

  # it "update action should redirect when model is valid" do
  #   User.any_instance.stubs(:valid?).returns(true)
  #   put :update, :id => User.first
  #   response.should redirect_to(user_url(assigns[:user]))
  # end
end
