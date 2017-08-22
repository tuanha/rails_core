class User::PagesController < UserController
  before_action :authenticate_user!

  def welcome
  end
end
