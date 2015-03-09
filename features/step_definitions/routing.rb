Given(/^I am on the sign up page$/) do
  visit '/users/new'
end

Then(/^show me the page$/) do
  save_and_open_page
end