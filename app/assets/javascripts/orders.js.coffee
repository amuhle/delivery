$( -> 
    $('#product_price').iMask(type: 'number')
    $('#product_quantity').iMask(type: 'number')
    false
)
jQuery ->
  $('#product_name').autocomplete
    source: $('#product_name').data('autocomplete-source') 
    select: (event,ui) ->
      $("#product_price").val(ui.item.price).iMask(type: 'number')
      $("#product_quantity").val('1')
      $("#product_id").val(ui.item.id)
      $("#product_name").focus()
  
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

  validateAddedProduct = (prod_id)->
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

  validateProduct =(idProduct,product,quantity,price) ->
    ret = true
    if product is ""
      alert "Must choose a prudct"
      ret = false
    else if idProduct == ""
      alert "the product #{product} is not registered"
      ret = false
    else if quantity == 0
      alert "The quantity must be greater than 0"
      ret = false
    else if price == 0
      alert "The price must be greater than 0"
      ret = false
    else 
      ret = validateAddedProduct(idProduct)
    ret

  addProductToOrder = (event) ->
    event.preventDefault()
    event.stopPropagation()
    product = $('#product_name').val()
    quantity = $('#product_quantity').val()
    quantity = parseFloat(quantity.replace(",",""))
    price = $('#product_price').val()
    price = parseFloat(price.replace(",",""))
    total = parseFloat($("#total").text())
    if not $.isNumeric(total)
      total = 0
    prod_id = $('#product_id').val()
    validator = validateProduct(prod_id,product,quantity,price)
    if validator
      prod_id = parseInt(prod_id)
      subtotal = price * quantity
      $('table#tableProducts tr:last').after("<tr id='#{prod_id}'><td class='span4'>#{product}</td><td class='span4'>#{quantity}</td><td class='span4'>#{price}</td><td class='span4'>#{subtotal}</td><td class='span4'><a class='btn btn-link' id='#{prod_id}'>eliminar</a></td><td><input type='hidden' name='prod_ord-#{prod_id}' value='#{quantity}-#{price}'/></td></tr>")
      $('table#tableProducts').on("click","a##{prod_id}",removeProductFromOrder)
      total = total + subtotal
      updateTotal total
      resetFields()

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
    
  $("#btnCreateClient").click displayModal

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
        false

  $('#save_client').click saveClient

  $('table#tableProducts').on("click",".btn.btn-link",removeProductFromOrder)
  
  showClientName = -> 
    $('#client_name').style.display="block"
    $('#client_phone').style.display="none"
  
  $('#fieldset_client').on("selected", "#option_name",showClientName)
