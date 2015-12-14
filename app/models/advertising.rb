class Advertising < ActiveRecord::Base
  belongs_to :inc_account

  validates :image,
            presence: { message: "⚠画像が選択されていません" }
end
