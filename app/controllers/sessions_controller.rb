class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			render 'new'
		else
      		flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      		render 'new'
    	end
	end

	def destroy
	end

end
