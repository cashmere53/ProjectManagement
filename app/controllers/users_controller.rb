############################################################
# specificat on ;
# name     = Good Measure ;
# note     = ;
# date     = 2015/12/6 ;
# author   = Takayuki Kaneko ;
# History  = ver1.0.0 ;
# end of specification ;
#############################################################

class UsersController < ApplicationController
  #ログイン画面を表示する
  def login
    @message = "";
    @user = User.new
  end

  #ユーザの新規作成フォームを表示する
  def new
    @user = User.new
  end

  def edit
    @message = ""
    @user = User.find_by(user_name: params[:user_name])
    if params[:user_name]!=nil && User.find_by(user_name: params[:user_name])!=nil && User.find_by(user_name: params[:user_name]).avaliable!=false
      @user_name = params[:user_name]
    else
      render :template =>"search/form"
    end
  end

  def update
    if params[:user_name]!=nil && User.find_by(user_name: params[:user_name])!=nil && User.find_by(user_name: params[:user_name]).avaliable!=false
      @user_name = params[:user_name]
    else
      render :template =>"search/form"
    end
    @user = User.find_by(user_name: @user_name)
    if @user && @user.authenticate(params[:old_password])
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      if @user.valid?
        @user.save
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
    user = User.find(params[:id])
    user.destroy

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
    @user = User.new(user_params)
    if @user.valid?
      render action: 'confirm'
    else
      render action: 'new'
    end
  end

  #登録完了画面を表示する
  def complete
    @user = User.new(user_params)
    if params[:cancel]
      render action: 'new'
    elsif params[:regist]
      @user.avaliable = false
      if @user.save
        UserMailer.regist_mail(@user.mail_address, @user.user_name).deliver
      else
        @message = "エラーが発生しました。"
        render action: 'new'
      end
    end
  end

  #登録されたユーザを有効にする
  def avaliable
    user_name = params[:user_name]
    @user = User.find_by(user_name: user_name)
    if(@user && @user.avaliable == false && @user.update_attribute(:avaliable, true))
      @title = "登録完了"
      @message = "登録が完了しました。"
    else
      @title = "⚠︎エラー⚠︎"
      @message = "無効なURLです。"
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :mail_address)
  end
end
