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
  before_action :authenticate_user, except: [:image]
  # 一覧表示を行う
  def showTables
    @housing = Housing.new
    @inc = IncAccount.find(params[:id])
    @store = @inc.Store
    @inc_account_id = params[:id]
    @inc_account = IncAccount.find(@inc_account_id)
    @housing = Housing.where(inc_account_id: @inc_account_id)
  end

  # 画像の表示に必要なデータをとりだし、send_dataで送信している
  def image
    @housing = Housing.find(params[:id])
    send_data(@housing.image, :type => 'image/jpeg', disposition: :inline)
  end

  # 登録ページの表示を行っている
  def registerDatabases
    @inc_account_id = params[:id]
    @inc = IncAccount.find(params[:id])
    @store = @inc.Store
    @housing = Housing.new
    @housingdate = Date.new(1950, 1, 1)
    @facilities = Facility.all
  end

  # 編集ページの表示を行っている
  def editDatabases
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_account_id)
    @store = @inc.Store
  end

  # 削除
  def deleteDatabases

  end

  # 詳細ページの表示を行っている
  def detail
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_account_id)
    @store = Store.find(@housing.store_id)
  end

  # 登録ページにて登録ボタンが押された場合に呼び出される　データを入力してDBに登録
  def create
    if params[:store_register]
      redirect_to registerStores_path(params[:id])
    else
      @inc_account_id = params[:id]
      @inc = IncAccount.find(params[:id])
      @store = @inc.Store
      @facilities = Facility.all

      @housing = Housing.new
      @date = params[:date]
      @housingdate = DateTime.new(@date["building_date(1i)"].to_i,@date["building_date(2i)"].to_i,@date["building_date(3i)"].to_i)
      @selected = params[:selectedstore_id]

      @housing.store_id = @selected["store_id"].to_i

      #住宅情報を登録
      @housing.inc_account_id = params[:id]
      @housing.street_address = params[:street_address]
      @housing.rent = params[:rent]
      @housing.administration_cost = params[:administration_cost]
      @housing.housing_type = params[:housing_type]
      @housing.building_date = @housingdate
      @housing.direction = params[:direction]
      @housing.layout = params[:layout]
      @housing.area = params[:area]
      @housing.structure = params[:structure]
      @housing.floor = params[:floor]
      @housing.deposit = params[:deposit]
      @housing.recompense = params[:recompense]
      @housing.security_money = params[:security_money]
      @housing.shikibiki = params[:shikibiki]
      @housing.insurance = params[:insurance]

      if params[:parking].present?
        @housing.parking = params[:parking]
      else
        @housing.parking = -1
      end

      @housing.trading_aspect = params[:trading_aspect]
      @housing.another_cost = params[:another_cost]
      @housing.vacancy = params[:vacancy]
      @housing.detail = params[:detail]
      @housing.plan = params[:plan]
      @housing.views = 0
      @housing.favorites = 0

      if params[:image].present?
        @housing.image = params[:image].read
      end

      if @housing.save
        #距離情報を登録
        distances = params[:distance]
        housing_id = Housing.last.id
        store_id = @selected["store_id"].to_i
        facilities = Facility.all
        facilities.each{|facility|
          distance = Distance.new
          distance.distance = distances[facility.id.to_s]
          distance.facility_id = facility.id
          distance.housing_id = housing_id
          distance.store_id = store_id
          distance.inc_account_id = params[:id]
          distance.save
        }
        redirect_to housing_databases_showTables_path(params[:id]), notice: "住宅情報を登録しました"
      else
        @date = nil
        render action: "registerDatabases"
      end
    end

  end

  #編集ページにて編集ボタンが押された場合に呼び出される　編集元データを取得、及び更新
  def update
    if params[:store_register]
      redirect_to registerStores_path(params[:id])
    else
      @housing = Housing.find(params[:id])
      @date = params[:date]
      @housingdate = DateTime.new(@date["building_date(1i)"].to_i,@date["building_date(2i)"].to_i,@date["building_date(3i)"].to_i)
      @selected = params[:selectedstore_id]
      @selectedplans = params[:selectedplan]
      @inc = IncAccount.find(@housing.inc_account_id)
      @store = @inc.Store

      @housing.store_id = @selected["store_id"].to_i
      @housing.street_address = params[:street_address]
      @housing.rent = params[:rent]
      @housing.administration_cost = params[:administration_cost]
      @housing.housing_type = params[:housing_type]
      @housing.building_date = @housingdate
      @housing.direction = params[:direction]
      @housing.layout = params[:layout]
      @housing.area = params[:area]
      @housing.structure = params[:structure]
      @housing.floor = params[:floor]
      @housing.deposit = params[:deposit]
      @housing.recompense = params[:recompense]
      @housing.security_money = params[:security_money]
      @housing.shikibiki = params[:shikibiki]
      @housing.insurance = params[:insurance]

      if params[:parking].present?
        @housing.parking = params[:parking]
      else
        @housing.parking = -1
      end

      @housing.trading_aspect = params[:trading_aspect]
      @housing.another_cost = params[:another_cost]
      @housing.vacancy = params[:vacancy]
      @housing.detail = params[:detail]
      @housing.plan = params[:plan]

      if params[:image].present?
        @housing.image = params[:image].read
      end

      if @housing.save
        redirect_to housing_databases_detail_path(params[:id]), notice: "住宅情報を登録しました"
      else
        @date = nil
        render action: "editDatabases"
      end
    end

  end

  # 削除ボタンを押した場合に呼び出される
  def destroy
    @housing = Housing.find(params[:id])
    @inc = IncAccount.find(@housing.inc_account_id)
    @housing.destroy
    redirect_to housing_databases_showTables_path(@inc.id)
  end
  private
  def authenticate_user
    @inc_account_id = params[:id]
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
  end
end
