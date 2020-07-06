class SessionsController < ApplicationController
    include ApplicationHelper
    #skip_before_action :require_login, only: [:new, :create, :welcome]
  
    def new
      @user = User.new
      render 'login'
    end
  
    def create
      @user = User.find_by(username: params[:session][:username])
      if @user && @user.authenticate(params[:session][:password])
         session[:user_id] = @user.id
         flash[:notice] = "Logged in successfully"
         redirect_to user_path(@user)
      else
          flash[:alert] = "Invalid username/password"
          redirect_to new_user_path
      end
   end

   def create_from_github
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.username = auth['info']['nickname']
      u.password = SecureRandom.hex
    end 
    
    session[:user_id] = @user.id
    flash[:notice] = "Logged in with Github!"
    redirect_to user_path(@user)
    # binding.pry
    # pp request.env['omniauth.auth']
    # session[:name] = request.env['omniauth.auth']['info']['nickname']
    # session[:omniauth_data] = request.env['omniauth.auth']
    # redirect_to root_path


    #user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)     
    #session[:user_id] = user.id     redirect_to root_path, :notice => "Signed in!"
    end

  
    def delete
      session[:user_id] = nil
      flash[:notice] = "You have been logged out"
      redirect_to root_path
    end

    private

    def auth
      request.env['omniauth.auth']
    end
  end