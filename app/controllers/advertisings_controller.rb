class AdvertisingsController < ApplicationController

  def index
    @inc_account_id = params[:id]
    @advertisings = Advertising.all
  end

  def show
    @advertising = Advertising.find(params[:id])
  end

  def new
    @inc_account_id = params[:id]
    @advertising = Advertising.new
  end

  def create
    @inc_account_id = advertising_params[:id]
    upload_file = advertising_params[:file]
    advertising = {}
    if upload_file != nil
      advertising[:inc_account_id] = @inc_account_id
      advertising[:advertise_info] = advertising_params[:advertise_info]
      advertising[:image] = upload_file.read
      advertising[:content_type] = upload_file.content_type
      advertising[:contract_date] = Date.today
    end
    @advertising = Advertising.new(advertising)
    if @advertising.save
      @advertisings = Advertising.all
      render action: "index"
    else
      @message = "広告を保存できませんでした"
      render action: "new"
    end
  end

  def show_image
    @advertising = Advertising.find(params[:id])
    send_data @advertising.image, :type => @advertising.content_type, :disposition => 'inline'
  end

  private
    def advertising_params
      params.require(:advertising).permit(:id, :advertise_info, :file)
    end
end
