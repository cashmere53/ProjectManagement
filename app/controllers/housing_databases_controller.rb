############################################################
# specificat on ;
# name     = Good Measure ;
# note     = ;
# date     = 2015/12/6 ;
# author   = Nishi ;
# History  = ver1.0.0 ;
# end of specification ;
#############################################################

class HousingDatabasesController < DatabasesController
  def showTables
    @inc_account_id = params[:id]
    @inc_account = IncAccount.find(@inc_account_id)
    if @inc_account_id==nil || @inc_account_id==''
      render :template => "search/form"
    end
    @housing = Housing.where(inc_account_id: @inc_account_id)
  end

  def image
    @housing = Housing.find(params[:id])
    send_data(@housing.image, type: @housing.image_content_type, disposition: :inline)
  end

  def registerDatabases
    @inc = IncAccount.find(params[:id])
    @store = @inc.Store
  end

  def editDatabases
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_id)
    @store = @inc.Store
  end

  def deleteDatabases

  end

  def details
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_id)
    @store = Store.find(@housing.store_id)
  end

  def create
    @housing = Housing.new
    @date = params[:date]
    @housingdate = DateTime.new(@date["building_date(1i)"].to_i,@date["building_date(2i)"].to_i,@date["building_date(3i)"].to_i)
    @selected = params[:selectedstore_id]

    @housing.store_id = @selected["store_id"].to_i
    @housing.inc_account_id = params[:id]
    @housing.street_address = params[:street_address]
    @housing.rent = params[:rent].to_i
    @housing.administration_cost = params[:administration_cost].to_i
    @housing.housing_type = params[:housing_type]
    @housing.building_date = @housingdate
    @housing.direction = params[:direction]
    @housing.layout = params[:layout]
    @housing.area = params[:area].to_i
    @housing.structure = params[:structure]
    @housing.floor = params[:floor].to_i
    @housing.deposit = params[:deposit].to_i
    @housing.recompense = params[:recompense].to_i
    @housing.security_money = params[:security_money].to_i
    @housing.shikibiki = params[:shikibiki].to_i
    @housing.insurance = params[:insurance].to_i
    @housing.parking = params[:parking].to_i
    @housing.trading_aspect = params[:trading_aspect]
    @housing.another_cost = params[:another_cost].to_i
    @housing.vacancy = params[:vacancy]
    @housing.detail = params[:detail]
    @housing.plan = params[:plan].to_i

    if params[:image].present?
      @housing.image = params[:image].read
      @housing.image_content_type = params[:image].content_type
    end

    @housing.save
    redirect_to housing_databases_showTables_path(params[:id]), notice: "住宅情報を登録しました"
  end

  def update
    @housing = Housing.find(params[:id])
    @date = params[:date]
    @housingdate = DateTime.new(@date["building_date(1i)"].to_i,@date["building_date(2i)"].to_i,@date["building_date(3i)"].to_i)
    @selected = params[:selectedstore_id]

    @housing.store_id = @selected["store_id"].to_i
    @housing.street_address = params[:street_address]
    @housing.rent = params[:rent].to_i
    @housing.administration_cost = params[:administration_cost].to_i
    @housing.housing_type = params[:housing_type]
    @housing.building_date = @housingdate
    @housing.direction = params[:direction]
    @housing.layout = params[:layout]
    @housing.area = params[:area].to_i
    @housing.structure = params[:structure]
    @housing.floor = params[:floor].to_i
    @housing.deposit = params[:deposit].to_i
    @housing.recompense = params[:recompense].to_i
    @housing.security_money = params[:security_money].to_i
    @housing.shikibiki = params[:shikibiki].to_i
    @housing.insurance = params[:insurance].to_i
    @housing.parking = params[:parking].to_i
    @housing.trading_aspect = params[:trading_aspect]
    @housing.another_cost = params[:another_cost].to_i
    @housing.vacancy = params[:vacancy]
    @housing.detail = params[:detail]
    @housing.plan = params[:plan].to_i

    if params[:image].present?
      @housing.image = params[:image].read
      @housing.image_content_type = params[:image].content_type
    end

    @housing.save
    redirect_to housing_databases_details_path(@housing.id), notice: "住宅情報の編集を完了しました"
  end

  def destroy
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_id)
    @housing.destroy
    redirect_to housing_databases_showTables_path(@inc.id)
  end
end
