class Shop < ApplicationRecord
	include ShopifyApp::SessionStorage
  	has_many :products

  	def self.validate_shop(shopify_shop)
  		return Shop.find_or_create_by(shopify_token: shopify_shop.id, shopify_domain: shopify_shop.domain)
  	end
end
