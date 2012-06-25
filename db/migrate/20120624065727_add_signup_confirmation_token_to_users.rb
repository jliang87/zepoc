class AddSignupConfirmationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signup_confirmation_token, :string

  end
end
