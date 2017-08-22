class AdminController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_left_menus

  private

  def check_admin
    redirect_to '/', :flash => {danger: "You aren't as admin"} unless current_user.role.admin?
  end

  def set_left_menus
    parents = BackendMenu.where('parent_id IS NULL OR parent_id = ?', 0).order(:display_order)
    menus = generate_menu(parents)
    parents.each do |parent|
      children = BackendMenu.where(parent_id: parent.id).order(:display_order)
      if children.count > 0
        menus[parent.name]['children'] = generate_menu(children)
      end
    end
    @left_menus = menus
  end

  def generate_menu(menu_input)
    menu_output = Hash.new
    menu_input.each do |menu|
      menu_output[menu.name] = Hash[
        'icon' => menu.icon,
        'url' => menu.url,
        'highlight' => menu.highlight
      ]
    end
    menu_output
  end
end
