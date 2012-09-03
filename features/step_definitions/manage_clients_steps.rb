#steps for manage clients
Given /^I have the following clients:$/ do |table|
  table.hashes.each do |client|
    Client.create!( name: client[:name], rut: client[:rut], contact: client[:contact], 
                    address: client[:address], email: client[:email], phone: client[:phone] 
                  )
  end
end

Given 'I am logged as User' do
  
end

Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am a new, authenticated user$/ do
  email = 'testing-spec@man.net'
  password = 'secretpass'
  User.new(:email => email, :password => password, :password_confirmation => password).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end


Then /^I should see "(.*)" clients$/ do |list|
  clients_list = list.split(',')
  clients_list.each do |cl|
    assert page.has_content?(cl.strip)
  end
end


