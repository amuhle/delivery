require 'spec_helper'

describe "admins/edit" do
  before(:each) do
    @admin = assign(:admin, stub_model(Admin,
      :email => "MyString",
      :encrypted_password => "MyString"
    ))
  end

  it "renders the edit admin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admins_path(@admin), :method => "post" do
      assert_select "input#admin_email", :name => "admin[email]"
      assert_select "input#admin_encrypted_password", :name => "admin[encrypted_password]"
    end
  end
end
