class Admin::AccessGroupsController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @access_groups = @shop.access_groups
  end

  def new
    @access_group = @shop.access_groups.build
  end

  def create
    @access_group = @shop.access_groups.build params[:access_group]

    if @access_group.save
      redirect_to admin_shop_access_groups_path(@shop), notice: 'Created access group.'
    else
      flash[:error] = 'Error while creating access group.'
      render :new
    end
  end

  def edit
    @access_group = @shop.access_groups.find params[:id]
  end
  
  def update
    @access_group = @shop.access_groups.find params[:id]

    if @access_group.update_attributes params[:user]
      redirect_to admin_shop_access_groups_path(@shop), notice: 'Updated access group.'
    else
      flash[:error] = 'Error while updating access group'
      render :edit
    end
  end

  def destroy
    @shop.access_groups.find(params[:id]).destroy
    redirect_to admin_shop_access_groups_path(@shop)
  end
end
