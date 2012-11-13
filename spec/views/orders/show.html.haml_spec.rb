require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :notes => "MyText",
      :total => 1,
      :client => nil,
      :user => nil,
      :supplier => nil,
      :delivery_address => "Delivery Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Delivery Address/)
  end
end
