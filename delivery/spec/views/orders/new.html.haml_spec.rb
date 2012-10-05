require 'spec_helper'

describe "orders/new" do
  before(:each) do
    assign(:order, stub_model(Order,
      :notes => "MyText",
      :total => 1,
      :client => nil,
      :user => nil,
      :supplier => nil,
      :delivery_address => "MyString"
    ).as_new_record)
  end

  it "renders new order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path, :method => "post" do
      assert_select "textarea#order_notes", :name => "order[notes]"
      assert_select "input#order_total", :name => "order[total]"
      assert_select "input#order_client", :name => "order[client]"
      assert_select "input#order_user", :name => "order[user]"
      assert_select "input#order_supplier", :name => "order[supplier]"
      assert_select "input#order_delivery_address", :name => "order[delivery_address]"
    end
  end
end
