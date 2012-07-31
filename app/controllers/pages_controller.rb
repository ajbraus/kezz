class PagesController < ApplicationController
	before_filter :authenticate_user!, except: [:home]
	def landing
	end

	def home
		@libraries = current_user.libraries
	end

	def about
	end

	def contact
	end


end
