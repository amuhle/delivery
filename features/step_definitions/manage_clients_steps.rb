#steps for manage clients
Given /^I have the following clients:$/ do |table|
  table.hashes.each do |client|
    Client.create!( name: client[:name], rut: client[:rut], contact: client[:contact], 
                    address: client[:address], email: client[:email], phone: client[:phone], supplier_id: client[:supplier_id] 
                  )
  end
end

Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am a new, authenticated user$/ do
  email = 'testing-spec@man.net'
  password = 'secretpass'
  Supplier.create!( name: "VAIRIX", phone: "099885065", email: "vairix@vairix.com",
                    address: "25 de mayo 555 / 409", rut: "98098189819", contact_person: "Alvaro" 
                  )
  User.create!(:email => email, :password => password, :password_confirmation => password, supplier_id: 1)

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "sign_in"
end


Then /^I should see "(.*)" client(s)?$/ do |list,cl|
  clients_list = list.split(',')
  clients_list.each do |cl|
    assert page.has_content?(cl.strip)
  end
end


Then /^I visit "(.*)" client details$/ do |element|
  client = Client.find_by_name("#{element}")
  visit "/clients/#{client.id}"
end
