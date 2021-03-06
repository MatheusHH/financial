class TransferPolicy < ApplicationPolicy
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
  	record.user_id == user.id && user.admin?
  end

  def show_link_edit?
    user.admin?
  end
end
