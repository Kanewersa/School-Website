class RequestsController < ApplicationController
  layout 'dashboard'

  def accept
    @request = Request.find(params[:id])
    @obj = find_request_object(@request)

    case @request[:action]
    when "create"
    when "destroy"
      @obj.destroy
    else
      @source = @request[:requestable_type].classify.constantize.find(@request[:requestable_id])
      if @obj.instance_variable_defined?(:image)
        unless ActiveStorage::Attachment.where(:id => @source.image).empty?
          @obj.image.attach(@source.image)
        end
      end
      @obj.update_attributes(@source.attributes.except("id", "slug"))
      #@source.attachments.each do |attachment|
      #  @obj.attach(attachment)
    end


    if @obj != NIL
      @obj.status = 1
    end
    @request.status = 2
    @obj.save
    @request.save
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
  end

  def show

  end

  private def request_params
    params.require(:request).permit(:id)
  end
end
