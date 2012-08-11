class Admin::ImagesController < Admin::ApplicationController
  def sort
    params[:image].each_with_index do |id, index|
      Image.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
