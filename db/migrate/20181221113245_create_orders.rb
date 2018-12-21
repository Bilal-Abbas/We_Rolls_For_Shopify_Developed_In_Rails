class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
    	t.string   :shopify_id
    	t.string   :email
    	t.string   :name
    	t.datetime :closed_at_shopify
    	t.datetime :created_at_shopify
    	t.datetime :updated_at_shopify
    	t.string   :shopify_token
    	t.string   :shopify_number
    	t.string   :shopify_gateway
    	t.boolean  :test, default: false
    	t.float    :total_price
    	t.float    :subtotal_price
    	t.float    :total_tax
    	t.boolean  :taxes_included, default: false
    	t.string   :financial_status
    	t.boolean  :confirmed , default: true
    	t.datetime :cancelled_at
    	t.string   :cancel_reason
    	t.string   :shopify_user_id
    	t.string   :shopify_location_id
    	t.string   :shopify_contact_email
    	t.string   :shopify_order_number
    	t.string   :shopify_order_status_url
    	t.string   :shopify_source_name
    	t.string   :shopify_processing_method
    	t.belongs_to :customer

    	t.text     :payment_gateway_names, array: true, default: []



      t.timestamps
    end
  end
end
