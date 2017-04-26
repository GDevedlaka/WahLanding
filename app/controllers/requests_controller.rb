class RequestsController < ApplicationController

  def reference
    @request = Request.new(request_params)

    if !(@request.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i && @request.name.length > 2) # Email must be correct and Name must be valid
      flash[:alert] = "Please make sure your email is correct and your name is more than 2 characters!"
      redirect_to root_path
    elsif Request.where(email: @request.email).count > 0 # Email must be unique
      flash[:alert] = "#{@request.email} has already registered!"
      redirect_to root_path
    end

    if @request.save
      session[:email] = @request.email
      SLACK_NOTIFIER.ping("#{@request.name} has requested an invite at #{@request.email}.")
    else
      flash[:alet] = "Something went wrong! We're sorry!"
      redirect_to root_path
    end
  end

  def create
    @request = Request.find_by_email(session[:email])

    if Request.where(reference: request_params[:reference]).count > 0 # Email can not be referred twice!
      flash[:alert] = "#{request_params[:reference]} has already been referred"
      redirect_to root_path
    elsif Request.where(email: request_params[:reference]).count > 0 # User can't be referred if they've already signed up
      flash[:alert] = "#{request_params[:reference]} has already signed up"
      redirect_to root_path
    else
      @request.reference = request_params[:reference]

      if @request.save
        SLACK_NOTIFIER.ping("#{@request.email} referred #{@request.reference}")
      else
        flash[:alert] = "Something went wrong! We're Sorry!"
        redirect_to root_path
      end
    end

  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :insta_handle, :reference)
  end
end
