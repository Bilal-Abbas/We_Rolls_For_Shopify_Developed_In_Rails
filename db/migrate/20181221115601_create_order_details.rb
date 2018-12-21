class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.integer :order_uuid, :limit => 8
      t.string :shipping_title
      t.datetime :order_date
      t.string :order_status
      t.string :payment_status
      t.string :customer_email
      t.string :customer_phone
      t.string :total_amount
      t.string :shipping_address
      t.string :billing_address
      t.boolean :local_status, default: false

      t.timestamps
    end
  end
end
