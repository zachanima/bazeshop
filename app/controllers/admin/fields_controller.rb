class Admin::FieldsController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @fields = @shop.fields
  end

  def new
    @field = @shop.fields.build
  end

  def create
    @field = @shop.fields.build params[:field]

    if @field.save
      redirect_to admin_shop_fields_path(@shop), notice: 'Created field.'
    else
      flash[:error] = 'Error while creating field.'
      render :new
    end
  end

  def edit
    @field = @shop.fields.find params[:id]
  end

  def update
    @field = @shop.fields.find params[:id]

    if @field.update_attributes params[:field]
      redirect_to admin_shop_fields_path(@shop), notice: 'Updated field.'
    else
      flash[:error] = 'Error while updating field.'
      render :edit
    end
  end

  def destroy
    @shop.fields.find(params[:id]).destroy
    redirect_to admin_shop_fields_path(@shop)
  end
end
