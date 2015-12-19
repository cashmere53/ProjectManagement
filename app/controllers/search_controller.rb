#conding: utf-8

############################################################
# specificat on ;
# name     = Good Measure ;
# note     = ;
# date     = 2015/11/29 ;
# author   = Kenta Togashi ;
# History  = ver1.0.0 ;
# end of specification ;
#############################################################

class SearchController < ApplicationController
  def form

    if params[:user_name]!=nil && User.find_by(user_name: params[:user_name])!=nil && User.find_by(user_name: params[:user_name]).avaliable!=false
      @user_name = params[:user_name]
    end

      #広告取得
      advertisings=Advertising.all
      @advertisings=[]
      if advertisings.length>0 then
          (0..1).each{|num|
              @advertisings[num]=advertisings[rand(0..advertisings.length-1)]
          }
      end
  end

  def show
      @user_name=params[:user_name]
      destination=params[:destination]
      @destination=[]
      @destination[0]=destination['d1']
      @destination[1]=destination['d2']
      @destination[2]=destination['d3']
      @destination[3]=destination['d4']
      @destination[4]=destination['d5']
      @filter=destination['filter']
      @slope=params[:slope]
      keyword=params[:keyword]
      if keyword==nil then keyword="" end #キーワードがnilなら空にする
      @keyword=keyword
      @max_value = 0;
      if defined?(params[:show]['sort']) then @sort=params[:show]['sort'] else @sort="距離が近い順" end
      @page=params[:page].to_i

      #選択した施設が重複していないかチェック
      @error=false
      for i in 0..3 do
          for j in 1..4 do
              if i<j && @destination[i]==@destination[j] then
                  @error=true
              end
          end
      end

      #住宅取得
      @housings=[]
      @options=[] #住宅の付随情報
      if session[@user_name]!=nil then user=User.select("id").where("user_name = :user_name",user_name: @user_name)
      else user=nil end
      housings=Housing.all
      housings.each{|housing|
              if housing.vacancy=="" then next end #空き部屋がない住宅は飛ばす
              
              #お気に入り登録されているか調べる
              fav_flag=0
              if user!=nil then
                  favorite=Favorite.where("user_id = :user_id and housing_id = :housing_id",user_id: user[0].id,housing_id: housing.id)
                  if favorite.length>0 then fav_flag=1 end
              else fav_flag=0 end
              
              #お気に入りリスト表示の場合、お気に入り登録されていない奴は飛ばす
              if @slope!="yes" && @slope!="no" && fav_flag==0 then next end
              
              flag=0
              if keyword!="" then #絞り込みあり
                  #見出し情報から
                  if housing.housing_type.include?(keyword) then flag=1 end
                  if housing.street_address.include?(keyword) then flag=1 end
                  if housing.direction.include?(keyword) then flag=1 end
                  if housing.layout.include?(keyword) then flag=1 end
                  
                  #詳細
                  if housing.detail.include?(keyword) then flag=1 end
                  if housing.structure.include?(keyword) then flag=1 end
                  if housing.trading_aspect.include?(keyword) then flag=1 end
                  if housing.vacancy.include?(keyword) then flag=1 end
                  
                  #お気に入り登録されているもの
                  if keyword=="お気に入り"||keyword=="おきに入り"||keyword=="お気にいり"||keyword=="おきにいり"||keyword=="オキニイリ"||keyword=="okiniiri"||keyword=="favorite"||keyword=="favorites" then
                      if fav_flag==1 then flag=1 end
                  end
              else
                  flag=1
              end
              
              if flag==1 then #ヒットしたら登録
                  @housings.push(housing)
                  @options.push({"favorite" => fav_flag})
              end
      }

      #距離情報取得
      @distances=[]
      dis_len=0
      @housings.each{|housing|
          @distances[dis_len]={"id" => dis_len, "value" => 0}
          (0..4).each{|num|
              facilities=Facility.where("name like ?","("+@destination[num]+")%") #候補一覧取得
              distances=[]
              facilities.each{|facility| #候補との距離取得
                  distance=Distance.where("housing_id = :housing_id and facility_id = :facility_id",housing_id: housing.id,facility_id: facility.id).order("distance")
                  distances.push(distance[0])
              }
              min_index=0 #一番近い施設
              min_value=distances[0].distance #最小値
              index=0
              distances.each{|distance|
                  if distance.distance<min_value then #より近い施設発見
                      min_index=index
                      min_value=distance.distance
                  end
                  index+=1
              }

              @distances[dis_len][@destination[num]]={"value" => min_value , "facility" => facilities[min_index] }
          }
          dis_len+=1
      }

      #評価値決定
      @distances.each{|distance|
          if @slope=='yes' then #坂を気にする
              (0..4).each{|num|
                  distance[@destination[num]]["value"]**=1.1
              }
          end

          if @filter=="4" then
            distance["value"]=distance[@destination[0]]["value"]+distance[@destination[1]]["value"]*0.7+distance[@destination[2]]["value"]*0.3+distance[@destination[3]]["value"]*0.1
          elsif @filter=="3" then
            distance["value"]=distance[@destination[0]]["value"]+distance[@destination[1]]["value"]*0.7+distance[@destination[2]]["value"]*0.3
          elsif @filter=="2" then
            distance["value"]=distance[@destination[0]]["value"]+distance[@destination[1]]["value"]*0.7
          elsif @filter=="1" then
            distance["value"]=distance[@destination[0]]["value"]
          else
            @filter="5"
            distance["value"]=distance[@destination[0]]["value"]+distance[@destination[1]]["value"]*0.7+distance[@destination[2]]["value"]*0.3+distance[@destination[3]]["value"]*0.1+distance[@destination[4]]["value"]*0.01
          end
      }

      #並べ替え
      if @sort=="距離が近い順" then
        @distances.sort!{|a, b| a["value"] <=> b["value"] }
      elsif @sort=="賃料が安い順" then
        @distances.sort!{|a, b| @housings[a["id"]].rent <=> @housings[b["id"]].rent }
      elsif @sort=="賃料が高い順" then
        @distances.sort!{|a, b| @housings[b["id"]].rent <=> @housings[a["id"]].rent }
      elsif @sort=="面積が広い順" then
        @distances.sort!{|a, b| @housings[b["id"]].area <=> @housings[a["id"]].area }
      elsif @sort=="人気が高い順" then
        @distances.sort!{|a, b| @housings[b["id"]].favorites <=> @housings[a["id"]].favorites }
      elsif @sort=="閲覧が多い順" then
        @distances.sort!{|a, b| @housings[b["id"]].views <=> @housings[a["id"]].views }
      end

      #最も大きい評価値を調べる
      @distances.each{|distance|
        (0..4).each{|num|
          if @max_value < distance[@destination[num]]["value"]
            @max_value = distance[@destination[num]]["value"]
          end
        }
      }
      
      #ページ情報取得
      len=@distances.length-1
      if len<0 then len=0 end
      @max_page=(len/10)+1 #最大ページ番号
      if @page==nil then @page=1 #デフォルトは1
      elsif @page<1 then @page=1 #最小1
      elsif @page>@max_page then @page=@max_page end #最大は@max_page
      @dis_num=-1 #焦点を当てている物件番号

      #広告取得
      advertisings=Advertising.all
      @advertisings=[]
      if advertisings.length>0 then
          (0..4).each{|num|
              @advertisings[num]=advertisings[rand(0..advertisings.length-1)]
          }
      end

  end

  def detail
    @max_value=params[:max_value]
    @user_name=params[:user_name]
    housing_id=params[:housing_id]
    @distance={}
    @destination={}
    dis_num=0
    params[:distances].each{|key,value|
        @destination[dis_num]=key
        @distance[key]={ "value"=>value , "facility"=>Facility.find(params[:facilities][dis_num]) }
        dis_num+=1
    }
    @filter=params[:filter]
    @slope=params[:slope]
    @keyword=params[:keyword]
    @sort=params[:sort]
    @page=params[:page].to_i
    @user=User.select("id,user_name").where("user_name = :user_name",user_name: @user_name)
    @housing=Housing.find(housing_id)
    @inc=IncAccount.find(@housing.inc_account_id)
    @store=Store.find(@housing.store_id)

    #お気に入り登録
    fav=params[:fav]
    if session[@user_name]!=nil && fav=="登録" then
        favorite=Favorite.where("user_id = :user_id and housing_id = :housing_id",user_id: @user[0].id,housing_id: @housing.id)
        if favorite.length==0 then
            Favorite.create(:user_id=>@user[0].id , :housing_id=>@housing.id , :store_id=>@store.id , :inc_account_id=>@inc.id)
            @housing.favorites+=1 #お気に入り件数増やす
            @housing.save
        end
    end

    #お気に入り削除
    if session[@user_name]!=nil && fav=="削除" then
        favorite=Favorite.where("user_id = :user_id and housing_id = :housing_id",user_id: @user[0].id,housing_id: @housing.id)
        if favorite.length>0 then
            favorite[0].destroy
            @housing.favorites-=1 #お気に入り件数減らす
            @housing.save
        end
    end

    #お気に入り登録しているか調べる
    @favorite=[]
    if session[@user_name]!=nil then
        favorites=Favorite.where("user_id = :user_id and housing_id = :housing_id",user_id: @user[0].id,housing_id: @housing.id)
        if favorites.length>0 then @favorite.push(favorites[0]) end
    end

    #閲覧数カウント
    if fav!="登録" && fav!="削除" then
        @housing.views+=1
        @housing.save
    end

    #広告取得
    advertisings=Advertising.all
    @advertisings=[]
    if advertisings.length>0 then
        (0..4).each{|num|
            @advertisings[num]=advertisings[rand(0..advertisings.length-1)]
        }
    end

  end

  def logout
      @user_name = params[:user_name]
      session[@user_name] = nil
      redirect_to '/search/form'
  end

  def image
      @image=Image.find(params[:id])
      send_data @image.image, :type => 'image/jpeg', :disposition => 'inline'
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :mail_address)
  end
end
