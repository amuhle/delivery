require 'spec_helper'

describe "suppliers/edit" do
  before(:each) do
    @supplier = assign(:supplier, stub_model(Supplier,
      :name => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :address => "MyString",
      :rut => "MyString",
      :contact_person => "MyString"
    ))
  end

  it "renders the edit supplier form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => suppliers_path(@supplier), :method => "post" do
      assert_select "input#supplier_name", :name => "supplier[name]"
      assert_select "input#supplier_phone", :name => "supplier[phone]"
      assert_select "input#supplier_email", :name => "supplier[email]"
      assert_select "input#supplier_address", :name => "supplier[address]"
      assert_select "input#supplier_rut", :name => "supplier[rut]"
      assert_select "input#supplier_contact_person", :name => "supplier[contact_person]"
    end
  end
end
