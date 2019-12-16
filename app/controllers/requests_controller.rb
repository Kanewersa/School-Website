class RequestsController < ApplicationController
  layout 'dashboard'

  def accept
    @request = Request.find(params[:id])
    @obj = @request.requestable
    case @request[:action]
    when "create"
      @obj.status = 1
    when "destroy"
      @obj.status = 2
    else
      @target = @obj.class.find(@request.action.split("/")[1])  #Find requestable you want to edit
      if @obj.class.name == "Event"                             #If edit source is an Event
        if @obj.image.attached?                                 #and has an image attached
          @target.image.attach(@obj.image.blob)                 #set the blob for target image
        end
      end
      @target.update_attributes(@obj.attributes.except("id", "slug", "status")) # Copies attributes from source to target
      @obj.status = 2
      @target.save
    end
    @request.status = 2
    @request.save
    @obj.save
    redirect_to requests_path
  end

  def reject
    @request = Request.find(params[:id])
    @request.status = 3
    @request.save
    redirect_to requests_path
  end

  def resend
    @request = Request.find(params[:id])
    @request.status = 1
    @request.save
    redirect_to requests_path
  end

  def show

  end

  private def request_params
    params.require(:request).permit(:id)
  end
end
