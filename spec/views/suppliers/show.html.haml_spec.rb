require 'spec_helper'

describe "suppliers/show" do
  before(:each) do
    @supplier = assign(:supplier, stub_model(Supplier,
      :name => "Name",
      :phone => "Phone",
      :email => "Email",
      :address => "Address",
      :rut => "Rut",
      :contact_person => "Contact Person"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Phone/)
    rendered.should match(/Email/)
    rendered.should match(/Address/)
    rendered.should match(/Rut/)
    rendered.should match(/Contact Person/)
  end
end
