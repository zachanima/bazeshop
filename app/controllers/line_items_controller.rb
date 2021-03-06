class LineItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_shop

  def index
    if current_user.line_items.current.count == 0
      redirect_to shop_path(@shop)
    end
    @order = current_user.orders.build
  end

  def create
    @product = @shop.products.find params[:product_id]

    if params[:variants]
      params[:variants].reject! { |variant_id| variant_id.blank? }
      variants = Variant.find(params[:variants])
      option_sets = variants.collect(&:option).collect(&:option_group).collect(&:option_set)
    else
      option_sets = Array.new
    end

    # Ensure all non-optional options have been selected.
    @product.option_sets.each do |option_set|
      unless option_set.optional or option_sets.include? option_set
        flash[:error] = 'Et kr&aelig;vet valg er ikke foretaget.'
        redirect_to shop_product_path(@shop, @product)
        return
      end
    end if @product.option_sets

    @line_item = current_user.line_items.build(params[:line_item])
    @line_item.product = @product
    variants.each do |variant|
      @line_item.variations.build(
        variant_id: variant.id,
        option_set_name: variant.option.option_group.option_set.name,
        option_name: variant.option.name,
        gross_price: variant.derived_gross_price,
        net_price: variant.derived_net_price
      )
    end if variants
    @line_item.set_values

    redirect_to shop_product_path(@shop, @product)
  end

  def destroy
    current_user.line_items.find(params[:id]).destroy

    redirect_to request.referer
  end

  def increment
    line_item = current_user.line_items.find(params[:id])
    line_item.quantity += 1
    line_item.set_values

    redirect_to request.referer
  end

  def decrement
    line_item = current_user.line_items.find(params[:id])
    line_item.quantity -= 1

    if line_item.quantity <= 0
      line_item.destroy
    else
      line_item.set_values
    end

    redirect_to request.referer
  end
end
