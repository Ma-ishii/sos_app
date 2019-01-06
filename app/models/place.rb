class Place < ApplicationRecord
  belongs_to :user
  # デフォルトの順序付の設定
  default_scope -> { order(created_at: :desc) }





  #画像アップローダー
  mount_uploader :picture, PictureUploader
  validate :picture_size

  # Placeモデルへバリデーション追加
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 140 }




  
  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
