############################################################
# specificat on ;
# name     = Good Measure ;
# note     = ;
# date     = 2015/12/6 ;
# author   = Nishi ;
# History  = ver1.0.0 ;
# end of specification ;
#############################################################

class StoreController < ApplicationController
  def showTables

  end

  def registerStores
    @inc_account_id = params[:id]
    @store = Store.new
  end

  def editStores
    @store = Store.find(params[:id])
  end

  def showStores
    @inc_account_id = params[:id]
    @inc_account = IncAccount.find(@inc_account_id)
    if session[@inc_account_id]==nil || session[@inc_account_id]==''
      #広告取得
      stores=Store.all
      @store=[]
      if stores.length>0 then
        (0..1).each{|num|
          @store[num]=soters[rand(0..stores.length-1)]
        }
      end
      render :template => "search/form"
    end
    @store = Store.where(inc_account_id: @inc_account_id)
  end

  def create
    @store = Store.new
    @store.store_name = params[:store_name]
    @store.inc_account_id = params[:id]
    @store.street_address = params[:street_address]
    @store.postal_code = params[:postal_code]
    if @store.save
      redirect_to showStores_path(@store.inc_account_id)
    else
      render :action => 'registerStores'
    end
  end

  def update
    @store = Store.find(params[:id])
    @store.store_name = params[:store_name]
    @store.street_address = params[:street_address]
    @store.postal_code = params[:postal_code]
    if @store.save
      redirect_to showStores_path(@store.inc_account_id)
    else
      render :action => 'editStores'
    end

  end

  def destroy
    @store = Store.find(params[:id])
    @inc_account_id = IncAccount.find(@store.inc_account_id).id
    @store.destroy
    redirect_to showStores_path(@inc_account_id)
  end
end
