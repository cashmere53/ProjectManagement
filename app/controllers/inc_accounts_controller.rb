############################################################
# specificat on ;
# name     = Good Measure ;
# note     = ;
# date     = 2015/12/6 ;
# author   = Takayuki Kaneko ;
# History  = ver1.0.0 ;
# end of specification ;
#############################################################

class IncAccountsController < ApplicationController
  #ログイン画面を表示する
  def login
    @message = "";
    @inc_account = IncAccount.new
  end

  #ユーザの新規作成フォームを表示する
  def new
    @inc_account = IncAccount.new
  end

  def auth
    @inc_account = IncAccount.find_by(inc_name: params[:inc_name])
    if @inc_account && @inc_account.authenticate(params[:password])
      @housing = Housing.where(inc_account_id: @inc_account.id)
      @inc_account_id = @inc_account.id
      session[@inc_account_id] = @inc_account_id
      redirect_to controller: "housings", action: "index", id: @inc_account_id
    else
      @message = "ユーザ名かパスワードが違います。"
      render :template => "inc_accounts/login"
    end
  end

  def logout
    @inc_account_id = params[:inc_account_id]
    session[@inc_account_id] = nil
    #広告取得
    advertisings=Advertising.all
    @advertisings=[]
    if advertisings.length>0 then
        (0..1).each{|num|
            @advertisings[num]=advertisings[rand(0..advertisings.length-1)]
        }
    end
    render template: "search/form"
  end

  def edit
    @message = ""
    @inc_account = IncAccount.find_by(inc_name: params[:inc_name])
    if params[:inc_name]!=nil && IncAccount.find_by(inc_name: params[:inc_name])!=nil && IncAccount.find_by(inc_name: params[:inc_name]).avaliable!=false
      @inc_name = params[:inc_name]
    else
      render :template => "search/form"
    end
  end

  def update
    if params[:inc_name]!=nil && IncAccount.find_by(inc_name: params[:inc_name])!=nil && IncAccount.find_by(inc_name: params[:inc_name]).avaliable!=false
      @inc_name = params[:inc_name]
    else
      render :template =>"search/form"
    end
    @inc_account = IncAccount.find_by(inc_name: @inc_name)
    if @inc_account && @inc_account.authenticate(params[:old_password])
      @inc_account.password = params[:password]
      @inc_account.password_confirmation = params[:password_confirmation]
      if @inc_account.valid?
        @inc_account.save
        @message = "パスワードを変更しました。"
      else
        @message = "パスワードが違います。"
      end
    else
      @message = "パスワードが違います。"
    end
    render action: 'edit'
  end

  def destroy
    inc_account = IncAccount.find(params[:id])
    inc_account.destroy

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

  #確認画面を表示する
  def confirm
    @inc_account = IncAccount.new(inc_params)
    if @inc_account.valid?
      render action: 'confirm'
    else
      render action: 'new'
    end
  end

  #登録完了画面を表示する
  def complete
    @inc_account = IncAccount.new(inc_params)
    if params[:cancel]
      render action: 'new'
    elsif params[:regist]
      @inc_account.avaliable = false
      if @inc_account.save
        IncMailer.regist_mail(@inc_account.mail_address, @inc_account.inc_name).deliver
      else
        @message = "エラーが発生しました。"
        render action: 'new'
      end
    end
  end

  #登録されたユーザを有効にする
  def avaliable
    inc_name = params[:inc_name]
    @inc_account = IncAccount.find_by(inc_name: inc_name)
    if(@inc_account && @inc_account.avaliable == false && @inc_account.update_attribute(:avaliable, true))
      @title = "登録完了"
      @message = "登録が完了しました。"
    else
      @title = "⚠︎エラー⚠︎"
      @message = "無効なURLです。"
    end
  end

  private
  def inc_params
    params.require(:inc_account).permit(:inc_name, :password, :password_confirmation, :mail_address, :phone_num, :account_name)
  end
end
