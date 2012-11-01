require 'spec_helper'

describe "admins/new" do
  before(:each) do
    assign(:admin, stub_model(Admin,
      :email => "MyString",
      :encrypted_password => "MyString"
    ).as_new_record)
  end

  it "renders new admin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admins_path, :method => "post" do
      assert_select "input#admin_email", :name => "admin[email]"
      assert_select "input#admin_encrypted_password", :name => "admin[encrypted_password]"
    end
  end
end
