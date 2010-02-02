class UsersController < ApplicationController
  before_filter :require_user,    :only => [ :dashboard, :index, :show, :edit, :update, :destroy, :new, :create ]
  
  def dashboard
    @albums = current_user.albums
    @events = Log.all(:limit => 10, :order => "created_at desc")
  end
  
  def index
    @users = User.all(:order => "name asc")
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = params[:id].nil? ? current_user : User.find(params[:id])
    @events = @user.logs.all(:limit => 10, :order => "created_at desc")
  end
 
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    current_user.destroy
    flash[:notice] = "Your account has been cancelled"
    redirect_to login_url
  end
end