############################################################
# specificat on ;
# name     = Good Measure ;
# note     = ;
# date     = 2015/12/6 ;
# author   = Nishi ;
# History  = ver1.0.0 ;
# end of specification ;
#############################################################

class AdvertisingDatabasesController < DatabasesController
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
    @advertising = Advertising.where(inc_account_id: @inc_account_id)
  end

  def image
    @advertising = Advertising.find(params[:id])
    send_data(@advertising.image, :type => 'image/jpeg', disposition: :inline)
  end

  def registerDatabases
    @inc_account_id = params[:id]
  end

  def editDatabases
    @advertising = AdvertisingTable.find(params[:id])
  end

  def deleteDatabases
    @inc_account_id = params[:id]
  end

  def details
    @advertising = Advertising.find(params[:id])
    @inc = IncAccount.find(@advertising.inc_id)
  end

  def create
    @inc_account = IncAccount.find(params[:id])
    @inc_account_id = params[:id]

    upload_file = params.require(:image)
    adv = {}
    if upload_file != nil
      adv[:advertise_info] = params[:advertise_info]
      adv[:image] = upload_file.read
      adv[:inc_account_id] = params[:id]
      adv[:contract_date] = Date.today
    end
    @advertising = Advertising.new(adv)

    @advertising.save
    @advertising = Advertising.where(inc_account_id: @inc_account_id)
    render :action => "showTables"
  end

  def update
    @advertising = Advertising.find(params[:id])
    @inc = IncAccount.find(@advertising.inc_id)

    @advertising.advertise_info = params[:advertise_info]
    if params[:image].present?
      @advertising.image = params[:image].read
      @advertising.image_content_type = params[:image].content_type
    end

    @advertising.save
    redirect_to advertising_databases_details_path(@advertising.id), notice: "広告情報の編集を完了しました"
  end

  def destroy
    @advertising = AdvertisingTable.find(params[:id])
    @inc_id = IncAccount.find(@advertising.inc_id).id
    @advertising.destroy
    redirect_to advertising_databases_showTables_path(@inc_id)
  end
end
