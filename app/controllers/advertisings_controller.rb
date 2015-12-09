class AdvertisingsController < ApplicationController

  def index
    @advertisings = Advertising.all
  end

  def show
    @advertising = Advertising.find(params[:id])
  end

  def new
    @advertising = Advertising.new
  end

  def create
    upload_file = advertising_params[:file]
    advertising = {}
    if upload_file != nil
      advertising[:advertise_info] = advertising_params[:advertise_info]
      advertising[:image] = upload_file.read
      advertising[:content_type] = upload_file.content_type
      advertising[:contract_date] = Date.today
    end
    @advertising = Advertising.new(advertising)
    if @advertising.save
      flash[:success] = "画像を保存しました。"
      redirect_to action: "index"
    else
      flash[:error] = "画像を保存できませんでした。"
    end
  end

  def show_image
    @advertising = Advertising.find(params[:id])
    send_data @advertising.image, :type => @advertising.content_type, :disposition => 'inline'
  end

  private
    def advertising_params
      params.require(:advertising).permit(:advertise_info, :file)
    end
end
