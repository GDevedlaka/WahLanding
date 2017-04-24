class AddReferenceToRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :reference, :string
  end
end
