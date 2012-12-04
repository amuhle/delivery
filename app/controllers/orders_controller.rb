class OrdersController < ApplicationController

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.last_twenty
    @q = Order.search(params[:q])
    @client = Client.new

    @status = Order::STATUS
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def search
    @q = Order.search(params[:q])
    @orders = @q.result(:distinct => true)
    @client = Client.new id: params[:id_client], name: params[:client_name]

    @status = Order::STATUS
    render :index
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order    = Order.new
    @order.invoice_number = Order.last.blank? ? 1 : Order.last.invoice_number.to_i + 1
    @clients  = @current_suppllier.clients
    @products = @current_suppllier.products

    @client   = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @clients = current_user.supplier.clients
    @client = Client.new
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    if current_user
      @order.user = current_user
    elsif current_admin
      @order.admin = current_admin
    end
    unless params[:id_client].blank?
      @order.client_id = params[:id_client]
    end
    respond_to do |format|
      if @order.save
        total = 0
        params.keys.each do |k| 
          if k.to_s =~ /^prod_ord/
            id = k.to_s.split('-')[1]
            val_pri = params[k].split('-')
            value = val_pri[0].to_i
            price = val_pri[1].to_i
            total += (price * value)
            ProductOrder.create(product_id: id.to_i,order_id: @order.id,quantity: value,price: price)
          end
        end
        @order.total = total
        @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    @clients = @current_suppllier.clients
    @products = ProductOrder.where(:order_id => @order.id)
    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
  
  def new_client
    @client = Client.new(params[:client])
    @client.supplier_id = current_user.supplier.id
    
    respond_to do |format|
      if @client.save
        format.json { render json: @client.to_json(only: [:id,:name,:address]) }
      else
        format.html { render action: "new_client" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  def update_status
    @order = Order.find(params[:id].to_i)
    @order.status = params[:status]
    if @order.save
      respond_to do |format|
        format.json { render json: @order.to_json(only: :status) }
      end
    end
  end

  def pay
    @order = Order.find(params[:id])
    @order.pay = !@order.pay
    if @order.save
      respond_to do |format|
        format.json { render json: @order.to_json(only: [:id,:pay]) }
      end
    end
  end

  def active
    @order = Order.find(params[:id])
    @order.active = !@order.active
    if @order.save
      respond_to do |format|
        format.json { render json: @order.to_json(only: [:id,:active]) }
      end
    end
  end

end
