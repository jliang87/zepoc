class AddOauthFacebookToUser < ActiveRecord::Migration
  def change
    [:provider, :uid, :name, :oauth_token].each do |column|
      add_column :users, column, :string
    end

    add_column :users, :oauth_expires_at, :datetime
  end
end
