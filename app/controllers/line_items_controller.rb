class LineItemsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @shop = Shop.find params[:shop_id]
    @order = current_user.orders.build
  end

  def create
    @shop = Shop.find params[:shop_id]
    @product = @shop.products.find params[:product_id]

    params[:variants].reject! { |variant_id| variant_id.blank? }
    variants = Variant.find(params[:variants])

    if variants.count < @product.option_sets.collect(&:optional).reject { |optional| optional }.count
      flash[:error] = 'Et kr&aelig;vet valg er ikke foretaget.'

    else
      @line_item = current_user.line_items.build(params[:line_item])
      @line_item.product = @product
      @line_item.product_name = @product.name
      @line_item.product_number = @product.number
      @line_item.product_supplier_number = @product.supplier_number
      @line_item.product_brand = @product.brand
      @line_item.gross_price = @product.gross_price if @product.gross_price
      @line_item.net_price = @product.net_price if @product.net_price
      variants.each do |variant|
        @line_item.variations.build(
          variant_id: variant.id,
          option_set_name: variant.option.option_group.option_set.name,
          option_name: variant.option.name,
          gross_price: variant.derived_gross_price,
          net_price: variant.derived_net_price
        )
        @line_item.gross_price += variant.derived_gross_price if variant.derived_gross_price
        @line_item.net_price += variant.derived_net_price if variant.derived_net_price
      end
      @line_item.gross_price *= @line_item.quantity
      @line_item.net_price *= @line_item.quantity
      @line_item.save
    end

    redirect_to shop_product_path(@shop, @product)
  end
end
