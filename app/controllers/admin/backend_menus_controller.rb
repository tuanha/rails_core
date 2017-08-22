class Admin::BackendMenusController < AdminController
  before_action :set_backend_menu, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def index
    @backend_menus = BackendMenu.all.order(:display_order)
  end

  def new
    @backend_menu = BackendMenu.new
  end

  def edit
  end

  def create
    @backend_menu = BackendMenu.new(backend_menu_params)
    @backend_menu.level = backend_menu_params['parent_id'].blank? ? 0 : (BackendMenu.find(backend_menu_params['parent_id']).level + 1)
    respond_to do |format|
      if @backend_menu.save
        flash[:success] = 'Backend menu was successfully created.'
        format.html { redirect_to admin_backend_menus_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @backend_menu.level = backend_menu_params['parent_id'].blank? ? 0 : (BackendMenu.find(backend_menu_params['parent_id']).level + 1)
      if @backend_menu.update(backend_menu_params)
        flash[:success] = 'Backend menu was successfully updated.'
        format.html { redirect_to admin_backend_menus_path  }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @backend_menu.destroy
    respond_to do |format|
      flash[:success] = 'Backend menu was successfully destroyed.'
      format.html { redirect_to admin_backend_menus_path }
    end
  end

  def ajax_update_position
    id_data = ActiveSupport::JSON.decode(params[:pid]).drop(1)
    id_data.each_with_index do |item , index|
      row = BackendMenu.find(item)
      row.display_order = index
      row.save
    end
    respond_to do |format|
      format.json{ render json: id_data}
    end
  end

  private
    def set_backend_menu
      @backend_menu = BackendMenu.find(params[:id])
    end

    def backend_menu_params
      params.require(:backend_menu).permit(:parent_id, :name, :icon, :highlight, :url, :display_order)
    end
end
