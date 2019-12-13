class RequestsController < ApplicationController
  layout 'dashboard'

  def accept
    @request = Request.find(params[:request][:id])
    @obj = find_request_object(@request)

    case @request.action
    when "create"
    when "destroy"
      @obj.destroy
    else
      @source = @request[:requestable_type].classify.constantize.find(@request[:requestable_id])
      @obj.update_attributes(@source.attributes)
      @source.attachments.each do |attachment|
        @obj.attach(attachment)
      end
    end

    if @obj != NIL
      @obj.status = 1
    end
    @request.status = 2
  end

  def reject

  end

  def show

  end

  private def request_params
    params.require(:request)
  end
end
