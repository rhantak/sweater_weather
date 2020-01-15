class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params.merge(api_key: SecureRandom.hex(13)))
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: error_message(user), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def error_message(user)
    {errors:
      [{
        "status": 401,
        "detail": "#{user.errors.full_messages.to_sentence}"
        }]
    }
  end
end
