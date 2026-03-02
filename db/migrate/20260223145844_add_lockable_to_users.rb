class AddLockableToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: false #失敗回数のカウント初期値　0＝（nil + 1）という計算にて確認するため０推奨
    add_column :users, :unlock_token, :string #ロック解除用トークン
    add_column :users, :locked_at, :datetime #ロックされた日時

    add_index :users, :unlock_token, unique: true
  end
end