class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
    	t.string :title
	    t.string :description
	    t.float       :price
	    t.float       :compare_price
	    t.boolean     :shipping, default: false
	    t.float       :weight
	    t.boolean     :tax, default: false
	    t.boolean     :allow_buying_if_out_of_stock, default: false
	    t.string      :shopify_id
	    t.belongs_to  :shop
	    t.timestamps
    end
  end
end
