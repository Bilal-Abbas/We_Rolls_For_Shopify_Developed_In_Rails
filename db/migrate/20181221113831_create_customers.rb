class CreateCustomers < ActiveRecord::Migration[5.0]
   def change
    create_table :customers do |t|
    	t.string   :shopify_id
    	t.string   :email
    	t.string   :address
    	t.boolean  :accept_marketing, default: true
    	t.datetime :created_at_shopify
    	t.datetime :updated_at_shopify
    	t.string   :first_name
    	t.string   :last_name
    	t.integer  :shopify_orders_count
    	t.string   :state
    	t.float    :total_spent
    	t.string   :last_order_id
    	t.boolean  :verified_shopify_email, default: false
    	t.boolean  :tax_exempt_shopify, default: false
    	t.string   :phone
      t.timestamps
    end
  end
end
