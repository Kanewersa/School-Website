class PagesController < ApplicationController
  layout 'application'

  def main
    @main_tabs = MainTab.all
  end

  def dashboard
    unless user_signed_in?
      redirect_to login_path
    else
      render :layout => 'dashboard'
    end
  end

  def test
    render :layout => 'test'
  end

end
