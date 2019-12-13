class RequestsController < ApplicationController
  layout 'dashboard'
  def show

  end

  private def request_params
    params.require(:request)
  end
end
