class ProductDetail < ApplicationRecord

	belongs_to :order_detail
	has_many :product_properties

end
