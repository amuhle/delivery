require 'spec_helper'

describe "admins/index" do
  before(:each) do
    assign(:admins, [
      stub_model(Admin,
        :email => "Email",
        :encrypted_password => "Encrypted Password"
      ),
      stub_model(Admin,
        :email => "Email",
        :encrypted_password => "Encrypted Password"
      )
    ])
  end

  it "renders a list of admins" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Encrypted Password".to_s, :count => 2
  end
end
