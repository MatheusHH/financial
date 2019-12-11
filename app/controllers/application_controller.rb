class ApplicationController < ActionController::Base
  include Pundit

	layout :layout_by_resource

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    #def user_not_authorized(exception)
    #  policy_name = exception.policy.class.to_s.underscore

    #  flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    #  redirect_to(request.referrer || root_path)
    #end
end
