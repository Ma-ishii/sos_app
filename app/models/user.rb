class User < ApplicationRecord

  # email属性を小文字に変換
  before_save { self.email = email.downcase }

  # nameに対してのバリデーション　presence(存在性)、length(文字数制限)
  validates :name,  presence: true, length: { maximum: 50 }


  # emailに対してのバリデーション　presence(存在性)、length(文字数制限)、
  # 　　　　　　　　　　　　　　　　format(テンプレート)、uniqueness(一意性)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i


  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                                # メールアドレスの大小区別しない一意性の検証
                    uniqueness: { case_sensitive: false }

  # paswordに対してのバリデーション　presence(存在性)、length(文字数制限)
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }

end
