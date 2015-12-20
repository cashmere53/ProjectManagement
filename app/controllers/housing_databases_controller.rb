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
    if session[@inc_account_id]==nil || session[@inc_account_id]==''
      #広告取得
      advertisings=Advertising.all
      @advertisings=[]
      if advertisings.length>0 then
          (0..1).each{|num|
              @advertisings[num]=advertisings[rand(0..advertisings.length-1)]
          }
      end
      render :template => "search/form"
    end
    @housing = Housing.where(inc_account_id: @inc_account_id)
  end

  def image
    @housing = Housing.find(params[:id])
    send_data(@housing.image, :type => 'image/jpeg', disposition: :inline)
  end

  def registerDatabases
    @inc_account_id = params[:id]
    @inc = IncAccount.find(params[:id])
    @store = @inc.Store
    @housing = Housing.new
  end

  def editDatabases
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_account_id)
    @store = @inc.Store
  end

  def deleteDatabases

  end

  def detail
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_account_id)
    @store = Store.find(@housing.store_id)
  end

  def create
    if params[:store_register]
      redirect_to registerStores_path(params[:id])
    else
      @inc = IncAccount.find(params[:id])
      @store = @inc.Store

      @housing = Housing.new
      @date = params[:date]
      @housingdate = DateTime.new(@date["building_date(1i)"].to_i,@date["building_date(2i)"].to_i,@date["building_date(3i)"].to_i)
      @selected = params[:selectedstore_id]

      @housing.store_id = @selected["store_id"].to_i

      #住宅情報を登録
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

      if params[:parking].present?
        @housing.parking = params[:parking].to_i
      else
        @housing.parking = -1
      end

      @housing.trading_aspect = params[:trading_aspect]
      @housing.another_cost = params[:another_cost].to_i
      @housing.vacancy = params[:vacancy]
      @housing.detail = params[:detail]
      @housing.plan = params[:plan]
      @housing.views = 0
      @housing.favorites = 0

      if params[:image].present?
        @housing.image = params[:image].read
      end
      @housing.save

      #距離情報を登録
      housing_id = Housing.last.id
      store_id = @selected["store_id"].to_i
      facilities = Facility.all
      facilities.each{|facility|
        distance = Distance.new
        distance.distance = rand(3000) + 1
        distance.facility_id = facility.id
        distance.housing_id = housing_id
        distance.store_id = store_id
        distance.inc_account_id = params[:id]
        distance.save
      }

      redirect_to housing_databases_showTables_path(params[:id]), notice: "住宅情報を登録しました"
    end

  end

  def update
    @housing = Housing.find(params[:id])
    @date = params[:date]
    @housingdate = DateTime.new(@date["building_date(1i)"].to_i,@date["building_date(2i)"].to_i,@date["building_date(3i)"].to_i)
    @selected = params[:selectedstore_id]
    @selectedplans = params[:selectedplan]

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

    if params[:parking].present?
      @housing.parking = params[:parking].to_i
    else
      @housing.parking = -1
    end

    @housing.trading_aspect = params[:trading_aspect]
    @housing.another_cost = params[:another_cost].to_i
    @housing.vacancy = params[:vacancy]
    @housing.detail = params[:detail]
    @housing.plan = params[:plan]

    if params[:image].present?
      @housing.image = params[:image].read
    end

    @housing.save
    redirect_to housing_databases_detail_path(params[:id]), notice: "住宅情報を登録しました"
  end

  def destroy
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_account_id)
    @housing.destroy
    redirect_to housing_databases_showTables_path(@inc.id)
  end
end
