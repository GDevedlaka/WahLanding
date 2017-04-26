class RequestsController < ApplicationController

  def reference
    @request = Request.new(request_params)

    if !(@request.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i && @request.name.length > 2)
      #flash[:alert] = "Please make sure your email is correct and your name is more than 2 characters!"
      #redirect_to root_path
    elsif Request.where(email: @request.email).count > 0
      #flash[:alert] = "#{@request.email} has already registered!"
      #redirect_to root_path
    end
  end

  def create
    @request = Request.new(request_params)

    slack_message = "#{@request.name} has requested an invite at #{@request.email}."
    if @request.reference.present?
      slack_message += " They referred #{@request.reference}"
    end
    # SLACK_NOTIFIER.ping(slack_message)


  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :insta_handle, :reference)
  end
end
