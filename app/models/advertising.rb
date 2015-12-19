class Advertising < ActiveRecord::Base
  belongs_to :inc_account

  validates :advertise_info,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :image,
            presence: { message: "⚠画像が選択されていません" }

end
