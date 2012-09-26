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
    @option_set.option_groups.each do |option_group|
      option_group.options.build
    end
    @option_set.option_groups.build
  end

  # TODO: Implement removal of option groups / options.
  def update
    @option_set = OptionSet.find params[:id]

    # Reject empty option groups and options.
    params[:option_set][:option_groups_attributes].reject! do |option_group_id, option_group|
      option_group[:options_attributes].reject! do |option_id, option|
        option[:name].blank?
      end if option_group[:options_attributes]
      option_group[:name].blank?
    end

    if @option_set.update_attributes params[:option_set]
      redirect_to edit_admin_option_set_path(@option_set), notice: 'Updated option set.'
    else
      flash[:error] = 'Error while updating option set.'
      render :edit
    end
  end
end
