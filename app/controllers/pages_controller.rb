class PagesController < ApplicationController
	before_filter :authenticate_user!, except: [:home]

	def profile
		@libraries = current_user.libraries
		@attempted_readings = []
		@completed_readings = []
	end

	def about
	end

	def contact
	end


end
