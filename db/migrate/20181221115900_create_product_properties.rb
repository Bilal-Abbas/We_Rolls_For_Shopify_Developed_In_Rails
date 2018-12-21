class CreateProductProperties < ActiveRecord::Migration[5.0]
   def change
    create_table :product_properties do |t|
      t.integer :product_detail_id
      t.string :property_key
      t.string :property_value

      t.timestamps
    end
  end
end
