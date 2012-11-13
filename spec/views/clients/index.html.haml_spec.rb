require 'spec_helper'

describe "clients/index" do
  before(:each) do
    assign(:clients, [
      stub_model(Client,
        :name => "Name",
        :rut  => "19089989",
        :contact => "Alvaro",
        :email => "Email",
        :address => "Address",
        :phone => "Phone"
      ),
      stub_model(Client,
        :name => "Name",
        :rut  => "190455455",
        :contact => "Carlos",
        :email => "Email",
        :address => "Address",
        :phone => "Phone"
      )
    ])
  end

  it "renders a list of clients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
  end
end
