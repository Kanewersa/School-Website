class PartnersController < RequestablesController
  def create
    # Check if partner params are valid
    unless validates?(partner_params, Partner)
      return
    end
    # Create new partner
    @partner = Partner.new(partner_params)
    if current_user.has_role?(:admin)
      @partner.status = 1
      @partner.save
    else
      @partner.status = 0
      @partner.save
      @request = Request.new(status: 1, user_id: current_user.id, action: "create",
                             requestable_type: "Partner", requestable_id: @partner.id)
      @request.save
    end

    respond_to do |format|
      format.js { render 'requestables/validation-success' }
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    if current_user.has_role?(:admin)
      @partner.destroy
    else
      @request = Request.new(status: 1, user_id: current_user.id, action: "destroy",
                             requestable_type: "Partner", requestable_id: @partner.id)
      @request.save
    end
    redirect_to partners_path
  end

  private def partner_params
    params.require(:partner).permit(:name, :link, :image)
  end
end
