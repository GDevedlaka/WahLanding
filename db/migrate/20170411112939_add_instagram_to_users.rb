class AddInstagramToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :instahandle, :string
  end
end
