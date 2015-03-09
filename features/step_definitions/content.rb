When(/^I fill "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, :with => value
end

When(/^I click on button "(.*?)"$/) do |button|
  click_button button
end

Then(/^I should see "(.*?)" with text "(.*?)"$/) do |selector, text|
  within(selector) { expect(page).to have_content(text)  }
end