Then /^the field "([^\"]*)" should have the error "([^"]*)"$/ do |field, error_message|

 element = find_field(field)

  if page.respond_to?(:should)
    page.should have_content("#{error_message}")
  end

end

