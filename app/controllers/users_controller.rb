class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end


  def create
    begin
      user = User.create(username: params[:username], email:params[:email], password:params[:password], password_confirmation: params[:password_confirmation], phone_number: params[:phone_number], address: params[:address], zip_code: params[:zip_code])
      render json: user
    rescue ActionController::ParameterMissing => error
      render json: { error: error.message }, status: 422
    end
  end


  def update
    if User.exists?(params[:id])
      user = User.find(params[:id])
      user.username = params.fetch(:username, user.username)
      user.email = params.fetch(:email, user.email)
      user.password = params.fetch(:password, user.password)
      user.password_confirmation = params.fetch(:password_confirmation, user.password_confirmation)
      user.phone_number = params.fetch(:phone_number, user.phone_number)
      user.address = params.fetch(:address, user.address)
      user.zip_code = params.fetch(:zip_code, user.zip_code)
      render json: user
    else
      render json: { error: 'User not found' }, status: 404
    end
  end


  def destroy
    if User.exists?(params[:id])
    deleted_user = User.destroy (params[:id])
    render json: deleted_user
    else
      render json: { error: 'User not found' }, status: 404
    end
  end

  def get_pair
    paired_user = User.where(zip_code: params[:zip_code])
    render json: paired_user
  end

private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone_number, :address, :zip_code)
  end
end
