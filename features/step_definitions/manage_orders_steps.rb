#steps for manage orders
Given /^I have the following orders:$/ do |table|
  table.hashes.each do |order|
    Order.create!( notes: order[:notes], due_date: order[:due_date], total: order[:total], 
                    client_id: order[:client_id], user_id: order[:user_id], 
                    delivery_address: order[:delivery_address] 
                  )
  end
end

Then /^I should see "(.*)" order(s)?$/ do |list, plural|
  orders_list = list.split(',')
  orders_list.each do |order|
    assert page.has_content?(order.strip)
  end
end


Then /^I visit "(.*)" order details$/ do |element|
  order = Order.find_by_number("#{element}")
  visit "/orders/#{order.id}"
end
