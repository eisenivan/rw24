module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step_fragment, parent|
  with_scope(parent) { step step_fragment }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step_fragment, parent, table_or_string|
  with_scope(parent) { step "#{step_fragment}:", table_or_string }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I press "(.*?)"$/ do |button|
  click_button button
end

When /^I follow "(.*?)"$/ do |link|
  click_link link
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, with: value
end

When /^I fill in "(.*?)" with the following:$/ do |field, value|
  fill_in field, with: value
end

When /^I fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    fill_in name, with: value
  end
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select value, :from => field
end

When /^I check "(.*?)"$/ do |field|
  check field
end

When /^I uncheck "(.*?)"$/ do |field|
  uncheck field
end

When /^I choose "(.*?)"$/ do |field|
  choose field
end

When /^I attach the file "(.*?)" to "(.*?)"$/ do |path, field|
  attach_file field, "features/support/fixtures/#{path}"
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "(.*?)"$/ do |text|
  page.should_not have_content(text)
end

Then /^show me the page$/ do
  save_and_open_page
end

