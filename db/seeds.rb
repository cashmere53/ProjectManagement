#coding: utf-8

#ユーザ
User.create(:user_name=>'a' , :password=>'aaaaaaaa', :password_confirmation=>'aaaaaaaa', :mail_address=>'a@pm.jp')
User.create(:user_name=>'b' , :password=>'bbbbbbbb', :password_confirmation=>'bbbbbbbb', :mail_address=>'b@pm.jp')
User.create(:user_name=>'c' , :password=>'cccccccc', :password_confirmation=>'cccccccc', :mail_address=>'c@pm.jp')

#企業用アカウント
IncAccount.create(:inc_name=>'A不動産' , :password=>'AAAAAAAA', :password_confirmation=>'AAAAAAAA', :mail_address=>'A@pm.jp' , :phone_num=>'012345678901' , :account_name=>'ｴｰﾌﾄﾞｳｻﾝ')
IncAccount.create(:inc_name=>'B不動産' , :password=>'BBBBBBBB', :password_confirmation=>'BBBBBBBB', :mail_address=>'B@pm.jp' , :phone_num=>'123456789012' , :account_name=>'ﾋﾞｰﾌﾄﾞｳｻﾝ')
IncAccount.create(:inc_name=>'C不動産' , :password=>'CCCCCCCC', :password_confirmation=>'BBBBBBBB', :mail_address=>'C@pm.jp' , :phone_num=>'234567890123' , :account_name=>'ｼｰﾌﾄﾞｳｻﾝ')

#店舗情報
Store.create(:inc_account_id=>1 , :store_name=>'日立支店' , :street_address=>'日立市A町1-1-1' , :postal_code=>'1111111')
Store.create(:inc_account_id=>1 , :store_name=>'多賀支店' , :street_address=>'日立市A町2-2-2' , :postal_code=>'2222222')
Store.create(:inc_account_id=>2 , :store_name=>'日立支店' , :street_address=>'日立市B町1-1-1' , :postal_code=>'3333333')
Store.create(:inc_account_id=>2 , :store_name=>'多賀支店' , :street_address=>'日立市B町2-2-2' , :postal_code=>'4444444')
Store.create(:inc_account_id=>3 , :store_name=>'日立支店' , :street_address=>'日立市C町1-1-1' , :postal_code=>'5555555')

#住宅情報
Housing.create(:store_id=>1,:inc_account_id=>1,:street_address=>'茨城県日立市諏訪町2-8',:rent=>10000,:administration_cost=>100,:housing_type=>'マンション',:building_date=>'2000-01-01',:direction=>'南',:layout=>'1LDK',:area=>234,:structure=>'木造',:floor=>2,:deposit=>500,:recompense=>1000,:security_money=>1000,:shikibiki=>500,:insurance=>500,:parking=>1000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>1,:inc_account_id=>1,:street_address=>'茨城県日立市鮎川町6-9',:rent=>11000,:administration_cost=>200,:housing_type=>'アパート',:building_date=>'2001-01-01',:direction=>'南東',:layout=>'1LDK',:area=>234,:structure=>'木造',:floor=>2,:deposit=>500,:recompense=>1000,:security_money=>1000,:shikibiki=>500,:insurance=>700,:parking=>2000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'101号室・103号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>2,:inc_account_id=>1,:street_address=>'茨城県日立市西成沢町1-33',:rent=>12000,:administration_cost=>300,:housing_type=>'アパート',:building_date=>'1980-01-01',:direction=>'南',:layout=>'ワンルーム',:area=>104,:structure=>'木造',:floor=>2,:deposit=>600,:recompense=>900,:security_money=>1000,:shikibiki=>700,:insurance=>700,:parking=>1000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>2,:inc_account_id=>1,:street_address=>'日立市A町2-1-2',:rent=>13000,:administration_cost=>1000,:housing_type=>'アパート',:building_date=>'2002-01-01',:direction=>'南',:layout=>'2K',:area=>234,:structure=>'木造',:floor=>2,:deposit=>500,:recompense=>1000,:security_money=>1000,:shikibiki=>500,:insurance=>500,:parking=>3000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>3,:inc_account_id=>2,:street_address=>'日立市B町3-2-1',:rent=>14000,:administration_cost=>300,:housing_type=>'戸建',:building_date=>'2000-01-01',:direction=>'南西',:layout=>'1LDK',:area=>204,:structure=>'木造',:floor=>2,:deposit=>600,:recompense=>1000,:security_money=>1000,:shikibiki=>700,:insurance=>500,:parking=>1000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'101号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>3,:inc_account_id=>2,:street_address=>'日立市B町3-2-2',:rent=>15000,:administration_cost=>400,:housing_type=>'アパート',:building_date=>'2005-01-01',:direction=>'西',:layout=>'1LDK',:area=>234,:structure=>'鉄筋コンクリート',:floor=>2,:deposit=>500,:recompense=>900,:security_money=>1000,:shikibiki=>500,:insurance=>500,:parking=>3000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>4,:inc_account_id=>2,:street_address=>'日立市B町4-2-1',:rent=>16000,:administration_cost=>500,:housing_type=>'アパート',:building_date=>'2000-01-01',:direction=>'南',:layout=>'1DK',:area=>234,:structure=>'木造',:floor=>2,:deposit=>500,:recompense=>1000,:security_money=>1000,:shikibiki=>700,:insurance=>500,:parking=>1000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>4,:inc_account_id=>2,:street_address=>'日立市B町4-2-2',:rent=>17000,:administration_cost=>600,:housing_type=>'アパート',:building_date=>'1990-01-01',:direction=>'東',:layout=>'1LDK',:area=>234,:structure=>'木造',:floor=>2,:deposit=>500,:recompense=>1000,:security_money=>1000,:shikibiki=>900,:insurance=>700,:parking=>1000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>5,:inc_account_id=>3,:street_address=>'日立市C町5-3-1',:rent=>18000,:administration_cost=>700,:housing_type=>'マンション',:building_date=>'2000-01-01',:direction=>'南',:layout=>'2LDK',:area=>544,:structure=>'木造',:floor=>2,:deposit=>700,:recompense=>900,:security_money=>1000,:shikibiki=>900,:insurance=>500,:parking=>1000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)
Housing.create(:store_id=>5,:inc_account_id=>3,:street_address=>'日立市C町5-3-2',:rent=>19000,:administration_cost=>1100,:housing_type=>'アパート',:building_date=>'2000-01-01',:direction=>'南',:layout=>'1LDK',:area=>234,:structure=>'木造',:floor=>2,:deposit=>500,:recompense=>1000,:security_money=>1000,:shikibiki=>500,:insurance=>500,:parking=>3000,:trading_aspect=>'仲介',:another_cost=>2000,:vacancy=>'1号室',:detail=>'風呂・トイレ別',:plan=>1,:contract_update=>'2015-11-29',:views=>0,:favorites=>0)

