class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :shopify_app_settings
  
	def after_sign_in_path_for(resource)
	     if current_user.super_admin?
	       root_path
	  	 end
	end

	def after_sign_out_path_for(resource)
		Devise::SessionsController_path
	end


  def shopify_app_settings
  	shop_url = "https://0836388da714550d1c6a8f51bf848be8:65eaa1e76d3000b06dc38621ef8636df@coordinates-collection.myshopify.com/admin"
  	ShopifyAPI::Base.site = shop_url
  	@shopify_shop = ShopifyAPI::Shop.current
  	@shop = Shop.validate_shop(@shopify_shop)
  end

  private


  def after_sign_out_path_for(resource_or_scope)
  	ShopifyAPI::Base.clear_session
  end
end
