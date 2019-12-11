class ApplicationController < ActionController::Base

	layout :layout_by_resource

	private

  	def layout_by_resource
    	if devise_controller?
      		"devise_layout"
    	else
      		"application"
    	end
  	end

  	def after_sign_in_path_for(resource)
  		home_index_path
	  end

    def after_sign_out_path_for(resource_or_scope)
      user_session_path
    end
end
