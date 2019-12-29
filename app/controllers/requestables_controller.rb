class RequestablesController < ApplicationController
  respond_to :js

  protected def preview(action, resource)
    @main_tabs = MainTab.all
    @categories = Category.all
    @preview = resource.valid?
    respond_to do |format|
      format.js { render :action => action }
    end
  end
  private def requestable_params
    params.permit(:status, :user_id, :action, :requestable_type, :requestable_id)
  end
end
