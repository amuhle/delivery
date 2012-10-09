jQuery ->
  $('#product_name').autocomplete
    source: $('#product_name').data('autocomplete-source') 
    select: (event,ui) ->
      $("#product_price").val(ui.item.price)
      $("#product_quantity").val('1')
      $("#product_id").val(ui.item.id)
      $("#produvt_name").focus()
  
  updateTotal = (total) ->
    $('#total').fadeOut()
    $('#total').text(total.toString())
    $('#total').fadeIn()
    $('#total_hd').val(total.toString()) 
  
  resetFields = ->
    $('#product_name').val('')
    $('#product_price').val('')
    $('#product_quantity').val('')
    $('#product_id').val('')
    $('#product_name').focus()
 
  resetClientFields = -> 
    $('#client_name').val('')
    $('#client_rut').val('')
    $('#client_contact').val('')
    $('#client_address').val('')
    $('#client_email').val('')
    $('#client_phone').val('')

  validateProduct = (prod_id)->
    valid = true
    products = $('table#tableProducts tr')
    if products.length > 1
      for pr in products
        pr_id = parseInt(pr.id)
        if pr_id == prod_id
          alert 'Producto ya fue agregado a la orden'
          resetFields()
          valid = false
    valid

  addProductToOrder = (event) ->
    event.preventDefault()
    event.stopPropagation()
    product = $('#product_name').val()
    total = parseInt($("#total").text())
    if product != ""
      prod_id = $('#product_id').val()
      if prod_id isnt ""
        prod_id = parseInt(prod_id)
        # obtengo la cantidad y el precio
        quantity = parseInt($('#product_quantity').val())
        price = parseInt($('#product_price').val())
        subtotal = price * quantity
        agrego = validateProduct(prod_id)
        if agrego == true
          $('table#tableProducts tr:last').after("<tr id='#{prod_id}'><td class='span4'>#{product}</td><td class='span4'>#{quantity}</td><td class='span4'>#{price}</td><td class='span4'>#{subtotal}</td><td class='span4'><a class='btn btn-link' id='#{prod_id}'>eliminar</a></td><td><input type='hidden' name='prod_ord-#{prod_id}' value='#{quantity}-#{price}'/></td></tr>")
          $('table#tableProducts').on("click","a##{prod_id}",removeProductFromOrder)
          total = total + subtotal
          updateTotal total
          resetFields()
      else
        alert "El producto #{product} no está registrado"
        resetFields()
    else 
      alert("Debe ingresar un producto")
    false
  
  $('#btn_add_product').click addProductToOrder

  removeProductFromOrder = (event) ->
    event.preventDefault()
    event.stopPropagation()
    total = parseInt($('#total').text())
    selected_row = ($(this).parent()).parent()
    selected_row_id = selected_row.attr('id')
    subtotal = parseInt($("tr##{selected_row_id} td:eq(3)").text())
    total = total - subtotal
    updateTotal total
    selected_row.remove()
    false
  
  displayModal = ->
    $("#modalNewClient").modal(show: true,keyboard: true,backdrop: true)
    
  $("a#btnCreateClient").click displayModal

  saveClient = (event) ->
    event.preventDefault()
    name = $('#client_name').val()
    rut = $('#client_rut').val()
    contact = $('#client_contact').val()
    address = $('#client_address').val()
    email = $('#client_email').val()
    phone = $('#client_phone').val()

    $.ajax
      type: 'post'
      url: 'new_client'
      data: {client: {name: name,rut: rut,address: address,contact: contact, email: email, phone: phone}}
      datatype: 'json'
      success:(json) ->
        $('#order_client_id >:last').after("<option value=#{json.id}>#{json.name}</option>")
        $('#order_client_id >:last').attr('selected',true)
        resetClientFields()
        $("#modalNewClient").modal('hide')

  $('#save_client').click saveClient

  $.validator.setDefaults({
    debug: true,
    success: "valid"
    })

  validateProduct = ->
    errors = $("#fr_product").validate({
        rules: {
          'product_name': required: true
          'product_price': {required: true,number: true}
          'product_quantity':{required:true,number: true }
        }
        messages:{
          'product_name':{required: 'Debe ingresrar un producto'}
          'produc_price':{required:'Debe ingresar un precio',number: 'El precio debe ser un número'}
          'produc_qauntity':{required: 'La cantidad debe ser numerica',number: 'La cantidad debe ser un número'}
        }
      debug: true,
        #/*errorElement: 'div',*/
        #//errorContainer: $('#errores'),
        #submitHandler: validateProduct(form){
        #alert('El formulario ha sido validado correctamente!')}
      })
      alert errors

  

    

