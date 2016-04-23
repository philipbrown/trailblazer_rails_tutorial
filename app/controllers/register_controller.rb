class RegisterController < ApplicationController
  def new
    form User::Create
  end

  def create
    run User::Create do |op|
      return redirect_to login_url
    end

    render :new, status: 400
  end
end
