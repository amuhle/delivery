require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :email => "MyString",
      :encrypted_password => "MyString",
      :reset_password_token => "MyString",
      :sign_in_count => 1,
      :current_sign_in_ip => "MyString",
      :last_sign_in_ip => "MyString",
      :supplier_id => 1,
      :is_admin => false
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_encrypted_password", :name => "user[encrypted_password]"
      assert_select "input#user_reset_password_token", :name => "user[reset_password_token]"
      assert_select "input#user_sign_in_count", :name => "user[sign_in_count]"
      assert_select "input#user_current_sign_in_ip", :name => "user[current_sign_in_ip]"
      assert_select "input#user_last_sign_in_ip", :name => "user[last_sign_in_ip]"
      assert_select "input#user_supplier_id", :name => "user[supplier_id]"
      assert_select "input#user_is_admin", :name => "user[is_admin]"
    end
  end
end
