class UserContext
  attr_reader :user, :pin

  def initialize(user, pin)
    @user = user
    @pin = pin
  end
end