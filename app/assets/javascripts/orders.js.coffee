jQuery ->
  $('#product_name').autocomplete
    source: $('#product_name').data('autocomplete-source') 
    select: (event,ui) -> $("#product_price").val(ui.item.price)
  $('#btn_add_product').click
    
