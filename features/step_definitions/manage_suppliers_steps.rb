#steps for manage suppliers
Given /^I have the following suppliers:$/ do |table|
  table.hashes.each do |supplier|
    Supplier.create!( name: supplier[:name], phone: supplier[:phone], email: supplier[:email], 
                    address: supplier[:address], rut: supplier[:rut], contact_person: supplier[:contact_person] 
                  )
  end
end


Then /^I should see "(.*)" supplier(s)?$/ do |list,cl|
  suppliers_list = list.split(',')
  suppliers_list.each do |sup|
    assert page.has_content?(sup.strip)
  end
end


Then /^I visit "(.*)" supplier details$/ do |element|
  supplier = Supplier.find_by_name("#{element}")
  visit "/suppliers/#{supplier.id}"
end
