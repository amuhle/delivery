require 'spec_helper'

describe "clients/show" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :name => "Name",
      :rut => "190898989",
      :contact => "Alvaro",
      :email => "Email",
      :address => "Address",
      :phone => "Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/Address/)
    rendered.should match(/Phone/)
  end
end
