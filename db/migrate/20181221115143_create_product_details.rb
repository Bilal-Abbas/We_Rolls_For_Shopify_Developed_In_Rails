class CreateProductDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :product_details do |t|
      t.integer :order_detail_id
      t.string :sku
      t.string :name
      t.string :quantity
      t.string :price

      t.timestamps
    end
  end
end
