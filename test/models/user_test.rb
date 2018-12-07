require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # バリデーションを満たすユーザーの作成 name:名前、email:メール、password:パスワード
  #                                password_confirmation:パスワード確認の値
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foober", password_confirmation: "foober")
  end

  # ユーザーの有効性(valid)のテスト　有効なユーザーであればtrueを返す
  test "should be valid" do
    assert @user.valid?
  end

  # nameの存在性のテスト　nameが空のとき無効であればtrueを返す
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  # nameの文字数制限のテスト　51文字以上の文字数の名前が無効である場合trueを返す
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  # emailの存在性のテスト　emailが空のとき無効である場合trueを返す
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  # emailの文字数制限のテスト　256文字以上の文字数のメールアドレスが無効である場合trueを返す
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  # emailのフォーマットの有効性のテスト　正規表現に該当しないメールアドレスが無効である場合trueを返す
  test "email validation should reject invalid addresses" do
    # 無効なemailを複数自動作成
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      # assert_notの第２引数にエラーメッセージを追加
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # emailの一意性に対してのテスト　同じメールアドレスが無効である場合trueを返す
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # メールアドレスの小文字化に対するテスト　引数１と引数２が等しい場合trueを返す
  test "email address should be saved as lower-cace" do
    mixed_cace_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_cace_email
    @user.save
    assert_equal mixed_cace_email.downcase, @user.reload.email
  end

  # パスワードが空文字でないことのテスト　パスワードが空文字の場合trueを返す
  test "password should be present (nonblank)" do
    # @user.passwordと@user.password_confirmationの２つに同時に代入（多重代入）
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  # パスワードが６文字以上であることのテスト　パスワードが５文字以下である場合trueを返す
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
