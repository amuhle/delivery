class OrdersController < ApplicationController

  
  # GET /orders
  # GET /orders.json
  def index
    if params.length > 2
      pay = to_boolean(params[:pay])
      active = to_boolean(params[:active])
      status = params[:status]
      id_client = params[:id_client].blank? ? nil : params[:id_client].to_i
      begin_date = params[:begin_date].blank? ? nil : date_to_datetime(params[:begin_date])
      end_date = params[:end_date].blank? ? nil : date_to_datetime(params[:end_date])
      @orders = Order.where("active = :active AND pay = :pay AND status = :status AND (:id_client IS NULL OR client_id = :id_client) AND (:begin IS NULL OR due_date >= :begin) AND (:end IS NULL OR :end >= due_date)", :active => active, :pay => pay,:status => status,:id_client => id_client,:begin => begin_date,:end => end_date)
    else
      @orders = Order.all
    end
    @status = ['Pending','Delivered','Delayed']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
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
    @clients  = current_user.supplier.clients
    @products = Product.where(:supplier_id => current_user.supplier.id)
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
    @order.user = current_user
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
    @clients = current_user.supplier.clients
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

private

  def to_boolean(value)
    return true if value == "true"
    return false if value == "false"
  end

  def date_to_datetime(date_aux)
    date = date_aux.split("/")
    day = date[1].to_i
    month = date[0].to_i
    year = date[2].to_i
    start_date = DateTime.new(year,month,day)
    return start_date
  end

end
