Given /^the following race teams exist:/ do |table|
  table.hashes.each do |row|
    team = Team.make_unsaved({
      :name => row["Name"],
      :category => row["Class"],
    })

    team.riders.build Rider.plan(:name => row["Leader Name"], :email => row["Leader Email"])
    team.riders.build Rider.plan(:email => row["Rider 1 Email"]) if row["Rider 1 Email"].present?
    team.riders.build Rider.plan(:email => row["Rider 2 Email"]) if row["Rider 2 Email"].present?

    team.save!
  end
end

Then /^I should see the following teams:$/ do |table|
  tableish = find("table").all("tr").map { |row| row.all("th, td").map { |cell| cell.text.strip }[0..-2] }
  table.diff! tableish
end

Then /^I should see (\d+|no) teams?$/ do |count|
  if %w(0 no).include? count
    page.should_not have_css("table.list tbody tr")
  else
    page.should have_css("table.list tbody tr", :count => count.to_i)
  end
end

When /^I fill in "([^\"]*)" with "([^\"]*)" for "([^\"]*)"$/ do |field, value, label|
  within racer_selector(label) do
    fill_in field, :with => value
  end
end

When /^I select "([^\"]*)" from "([^\"]*)" for "([^\"]*)"$/ do |value, field, label|
  within racer_selector(label) do
    select value, :from => field
  end
end

When /^I select "([^\"]*)" as the "([^\"]*)" date for "([^\"]*)"$/ do |value, field, label|
  within racer_selector(label) do
    select_date value, :from => field
  end
end

When /^I check "([^\"]*)" for "([^\"]*)"$/ do |field, label|
  within racer_selector(label) do
    check field
  end
end

When /^I uncheck "([^\"]*)" for "([^\"]*)"$/ do |field, label|
  within racer_selector(label) do
    uncheck field
  end
end

def racer_selector(label)
  "h1:contains('#{label}') + *" 
end
