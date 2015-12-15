############################################################
# specificat on ;
# name     = Good Measure ;
# note     = ;
# date     = 2015/12/6 ;
# author   = Takayuki Kaneko ;
# History  = ver1.0.0 ;
# end of specification ;
#############################################################

class UserMailer < ApplicationMailer
  default from: "good.measure.dekiru@gmail.com"

  def regist_mail(mail_to, link_pass)
    @url = "http://localhost:3000/users/avaliable/" + link_pass
    mail to: mail_to, subject: "登録を完了してください"
  end
end
