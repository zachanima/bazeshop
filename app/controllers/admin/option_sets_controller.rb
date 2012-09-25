class Admin::OptionSetsController < Admin::ApplicationController
  def index
    @option_sets = OptionSet.all
  end

  def new
    @option_set = OptionSet.new
  end

  def create
    @option_set = OptionSet.new params[:option_set]
    if @option_set.save
      redirect_to edit_admin_option_set_path(@option_set), notice: 'Created option set.'
    else
      flash[:error] = 'Error while creating option set.'
      render :new
    end
  end

  def edit
    @option_set = OptionSet.find params[:id]
  end

  def update
    @option_set = OptionSet.find params[:id]
    if @option_set.update_attributes params[:option_set]
      redirect_to edit_admin_option_set_path(@option_set), notice: 'Updated option set.'
    else
      flash[:error] = 'Error while updating option set.'
      render :edit
    end
  end
end
