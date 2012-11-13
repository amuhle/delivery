require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
        :notes => "MyText",
        :total => 1,
        :client => nil,
        :user => nil,
        :supplier => nil,
        :delivery_address => "Delivery Address"
      ),
      stub_model(Order,
        :notes => "MyText",
        :total => 1,
        :client => nil,
        :user => nil,
        :supplier => nil,
        :delivery_address => "Delivery Address"
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Delivery Address".to_s, :count => 2
  end
end
