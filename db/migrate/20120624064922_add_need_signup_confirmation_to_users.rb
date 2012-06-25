class AddNeedSignupConfirmationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :need_signup_confirmation, :boolean

  end
end
