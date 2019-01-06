class User < ApplicationRecord
  attr_accessor :remember_token

  # Userモデルへ関連付け追加
  has_many :place
  # User削除とともにPlaceも破棄する設定
  has_many :place, dependent: :destroy





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
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self

    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end


  def feed
    Place.where("user_id = ?", id)
  end


end
