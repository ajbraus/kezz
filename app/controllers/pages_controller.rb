class PagesController < ApplicationController
	before_filter :authenticate_user!, except: [:home]

	def home
		if user_signed_in?
			@libraries = current_user.libraries
		end	
	end

	def about
	end

	def contact
	end


end
