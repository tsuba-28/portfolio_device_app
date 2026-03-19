class Users::SessionsController < ApplicationController
  def guest_sign_in
    #modelに作成したメソッドからデータを取得
    user = User.guest

    #Deviseが用意しているログイン用メソッドに取得したデータを渡し、ログイン
    sign_in user

    #ログイン後トップページ（root_path）にリダイレクト→メッセージ表示
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end
end