 require 'pry'
 def consolidate_cart(cart)
  new_cart = {}
  count = 0
  cart.each do |element|
    element.each do |food, hash|
      if new_cart[food]
        new_cart[food][:count] += 1 
      else 
        new_cart[food] = hash 
        new_cart[food] = 1 
      end 
      # new_cart[food] ||= hash 
      # new_cart[food][:count] ||= 0 
      # new_cart[food][:count] += 1  
    end 
  end 
  return new_cart
end 


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    new_cart = "#{name} W/COUPON"
    if cart[name] && cart[name][:count] >= coupon[:num]
      cart[name][:count] -= coupon[:num]
      if cart[new_cart]
        cart[new_cart][:count] += coupon[:num] 
      else 
        cart[new_cart] = {
        :price => coupon[:cost]/coupon[:num],
        :clearance => cart[name][:clearance],
        :count => coupon[:num] 
      }
      end 
    end
  end 
  return cart
end 
    

def apply_clearance(cart)
  cart.each do |name, properties|
    if properties[:clearance] == true
      properties[:price] = (properties[:price] * 0.80).round(2) 
    end
  end 
  cart
end


def checkout(cart, coupons)
  total = 0
    new_cart = consolidate_cart(cart)
    coupon_cart = apply_coupons(consolidated, coupons)
    clearance_cart = apply_clearance(coupon_cart)
    clearance_cart.each do |item, attribute|
      total += (attribute[:price] * attribute[:count])
    end 
    if total > 100
      total *= 0.9
    end 
    total
      
      binding.pry
  # new_hash = {}
  # cart.each do |food, info|
  #   new_hash[food] ||= info
  #   new_hash[food][:count] ||= 0
  #   new_hash[food][:count] += 1
  #   coupons.each do |coupon|
  #     if info[:count] > coupon[:num]
  #       apply_coupons(cart, coupons)
  #     end
  #     if info[:clearance] == true
  #       apply_clearance(cart)
  #     end
  #     if cart[:price].sum > 100
  #       new_hash[food][:price] = cart[food][:price] - (info[:price] * 0.10).round(2)
  #     end
  #   end
  # end 
  # return new_hash
end 


#   #for each item in the cart, the new cart food will be the key, the new cart food count will start at 0 and equal the new cart food count or 0 and count by 1. the new cart food will equal the new cart food or the value.
#   #if cart count == coupon count then cart price - coupon price is equal to new cart price
#   #if cart item clearance == true then cart item price - 20% of cart item price is equal to new cart price
#   #if total price of all items > 100 then new cart item price - 10% will equal the full discount price. 
# end
