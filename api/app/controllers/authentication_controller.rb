class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :login
  
  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      # Redirect to appropriate dashboard based on user role
      if user.admin?
        user.update(role: 'admin')
        # Login as admin
        token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
        render json: { message: "Logged in successfully as admin", user: user, token: token }
      else
        user.update(role: 'student')
        # Login as student
        token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
        render json: { message: "Logged in successfully as student", user: user, token: token }
      end
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
