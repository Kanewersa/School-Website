class RequestablesController < ApplicationController

  private def requestable_params
    params.permit(:status, :user_id, :action, :requestable_type, :requestable_id)
  end
end
