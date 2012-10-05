require 'spec_helper'

describe "clients/edit" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      name:     "VAIRIX",
      rut:      "19089098",
      contact:  "Alvaro",
      address:  "25 de mayo 555 of 409",
      email:    "contacto@vairix.com",
      phone:    "29103024"
    ))
  end

  it "renders the edit client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clients_path(@client), :method => "post" do
      assert_select "input#client_name", :name => "client[name]"
      assert_select "input#client_rut", :name => "client[rut]"
      assert_select "input#client_contact", :name => "client[contact]"
      assert_select "input#client_email", :name => "client[email]"
      assert_select "input#client_address", :name => "client[address]"
      assert_select "input#client_phone", :name => "client[phone]"
    end
  end
end
