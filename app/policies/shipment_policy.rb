class ShipmentPolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      # scope.all
      scope.where(user: user)
    end

  end

  def show?
    return record.user == user
  end

  def new?
    return create?
  end

  def create?
    return true
  end

  def edit?
    return update
  end

  def update?
    return record.user == user
  end

  def destroy?
    return record.user == user
  end

end
