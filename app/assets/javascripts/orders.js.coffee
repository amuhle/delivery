$( -> 
    $('#product_price').iMask(type: 'number')
    $('#product_quantity').iMask(type: 'number')
    $.datepicker.setDefaults($.datepicker.regional['fr'])
    $('#begin_date').datepicker()
    $('#end_date').datepicker()
    false
)
jQuery ->
  $('#product_name').autocomplete
    source: $('#product_name').data('autocomplete-source') 
    select: (event,ui) ->
      $("#product_price").val(ui.item.price)
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
  
  displayAlert = (mensaje) ->
    $('#alert').attr('style','display:block')
    $('#error_message').text("#{mensaje}")

  validateAddedProduct = (prod_id)->
    valid = true
    products = $('table#tableProducts tr')
    if products.length > 1
      for pr in products
        pr_id = parseInt(pr.id)
        if pr_id == prod_id
          displayAlert('The product is already added')
          resetFields()
          valid = false
    valid

  validateProduct =(idProduct,product,quantity,price) ->
    ret = true
    if product is ""
      displayAlert("Must choose a prudct")
      ret = false
    else if idProduct == ""
      displayAlert("the product #{product} is not registered")
      ret = false
    else if quantity == 0
      displayAlert("The quantity must be greater than 0")
      ret = false
    else if price == 0
      displayAlert("The price must be greater than 0")
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
    
  $("#btn_create_client").click displayModal

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
        $('#id_client').val("#{json.id}")
        $('#search_client_name').val("#{json.name}")
        $('#order_delivery_address').val("#{json.address}")
        resetClientFields()
        $("#modalNewClient").modal('hide')
        false

  $('#save_client').click saveClient

  $('table#tableProducts').on("click",".btn.btn-link",removeProductFromOrder)
  
  showClientName = ->
    $('#content_client_name').attr('style','display:block')
    $('#content_client_phone').attr('style','display:none')
    $('#order_final_client').attr('style','display:none')
    $('#phone_client_name').attr('style','display:none')
    $('#search_client_name').val('')
    $('#phone_client_name').val('')
    $('#order_final_client').val('')
  
  $("#option_name").click showClientName

  showClientPhone = -> 
    $('#content_client_name').attr('style','display:none')
    $('#content_client_phone').attr('style','display:block')
    $('#order_final_client').attr('style','display:none')
    $('#search_client_name').val('')
    $('#phone_client_name').val('')
    $('#order_final_client').val('')
    $('#id_client').val('')
    $('#phone_client_name').attr('style','display:none')
  
  $("#option_phone").click showClientPhone

  showFinalClient = -> 
    $('#content_client_name').attr('style','display:none')
    $('#content_client_phone').attr('style','display:none')
    $('#order_final_client').attr('style','display:block')
    $('#search_client_name').val('')
    $('#phone_client_name').val('')
    $('#order_final_client').val('')
    $('#phone_client_name').attr('style','display:none')
  
  $("#option_final_client").click showFinalClient

  $('#search_client_name').autocomplete
    source: $('#search_client_name').data('autocomplete-source') 
    select: (event,ui) ->
      $('#id_client').val(ui.item.id)
      $('#order_delivery_address').val(ui.item.address)

  searchClient = (event) ->
    event.preventDefault()
    phone = parseInt($('#client_phone_number').val())
    if $.isNumeric(phone)
      $.ajax
        type: 'get'
        url: '/clients/get_by_phone'
        data: {phone_number: phone}
        datatype: 'json'
        success:(json) ->
          $('#id_client').val("")
          $('#phone_client_name').text("")
          $('#phone_client_name').attr('style','display:none')
          if json[0] != undefined 
            $('#id_client').val("#{json[0].id}")
            $('#phone_client_name').text("#{json[0].name}")
            $('#order_delivery_address').val("#{json[0].address}")
            $('#phone_client_name').attr('style','display:block,height:100px,width:100px')
            $('#phone_client_name').attr('class', 'label label-info')
          else
            $('#phone_client_name').text("Unregistered client")
            $('#phone_client_name').attr('style','display:block,height:100px,width:100px')
            $('#phone_client_name').attr('class', 'label label-important')

  $('#btn_search_client').click searchClient
