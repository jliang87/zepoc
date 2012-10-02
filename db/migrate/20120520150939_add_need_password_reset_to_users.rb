class AddNeedPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :need_password_reset, :boolean

  end
end
