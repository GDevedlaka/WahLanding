class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :email
      t.string :insta_handle

      t.timestamps
    end
  end
end
