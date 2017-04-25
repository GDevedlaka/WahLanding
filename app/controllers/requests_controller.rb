class RequestsController < ApplicationController

  def reference
    @request = Request.new(request_params)

    if !(@request.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i && @request.name.length > 2)
      flash[:alert] = "Please make sure your email is correct and your name is more than 2 characters!"
      redirect_to root_path
    elsif Request.where(email: @request.email).count > 0
      flash[:alert] = "#{@request.email} has already registered!"
      redirect_to root_path
    end

    session[:request_info] = [@request.name, @request.email]
  end

  def create
    @request = Request.new(request_params)
    @request.name = session[:request_info][0]
    @request.email = session[:request_info][1]

    if Request.where(email: @request.reference).count > 0
      flash[:alert] = "#{@request.reference} has already registered"
      redirect_to root_path
    elsif Request.where(reference: @request.reference).count > 0
      flash[:alert] = "#{@request.reference} has already been referred"
      redirect_to root_path
    elsif @request.save
      # flash[:notice] = "Thank You! We'll be in touch!"

      slack_message = "#{@request.name} has requested an invite at #{@request.email}."
      if @request.reference.present?
        slack_message += " They referred #{@request.reference}"
      end
      SLACK_NOTIFIER.ping(slack_message)

      redirect_to root_path
    else
      redirect_to root_path
    end

  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :insta_handle, :reference)
  end
end
