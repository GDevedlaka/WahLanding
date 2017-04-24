class RequestsController < ApplicationController

  def reference
    @request = Request.new(request_params)
  end

  def create
    @request = Request.create(request_params)
    raise
    if @request.save
      # flash[:notice] = "Thank You! We'll be in touch!"
    else
      flash[:alert] = "Error! Please fill in al fields correctly!"
      redirect_to root_path
    end

  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :insta_handle, :reference)
  end
end
