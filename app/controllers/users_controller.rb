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

  def auth
    @user = User.find_by(mail_address: params[:mail_address])
    if @user && @user.authenticate(params[:password])
      @user_name = @user.user_name
      session[@user_name] = @user_name
      #広告取得
      advertisings=Advertising.all
      @advertisings=[]
      if advertisings.length>0 then
          (0..1).each{|num|
              @advertisings[num]=advertisings[rand(0..advertisings.length-1)]
          }
      end
      render :template => "/search/form"
    else
      @message = "ユーザ名かパスワードが違います。"
      render :template => "users/login"
    end
  end

  #ユーザの新規作成フォームを表示する
  def new
    @user = User.new
  end

  def edit
    @message1 = ""
    @message2 = ""
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
        @message1 = "パスワードを変更しました。"
      else
        if @user.password == @user.password_confirmation
          @message2 = "パスワードは8文字以上30文字以内で入力してください。"
        else
          @message2 = "パスワードが一致していません。再度入力してください。"
        end
      end
    else
      @message1 = "古いパスワードが違います。"
    end
    render action: 'edit'
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
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
      o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      while true do
        @user.link_pass = (0...64).map { o[rand(o.length)] }.join
        if(User.find_by(link_pass: @user.link_pass)==nil)
          break;
        end
      end
      if @user.save
        UserMailer.regist_mail(@user.mail_address, @user.link_pass).deliver
      else
        @message = "エラーが発生しました。"
        render action: 'new'
      end
    end
  end

  #登録されたユーザを有効にする
  def avaliable
    link_pass = params[:link_pass]
    @user = User.find_by(link_pass: link_pass)
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
