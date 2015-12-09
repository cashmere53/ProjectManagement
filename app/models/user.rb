class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :user_name,
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
end
