class HomeController < ApplicationController
 def index
    orders = ShopifyAPI::Order.all
    orders.each do |order|
      details = OrderDetail.where(order_uuid: order.id)
      if details.present?
        order_det = details.first
        order_det.update_attributes(order_status: order.fulfillment_status,payment_status: order.financial_status)
      else
        order_detail  = OrderDetail.create(order_uuid: order.id, shipping_title: order.shipping_lines.first.title,order_date: order.created_at, order_status: order.fulfillment_status,payment_status: order.financial_status, customer_email: order.customer.email, customer_phone: order.customer.phone,total_amount: order.total_price,shipping_address: "#{order.shipping_address.address1}, #{order.shipping_address.city},#{order.shipping_address.province}, #{order.shipping_address.country}", billing_address: "#{order.billing_address.address1}, #{order.billing_address.city},#{order.billing_address.province}, #{order.billing_address.country}")
        order.line_items.each do |product|
          product_detials = ProductDetail.create(order_detail_id: order_detail.id, sku: product.sku, name: product.name, quantity: product.quantity, price: product.price)
          if product.properties.count > 1
            product.properties.each do |property|
              ProductProperty.create(product_detail_id: product_detials.id, property_key: property.name,property_value: property.value)
            end
          end
        end
      end
    end
  end
end
