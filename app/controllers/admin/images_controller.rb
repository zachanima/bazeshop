class Admin::ImagesController < Admin::ApplicationController
  def destroy
    @image = Image.find params[:id]
    product = @image.product
    shop = product.shop
    @image.destroy
    redirect_to edit_admin_shop_product_path(shop, product), notice: 'Deleted image'
  end
  
  def sort
    params[:image].each_with_index do |id, index|
      Image.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
