class RequestsController < RequestablesController
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
      #If requestable has an image
      if @obj.respond_to?(:image) and @target.respond_to?(:image)
        if @obj.image.attached?                                 #and has an image attached
          @target.image.attach(@obj.image.blob)                 #set the blob for target image
        end
      end
      #If requestable has a gallery
      if @obj.respond_to?(:gallery_images) and @target.respond_to?(:gallery_images)
        if @obj.gallery_images.attached?
          @target.gallery_images.purge_later
          @target.gallery_images.attach(@obj.gallery_images.blobs)
        end
      end
      #If requestable has rich text field (body)
      if @obj.respond_to?(:body) and @target.respond_to?(:body)
        @target.body = @obj.body
      end
      @target.update(@obj.attributes.except("id", "slug", "status", "created_at", "updated_at")) # Copies attributes from source to target
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

  def preview_request
    @requestable = Request.find(params[:request]).requestable
    preview('preview', @requestable)
  end

  private def request_params
    params.require(:request).permit(:id)
  end
end
