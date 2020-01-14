class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params.merge(api_key: SecureRandom.hex(13)))
    if user.save
      render json: UserSerializer.new(user), status: 201
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
