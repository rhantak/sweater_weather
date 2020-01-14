class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user &. authenticate(params[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: bad_credentials, status: 400
    end
  end

  private

  def bad_credentials
    {errors:
    [{
      "status": 400,
      "title": "Bad Credentials"
    }]}
  end
end
