class RequestablesController < ApplicationController
  respond_to :js

  protected def preview
    @main_tabs = MainTab.all
    @categories = Category.all
    respond_to do |format|
      format.js { render 'requestables/preview', locals: { requestable: @requestable } }
    end
  end

  # Validates requestable and returns ajax response if not valid
  protected def validates?(params, class_type)
    @requestable = class_type.new(params)
    unless @requestable.valid?
      # Respond with 422 (unprocessable entity) and render errors
      respond_to do |format|
        format.js { render 'validation-error', locals: { errors: @requestable.errors.full_messages, :status => 422 } }
      end
      return false
    end
    true
  end

  private def get_blobs_from_ids(source)
    #Split source and get array of ids
    new_ids = source.split(',')
    #Remove empty records caused by users deletion of gallery images
    new_ids = new_ids.reject { |key| key.empty? }
    # Create blobs array from id's
    blobs = []
    new_ids.each do |key|
      blobs.push(ActiveStorage::Blob.find_signed(key))
    end
    #Return blobs array
    blobs
  end
  private def requestable_params
    params.permit(:status, :user_id, :action, :requestable_type, :requestable_id)
  end
end
