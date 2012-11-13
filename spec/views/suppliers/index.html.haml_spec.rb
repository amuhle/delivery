require 'spec_helper'

describe "suppliers/index" do
  before(:each) do
    assign(:suppliers, [
      stub_model(Supplier,
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :address => "Address",
        :rut => "Rut",
        :contact_person => "Contact Person"
      ),
      stub_model(Supplier,
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :address => "Address",
        :rut => "Rut",
        :contact_person => "Contact Person"
      )
    ])
  end

  it "renders a list of suppliers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Rut".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Person".to_s, :count => 2
  end
end
