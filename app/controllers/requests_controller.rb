class RequestsController < ApplicationController
  def create
    @request = Request.create(request_params)
    if @request.save
      flash[:notice] = "Thank You! We'll be in touch!"
      redirect_to root_path
    else
      flash[:alert] = "Please fill in all form fields!"
      redirect_to root_path
    end

  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :insta_handle)
  end
end
