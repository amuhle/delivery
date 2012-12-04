Given /^I have the following products:$/ do |table|
  table.hashes.each do |product|
    Product.create!( name: product[:name], description: product[:description], price: product[:price],tax: product[:tax] ,supplier_id: product[:supplier_id] )
  end

end

Then /^I should see "(.*?)" product(s)?$/ do |list,pr|
  product_list = list.split(',')
  product_list.each do |prod|
    assert page.has_content?(prod.strip)
  end
end

Then /^I visit "(.*?)" product details$/ do |element|
  product = Product.find_by_name("#{element}")
  visit "/products/#{product.id}"
end
