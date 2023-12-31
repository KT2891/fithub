class Admin::TrainingMenusController < ApplicationController
  before_action :set_training_menu, only: %i[status_update edit update destroy]
  
  def index
    @training_menus = TrainingMenu.with_training_part
  end

  def new
    @training_menu = TrainingMenu.new
    @training_menu.training_parts.build
  end

  def create
    @training_menu = TrainingMenu.new(training_menu_params)
    if @training_menu.save
      training_part_create
      redirect_to admin_training_menus_path, notice: t("success-create-training")
    else
      render :new, alert: t("error-create")
    end
  end

  def edit
    @training_menu.training_parts.build unless @training_menu.training_parts.present?
  end
  
  def status_update
    @training_menu.update(training_menu_params)
    redirect_to admin_training_menus_path, notice: "ステータスを更新しました"
  end

  def update
    @training_menu.update(training_menu_params)
    @training_menu.training_parts.destroy_all
    training_part_create
    redirect_to admin_training_menus_path, notice: t("success-training-status-edit")
  end

  def destroy
    @training_menu.destroy
    redirect_to admin_training_menus_path
  end


  private

  def training_part_create
    params[:training_part][:training_part].each do |part|
      @training_menu.training_parts.create(training_part: part)
    end
  end

  def training_menu_params
    params.require(:training_menu).permit(:name, :explanation, :status, training_parts_attributes: [:id, :name, :training_part, :_destroy])
  end

  def training_part_params
    params.require(:training_part).permit(:training_part, :description)
  end

  def set_training_menu
    @training_menu = TrainingMenu.find(params[:id])
  end
end
