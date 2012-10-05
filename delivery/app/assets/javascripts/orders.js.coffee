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

$(document).ready () -> 
  $('#modalNewClient').modal('hiden')



