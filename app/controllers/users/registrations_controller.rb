class Users::RegistrationsController < Devise::RegistrationsController
  #updateとdestroyのアクション実行前にログインユーザーチェックを実行
  before_action :ensure_normal_user, only: [:update, :destroy]

  def ensure_normal_user
    #もし現在のログインユーザーのメールアドレスがゲストのものだったら
    if resource.email == 'guestguest33@sample.com'
      #トップページに強制遷移を実行し、エラーメッセージを表示する。
      redirect_to root_path, alert: "ゲストユーザーは情報の編集 / 退会を行うことはできません。"
    end
  end
end