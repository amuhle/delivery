#steps for manage clients
Given /^I have the following users:$/ do |table|
  table.hashes.each do |user|
    User.create!( email: user[:email], password: user[:password], password_confirmation: user[:user], supplier_id: user[:supplier_id])
  end
end

Given /^I am not authenticated$/ do
  visit('/admins/sign_out') # ensure that at least
end

Given /^I am a new, authenticated admin$/ do
  email = 'admin@admin.net'
  password = 'prueba'
  Supplier.create!( name: "VAIRIX", phone: "099885065", email: "vairix@vairix.com",
                    address: "25 de mayo 555 / 409", rut: "98098189819", contact_person: "Alvaro" 
                  )
  Admin.create!(:email => email, :password => password, :password_confirmation => password, supplier_id: 1)

  visit '/admins/sign_in'
  fill_in "admin_email", :with => email
  fill_in "admin_password", :with => password
  click_button "sign_in"
end


Then /^I should see "(.*)" user(s)?$/ do |list,us|
  users_list = list.split(',')
  users_list.each do |us|
    assert page.has_content?(us.strip)
  end
end


Then /^I visit "(.*)" user details$/ do |element|
  user = User.find_by_email("#{element}")
  visit "/users/#{user.id}"
end
