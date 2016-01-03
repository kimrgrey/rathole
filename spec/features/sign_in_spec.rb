require "rails_helper"

describe "sign in", :type => :feature, :js => true do
  fixtures :users

  it "should redirect to events page for correct email and password" do
    visit '/users/sign_in'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "tom@example.com"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    click_button I18n.t("devise.sessions.new.submit")

    expect(page.current_path).to eq("/user/events")
  end

  it "should show error message for wrong email" do
    visit '/users/sign_in'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "wrongemail@example.com"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    click_button I18n.t("devise.sessions.new.submit")

    expect(page.current_path).to eq("/users/sign_in")
    expect(page).to have_content(I18n.t("devise.failure.invalid"))
  end

  it "should show error message for wrong password" do
    visit '/users/sign_in'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "tom@example.com"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "wrongpassword"
    click_button I18n.t("devise.sessions.new.submit")

    expect(page.current_path).to eq("/users/sign_in")
    expect(page).to have_content(I18n.t("devise.failure.invalid"))
  end
end
