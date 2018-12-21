class Product < ApplicationRecord

	require 'open-uri'
	require "base64"

  belongs_to :shop
  #has_many :images, as: :parent, dependent: :destroy, autosave: true

  #accepts_nested_attributes_for :images

  after_destroy :remove_from_shopify


  	def build_assets(images)
    	if images.present?
    		images["avatar"].each do |image|
				self.images.create(avatar: image)
    		end
    	end
    end

  	def self.sync_shopify
    	SyncShopifyWorker.perform_async()
  	end

  	def remove_from_shopify
	    product = ShopifyAPI::Product.find(self.shopify_id) if self.shopify_id.present?
	    product.destroy  if product.present?
  	end


	def save_to_shopify(shop)
	    if self.shopify_id.present?
	    	@shopify_product = ShopifyAPI::Product.find(self.shopify_id) rescue nil
	    	@shopify_variant = ShopifyAPI::Variant.find(:all, params: {product_id: self.shopify_id}).first rescue nil
	    else
	      	@shopify_product = ShopifyAPI::Product.new
	      	@shopify_product.images = []
	    	@shopify_variant = ShopifyAPI::Variant.new
	    end

	    if @shopify_variant.present?
		    @shopify_variant.price = self.price
		    @shopify_variant.sku = self.title.upcase + self.created_at.to_s.upcase
		    @shopify_variant.compare_at_price = self.compare_at_price
		    @shopify_variant.requires_shipping = self.requires_shipping
		    @shopify_variant.fulfillment_service = 'manual'
		    @shopify_variant.taxable = self.taxable
		end
	    if @shopify_product.present?
		    @shopify_product.title = self.title
	      	@shopify_product.body_html = self.description
		    @shopify_product.vendor = 'WeRoll'
		    @shopify_product.product_type = 'custom'
		    @shopify_product.published_scope = 'global'
		    @shopify_product.variants = []
		    @shopify_product.variants << @shopify_variant
	    	@shopify_product.save
		end

      	if self.images.present?
	        self.images.each_with_index do |image, index|
	        	if image.avatar.url.include?('s3')
	        		if image.avatar.url.include?('https')
	        			image = ShopifyAPI::Image.new(src: image.avatar.url(:medium))
	        		else
	        			image = ShopifyAPI::Image.new(src: 'https:' + image.avatar.url(:medium))
	        		end
		        	image.prefix_options[:product_id] = @shopify_product.id
		        	image.save rescue ''
	        	end
	        end
      	end
		self.update(shopify_id: @shopify_product.id, created_at_shopify: @shopify_product.created_at, updated_at_shopify: @shopify_product.updated_at, published_at_shopify: @shopify_product.published_at)
	end
end

end