#施設情報
Facility.create(:name=>'(大学)茨城大学',:street_address=>'茨城県日立市中成沢町4-12-1')
Facility.create(:name=>'(スーパー)イトーヨーカドー日立店',:street_address=>'茨城県日立市幸町1-16-1')
Facility.create(:name=>'(スーパー)スーパーマーケットマルト諏訪店',:street_address=>'茨城県日立市諏訪町4-11-16')
Facility.create(:name=>'(スーパー)サンユーストアー新鮎川店',:street_address=>'茨城県日立市鮎川町1-4-2')
Facility.create(:name=>'(コンビニ)セブンイレブン日立市民運動公園前店',:street_address=>'茨城県日立市中成沢町1-9−8')
Facility.create(:name=>'(コンビニ)ローソン 日立鮎川町五丁目',:street_address=>'茨城県日立市鮎川町5-1-10')
Facility.create(:name=>'(コンビニ)ファミリーマート 日立油縄子店',:street_address=>'茨城県日立市鮎川町2-7−19')
Facility.create(:name=>'(駅)日立駅',:street_address=>'茨城県日立市幸町1-1-1')
Facility.create(:name=>'(駅)常陸多賀駅',:street_address=>'茨城県日立市多賀町1-1-1')
Facility.create(:name=>'(郵便局)日立成沢郵便局',:street_address=>'茨城県日立市中成沢町3-16-1')
Facility.create(:name=>'(銀行)（株）常陽銀行 兎平支店',:street_address=>'茨城県日立市城南町3-3-31')
Facility.create(:name=>'(病院)ひたち医療センター',:street_address=>'茨城県日立市鮎川町2-8-16')
Facility.create(:name=>'(衣服店)ユニクロ 日立成沢店',:street_address=>'茨城県日立市中成沢町2-37-13')
Facility.create(:name=>'(居酒屋)吾平 日立鮎川店',:street_address=>'茨城県日立市鮎川町6-3-25')
Facility.create(:name=>'(飲食店)夢庵 日立鮎川店',:street_address=>'茨城県日立市鮎川町6-7-25')
Facility.create(:name=>'(本屋)ブックエース日立鮎川店',:street_address=>'茨城県日立市鮎川町5-1-1')
Facility.create(:name=>'(娯楽施設その他)快活CLUB日立店',:street_address=>'茨城県日立市西成沢町3-1-1')

#距離情報
housings=Housing.all
facilities=Facility.all
housings.each do |housing|
    facilities.each do |facility|
        Distance.create(:facility_id=>facility.id , :housing_id=>housing.id , :store_id=>housing.store_id , :inc_account_id=>housing.inc_account_id ,:distance=>rand(200..2000))
    end
end

#広告情報
Advertising.create(:inc_account_id=>1,:advertise_info=>'広告1',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>2,:advertise_info=>'広告2',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>3,:advertise_info=>'広告3',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>1,:advertise_info=>'広告4',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>2,:advertise_info=>'広告5',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>3,:advertise_info=>'広告6',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>1,:advertise_info=>'広告7',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>2,:advertise_info=>'広告8',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>3,:advertise_info=>'広告9',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>1,:advertise_info=>'広告10',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>2,:advertise_info=>'広告11',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>3,:advertise_info=>'広告12',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>1,:advertise_info=>'広告13',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>2,:advertise_info=>'広告14',:contract_date=>'2015-12-04')
Advertising.create(:inc_account_id=>3,:advertise_info=>'広告15',:contract_date=>'2015-12-04')
