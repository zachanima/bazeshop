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
      @option_set.option_groups.create(name: @option_set.name)
      redirect_to edit_admin_option_set_path(@option_set), notice: 'Created option set.'
    else
      flash[:error] = 'Error while creating option set.'
      render :new
    end
  end

  def edit
    @option_set = OptionSet.find params[:id]
    @option_set.option_groups.each do |option_group|
      # Build 20 empty options.
      20.times do
        option_group.options.build
      end
    end
    @option_set.option_groups.build
  end

  # TODO: Implement removal of option groups / options.
  def update
    @option_set = OptionSet.find params[:id]

    # Reject and destroy empty option groups and options.
    params[:option_set][:option_groups_attributes].reject! do |id, option_group|
      option_group[:options_attributes].reject! do |id, option|
        if option[:name].blank?
          Option.destroy(option[:id]) if option[:id].to_i != 0
          true
        end
      end if option_group[:options_attributes]
      if option_group[:name].blank?
        OptionGroup.destroy(option_group[:id]) if option_group[:id].to_i != 0
        true
      end
    end

    if @option_set.update_attributes params[:option_set]
      redirect_to edit_admin_option_set_path(@option_set), notice: 'Updated option set.'
    else
      flash[:error] = 'Error while updating option set.'
      render :edit
    end
  end

  def sort
    params[:option_set].each_with_index do |id, index|
      OptionSet.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
