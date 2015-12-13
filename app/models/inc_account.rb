class IncAccount < ActiveRecord::Base
  has_many :Store, dependent: :destroy
  has_many :Housing, dependent: :destroy, through: :Store
  has_many :Advertising, dependent: :destroy

  has_secure_password validations: false
  validates :inc_name,
    presence: { message: "⚠︎ユーザ名を入力してください" },
    uniqueness: { message: "⚠︎そのユーザ名は既に使われています" },
    length: { maximum: 255, message: "⚠︎ユーザ名は255文字以内で入力してください"}

  validates :mail_address,
    presence: { message: "⚠︎メールアドレスを入力してください" },
    uniqueness: { message: "⚠︎そのメールアドレスは既に使われています" },
    length: {maximum: 255, message: "⚠︎メールアドレスは255文字以内で入力してください" },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "⚠︎メールアドレスの形式で入力してください" }

  validates :password,
    presence: { message: "⚠︎パスワードを入力してください" },
    length: { in: 8..30, message: "⚠︎パスワードは8文字以上30文字以内で入力してください" },
    format: { with: /\A[a-zA-Z0-9-_]+\z/, message: "⚠︎パスワードは「a〜z, A〜Z, 0〜9, -, _」のみ使用してください" },
    confirmation: { message: "⚠︎パスワードが一致しません" }

  validates :phone_num,
    presence: { message: "⚠︎電話番号を入力してください" },
    length: { in: 8..30, message: "⚠︎電話番号は8文字以上30文字以内で入力してください" },
    format: { with: /\A[0-9]+\z/, message: "⚠︎パスワードは「0〜9」のみ使用してください" }

  validates :account_name,
    presence: { message: "⚠︎口座名義を入力してください" },
    length: { maximum: 255, message: "⚠︎口座名義は255文字以内で入力してください" },
    format: { with: /\A[a-zA-Z0-9-_]+\z/, message: "⚠︎パスワードは「a〜z, A〜Z, 0〜9, -, _」のみ使用してください" }
end
