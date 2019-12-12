class SupplierPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
      	scope.all
      else
      	scope.where(user: user)
      end
    end
  end

  def destroy?
  	record.user_id == user.id
  end

  def edit?
  	record.user_id == user.id
  end
end
