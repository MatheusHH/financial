class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
    	if user.admin?
      		scope.all
      	else
      		raise Pundit::NotAuthorizedError, 'Not allowed to view this action'
      	end
    end
  end

  def index?
  	user.admin?
  end

  def redirect_form?
    user.admin?
  end

  def new?
  	user.admin?
  end

  def destroy?
    user.admin?
  end

  def role_field?
    user.admin?
  end

  def edit?
  	record.id == user.id
  end

  def permitted_attributes
  	if user.admin?
  		[:name, :email, :password, :password_confirmation, :role]
  	else
  		[:name, :email, :password, :password_confirmation]
  	end
  end
end