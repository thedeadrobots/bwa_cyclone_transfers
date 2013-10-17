class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]


  def index
    @users = User.paginate(page: params[:page])
    #@user = User.all
    @title = "All Users"
  end

  def show
    @user = User.find(params[:id])
    @bankaccounts = @user.bankaccounts
    @bankaccount = current_user.bankaccounts.build if signed_in?
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def create
    ip = request.remote_ip
    @user = User.new(params[:user].merge(:ip_address => ip))
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to Cyclone!" }
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def search
    #@users = User.paginate(page: params[:page], :conditions => "email = '#{params[:search]}'")

    #@users = User.find(:all, :conditions => "name = '#{params[:search]}'")
    @users = User.all(:conditions => "email LIKE '%#{params[:search]}%' OR name LIKE '%#{params[:search]}%'")
    if params[:search].match /\W/
      render 'users/search_results_inj'
    else
      render 'users/search_results'
    end

  end


  def upload
    uploaded_io = params[:bankaccount][:bankstatement]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read)
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end

