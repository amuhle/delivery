require 'spec_helper'

describe ClientsController do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Client. As you add validations to Client, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      name:     "VAIRIX",
      rut:      "19089098",
      contact:  "Alvaro",
      address:  "25 de mayo 555 of 409",
      email:    "contacto@vairix.com",
      phone:    "29103024"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClientsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all clients as @clients" do
      client = Client.create! valid_attributes
      get :index, {}, valid_session
      assigns(:clients).should eq([client])
    end
  end

  describe "GET show" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes
      get :show, {:id => client.to_param}, valid_session
      assigns(:client).should eq(client)
    end
  end

  describe "GET new" do
    it "assigns a new client as @client" do
      get :new, {}, valid_session
      assigns(:client).should be_a_new(Client)
    end
  end

  describe "GET edit" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes
      get :edit, {:id => client.to_param}, valid_session
      assigns(:client).should eq(client)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Client" do
        expect {
          post :create, {:client => valid_attributes}, valid_session
        }.to change(Client, :count).by(1)
      end

      it "assigns a newly created client as @client" do
        post :create, {:client => valid_attributes}, valid_session
        assigns(:client).should be_a(Client)
        assigns(:client).should be_persisted
      end

      it "redirects to the created client" do
        post :create, {:client => valid_attributes}, valid_session
        response.should redirect_to(Client.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved client as @client" do
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        post :create, {:client => {}}, valid_session
        assigns(:client).should be_a_new(Client)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        post :create, {:client => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested client" do
        client = Client.create! valid_attributes
        # Assuming there are no other clients in the database, this
        # specifies that the Client created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Client.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => client.to_param, :client => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested client as @client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
        assigns(:client).should eq(client)
      end

      it "redirects to the client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
        response.should redirect_to(client)
      end
    end

    describe "with invalid params" do
      it "assigns the client as @client" do
        client = Client.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        put :update, {:id => client.to_param, :client => {}}, valid_session
        assigns(:client).should eq(client)
      end

      it "re-renders the 'edit' template" do
        client = Client.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        put :update, {:id => client.to_param, :client => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect {
        delete :destroy, {:id => client.to_param}, valid_session
      }.to change(Client, :count).by(-1)
    end

    it "redirects to the clients list" do
      client = Client.create! valid_attributes
      delete :destroy, {:id => client.to_param}, valid_session
      response.should redirect_to(clients_url)
    end
  end

end
