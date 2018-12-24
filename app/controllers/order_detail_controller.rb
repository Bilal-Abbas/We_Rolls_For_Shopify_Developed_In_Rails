class OrderDetailController < ApplicationController
	
	def all_orders

		@products = ProductDetail.all

	end
end
