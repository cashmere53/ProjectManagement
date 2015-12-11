class HousingsController < ApplicationController

    def index
      @inc_account_id = params[:id]
      @housings = Housing.all
    end

    def show
      @inc_account_id = params[:id]
      @housing = Housing.find(params[:id])
    end

    def new
      @inc_account_id = params[:id]
      @housing = Housing.new
    end

    def create
      @inc_account_id = params[:id]
      upload_file = housing_params[:file]
      housing = {}
      if upload_file != nil
        housing[:inc_account_id] = @inc_account_id
        housing[] = housing_params[]
        housing[:image] = upload_file.read
        housing[:content_type] = upload_file.content_type
        housing[:contract_date] = Date.today

        housing[:store_id] = @selected["store_id"].to_i
        housing[:inc_id] = params[:id]
        housing[:street_address] = params[:street_address]
        housing[:rent] = params[:rent].to_i
        housing[:administration_cost] = params[:administration_cost].to_i
        housing[:housing_type] = params[:housing_type]
        housing[:building_date] = @housingdate
        housing[:direction] = params[:direction]
        housing[:layout] = params[:layout]
        housing[:area] = params[:area].to_i
        housing[:structure] = params[:structure]
        housing[:floor] = params[:floor].to_i
        housing[:deposit] = params[:deposit].to_i
        housing[:recompense] = params[:recompense].to_i
        housing[:security_money] = params[:security_money].to_i
        housing[:shikibiki] = params[:shikibiki].to_i
        housing[:insurance] = params[:insurance].to_i
        housing[:parking] = params[:parking].to_i
        housing[:trading_aspect] = params[:trading_aspect]
        housing[:another_cost] = params[:another_cost].to_i
        housing[:vacancy] = params[:vacancy]
        housing[:detail] = params[:detail]
        housing[:plan] = params[:plan].to_i

      end
      @housing = Housing.new(housing)
      if @housing.save
        redirect_to action: "index"
      else
        @message = "広告を保存できませんでした"
        render action: "new"
      end
    end

    def show_image
      @housing = Housing.find(params[:id])
      send_data @housing.image, :type => @housing.content_type, :disposition => 'inline'
    end

    private
      def housing_params
        params.require(:housing).permit(:advertise_info, :file)
      end
end
